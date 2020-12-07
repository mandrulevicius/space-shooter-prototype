extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if delta != 0:
		self.text = "FPS: " + str(Engine.get_frames_per_second()) + "\n" + "Delta FPS: " + str(1/delta)
