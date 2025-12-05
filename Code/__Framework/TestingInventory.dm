
proc/RenderInventoryTest(mob/source)
	var/html = {"
		<html>
			<head>
				<title>Inventory Test</title>
				<style type="text/css">
					body {
						font-family: "Segoe UI";
						color: #CCC;
						background-color: #222233;
						overflow-x: hidden;
					}
					.grid-container {
						display: flex;
						flex-direction: column;
					}
					.row {
						width: 100%;
						display: flex;
						flex-wrap: wrap;
						justify-content: start;
						border-radius: 5px;
						margin-bottom: 2px;
						background-color: #333344;
					}
					.inventory-grid-icon {
						border-left: 1px solid #BBBBCC;
						border-top: 1px solid #BBBBCC;
						border-right: 1px solid #888899;
						border-bottom: 1px solid #888899;
						border-radius: 3px;
						margin: 0 2px 2px 0;
					}
					.inventory-grid-icon:hover {
						background-color: #444455;
					}
					.inventory-grid-desc {
						padding-left: 2px;
						display: flex;
						align-items: center;
					}
					#refresh {
						border: 2px solid #555577;
						border-radius: 5px;
						background-color: #444466;
						color: #CCC;
						margin-bottom: 5px;
					}
					#source-inventory-ref {
						visibility: hidden;
						height: 0px;
					}
					.tooltip {
						position: relative;
						display: inline-block;
					}
					.tooltip .tooltip-text {
						visibility: hidden;
						background-color: #111;
						color: #EEE;
						text-align: center;
						border-radius: 6px;
						width: 200px;
						padding: 8px;
						position: absolute;
						z-index: 1;
						pointer-events: none;
					}
					.tooltip .tooltip-text h5 {
						padding: 0;
						margin: 0;
						font-size: 16px;
					}
					.tooltip .tooltip-text h5 span {
						font-size: 14px;
					}
					.tooltip:hover .tooltip-text  {
						visibility: visible;
					}
					.tooltip:hover .tooltip-text span {
						font-size: 12px;
					}
				</style>
				<script type="text/javascript">
					const sourceRef = '\ref[source]';
					const updateGrid = () => {
						window.location = 'byond://?src=' + sourceRef + ';action=refresh_inventory';
					};
				</script>
			</head>
			<body>
				<button id="refresh" onclick="updateGrid()">Refresh</button>
				<div id="grid-container" className="grid-container">
					<div class="row">
	"}

	html += GenerateInventoryRows(source)

	html += {"
					</div>
				</div>
			</body>
		</html>
	"}

	source << browse(html, "window=InventoryTest.InventoryTestBrowser;size=500x300")

proc/GenerateInventoryRows(mob/source)
	if(!ismob(source))
		return ""
	var/html = ""
	for(var/atom/movable/a in source.getContainer("inventory").contents)
		html += {"
			<div class="inventory-grid-icon tooltip">
				<img src='\ref[a]' />
				<span class="tooltip-text">
					<h5>[a.name] <span>[a.suffix]</span></h5>
					<span>
						[a.desc]
					</span>
				</span>
			</div>
		"};
	return html

proc/MaxItemSlots(mob/source)
	if(!ismob(source))
		return 0
	var/extra = source.HasBelt
	if(findtext(source.Race, "Tuffle"))
		extra += 5
	return source.inventorySlots * (1 + source.IsFusion) + extra

proc/CurrentItemSlots(mob/source)
	if(!ismob(source))
		return 0
	var/itemSlotCount = 0
	for(var/atom/movable/a in source.getContainer("inventory"))
		if(!istype(a, /obj/items/Clothes))
			itemSlotCount++
	return itemSlotCount

proc/DropExcessItems(mob/source)
	if(!ismob(source))
		return 0
	if(!isturf(source.loc))
		return 0
	var/maxItemCount = MaxItemSlots(source)
	var/itemSlotCount = CurrentItemSlots(source)
	if(itemSlotCount <= maxItemCount)
		return 0
	var/inventoryCount = length(source.getContainer("inventory").contents)
	for(var/x=inventoryCount, x >= 1, x--)
		var/atom/movable/a = source.getContainer("inventory")[x]
		if(istype(a, /obj/items/Clothes) || !istype(a, /obj/items))
			continue
		var/obj/items/o = a
		if(!o.suffix || o.Can_Drop_With_Suffix)
			DropItem(source, o)


proc/DropItem(mob/source, atom/movable/a)
	if(!ismob(source) || !istype(a))
		return FALSE
	// Tell Players

	// Log and drop the item
	source.saveToLog("| | ([source.x], [source.y], [source.z]) | [key_name(source)] drops [a] due to inventory constraints.\n")
	source.removeOverlay(a.icon)
	a.relocateTo(source.loc)
	step_to(a, source.dir)
	a.dir = SOUTH

	// Update inventory via trigger

	return TRUE

mob
	Topic(href, href_list)
		..()
		if(href_list["action"] == "refresh_inventory")
			RenderInventoryTest(src)