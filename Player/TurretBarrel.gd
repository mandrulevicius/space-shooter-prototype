extends Sprite

func _process(_delta):
	if not Globals.gunLock:
		self.look_at(get_global_mouse_position())

