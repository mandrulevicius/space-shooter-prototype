extends Control



func _on_MenuButton_button_up():
	Globals.game_state = "Restarted"
	get_tree().paused = false
