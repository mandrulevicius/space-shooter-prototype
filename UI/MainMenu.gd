extends Node


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_released("ui_escape"):
		Globals.game_state = "Resumed"
		get_tree().paused = false


func _on_PlayButton_button_up():
	Globals.game_state = "Resumed"
	get_tree().paused = false


func _on_QuitButton_button_up():
	Globals.game_state = "Quit"
	get_tree().paused = false
