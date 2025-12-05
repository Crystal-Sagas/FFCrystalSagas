atom
	movable
		// Remove this from the contents of it's loc before deleting so any containers are updated
		Del()
			if(isTurf(loc))
				loc.contents.Remove(src)
			..()

		proc
			relocate(_x, _y, _z)
				if(!isNumber(_x) || !isNumber(_y) || !isNumber(_z))
					return FALSE
				if(isMovable(loc))
					var/atom/movable/_movable = loc
					_movable.removeFromContents(src)
				var/atom/atom = locate(_x, _y, _z)
				if(!atom)
					return FALSE
				if(isMovable(atom))
					var/atom/movable/_movable = atom
					_movable.addToContents(src)
				else if(isAtom(atom))
					// For most objects, simply set the location instead of adding to contents
					// This is the proper way to move objects to turfs
					loc = atom
				else
					return FALSE
				return TRUE

			relocateTo(var/atom/atom, _step_x, _step_y)
				if(!isAtom(atom))
					return FALSE
				if(isMovable(loc))
					var/atom/movable/_movable = atom
					_movable.removeFromContents(src)
				else if(isTurf(loc))
					loc.contents.Remove(src)
				if(isMovable(atom))
					var/atom/movable/_movable = atom
					_movable.addToContents(src)
				else
					atom.contents.Add(src)
				if(isPositiveNumber(_step_x))
					step_x = _step_x
				if(isPositiveNumber(_step_y))
					step_y = _step_y
				return TRUE

			relocateToType(type)
				if(!isPath(type))
					return FALSE
				if(isMovable(loc))
					var/atom/movable/_movable = loc
					_movable.removeFromContents(src)
				else if(isTurf(loc))
					loc.contents.Remove(src)
				loc = locate(type)
				return TRUE

			relocateToNull()
				if(isTurf(loc))
					loc.contents.Remove(src)
				if(isMovable(loc))
					var/atom/movable/_movable = loc
					_movable.removeFromContents()
					loc = null
				else
					loc = null
				return TRUE
			
			relocateToPixloc(pixloc/_pixloc)
				if(!isPixloc(_pixloc))
					return
				if(isTurf(_pixloc.loc))
					relocateTo(pixloc.loc, _pixloc.step_x, _pixloc.step_y)
				return TRUE
