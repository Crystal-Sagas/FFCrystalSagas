/* Guide
	The containerTags list is meant as a group of identifiers for where a datum should show up in any potential containers
	If this datum shouldn't appear in any containers, leave the list uninitialized
	In other words, don't add a list to to the variable
	When you do want to add a tag, initialize the list and use text identifiers
	These identifiers should be uniform, so things that are grouped should share an exact tag
	Datums can have more than one tag to show up in multiple containers
	Individual datums only need one common tag to appear in a respective container with each other

	The containers alist should only be initialized as needed
*/

datum
	var/list/containerTags
	var/tmp/list/Container/containers

	proc
		addContainer(name)
			if(!isNonEmptyText(name))
				return FALSE
			if(!isAlist(containers))
				containers = alist()
			// SAFETY: Don't overwrite existing containers to prevent inventory loss
			if(containers[name] && isContainer(containers[name]))
				return TRUE // Container already exists, don't reinitialize
			containers[name] = Container(src)

			return TRUE
		
		addToContainers(datum/datum)
			if(!isDatum(datum))
				return FALSE
			if(!isAlist(containers))
				return FALSE
			if(!isList(datum.containerTags) || !(datum.containerTags.len > 0))
				return FALSE
			for(var/tag in datum.containerTags)
				if(!hasContainer(tag))
					continue
				var/Container/container = getContainer(tag)
				container += datum
			return TRUE
		
		removeFromContainers(datum/datum)
			if(!isDatum(datum))
				return FALSE
			if(!isAlist(containers))
				return FALSE
			if(!isList(datum.containerTags) || !(datum.containerTags.len > 0))
				return FALSE
			for(var/tag in datum.containerTags)
				if(!hasContainer(tag))
					continue
				var/Container/container = getContainer(tag)
				container -= datum
			return TRUE
		
		hasContainer(name)
			if(!isNonEmptyText(name))
				return FALSE
			if(!isAlist(containers))
				return FALSE
			return isContainer(containers[name])
		
		getContainer(name)
			if(!hasContainer(name))
				return FALSE
			return containers[name]
			
