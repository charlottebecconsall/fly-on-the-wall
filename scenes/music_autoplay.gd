extends AudioStreamPlayer


func play_file(file : String):
	if stream.resource_path != file:
		stream = load(file)
		play()
