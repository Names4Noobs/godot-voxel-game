extends VoxelGeneratorScript


const channel : int = VoxelBuffer.CHANNEL_TYPE


func _get_used_channels_mask() -> int:
	return 1 << channel


func _generate_block(buffer: VoxelBuffer, origin: Vector3i, lod: int) -> void:
	if lod != 0:
		return
	
	# Fill one chunk down
	if origin.y < 0 and origin.y > -17:
		# Fill grass block for top layer
		buffer.fill_area(2, Vector3i(0,15,0), Vector3i(16,16,16))
		buffer.fill_area(1, Vector3i(0,10,0), Vector3i(16,15,16))
		buffer.fill_area(7, Vector3i.ZERO, Vector3i(16,10,16))
	elif origin.y < -16 and origin.y > -33:
		buffer.fill(8, channel)
	elif origin.y < -32 and origin.y > -49:
		buffer.fill(9, channel)
	elif origin.y < -48 and origin.y > -65:
		buffer.fill(10, channel)
	elif origin.y < -64 and origin.y > -87:
		buffer.fill(11, channel)
	elif origin.y < -86 and origin.y > -103:
		buffer.fill(12, channel)

	if origin.x < 0 and origin.x > -17:
		if origin.y < 0 and origin.y > -17:
			buffer.fill_area(4, Vector3i.ZERO, Vector3i(16,16,16))
