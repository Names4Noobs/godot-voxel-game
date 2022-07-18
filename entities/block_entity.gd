extends RigidDynamicBody3D

var type = -1

func interact() -> bool:
	match type:
		Util.BlockEntity.CRAFTING:
			print("This should open some sort of menu!")
		Util.BlockEntity.FURNACE:
			print("This should smelt!")
		Util.BlockEntity.TNT:
			Signals.emit_signal("create_explosion", self.position, 10)
		_:
			print("Block entity type unrecognized!")
	return true
