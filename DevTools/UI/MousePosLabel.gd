extends Label

func _ready():
	pass # Replace with function body.


func _process(delta):
	self.text = "Global Mouse Position (sort of, from camera perspective): " + str(get_global_mouse_position())
