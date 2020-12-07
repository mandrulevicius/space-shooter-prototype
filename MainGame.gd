extends Node


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Globals.game_state == "In progress":
		if Input.is_action_just_released("ui_escape"):
			Globals.game_state = "Paused"
