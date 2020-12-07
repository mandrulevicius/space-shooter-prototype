extends Node

var frameCount = 0

var menu_scene = load("res://UI/MainMenu.tscn")
var menu_node

var game_scene = load("res://MainGame.tscn")
var game_node

var game_over_scene = load("res://UI/GameOver.tscn")
var game_over_node

func _ready():
	Globals.game_state = "New"


func _process(delta):
	frameCount += 1
	if frameCount == 120:
		#print('Globals.playerCameraPosition', Globals.playerCameraPosition)
		#print('$Player/PlayerCamera.get_camera_screen_center()', $Player/PlayerCamera.get_camera_screen_center())
		frameCount = 0
		
	if Globals.game_state == "New":
		game_node = game_scene.instance()
		game_node.visible = false
		add_child(game_node)
		menu_node = menu_scene.instance()
		add_child(menu_node)
		Globals.game_state = "MainMenu"
		get_tree().paused = true
		
	if Globals.game_state == "Resumed":
		menu_node.queue_free()
		game_node.visible = true
		Globals.game_state = "In progress"

	if Globals.game_state == "Paused":
		game_node.visible = false
		menu_node = menu_scene.instance()
		#menu_node.rect_position = Globals.playerCameraScreenCenter - Globals.halfScreenSize #fixed by CanvasLayer
		add_child(menu_node)
		Globals.game_state = "MainMenu"
		get_tree().paused = true
		
	if Globals.game_state == "Over":
		game_over_node = game_over_scene.instance()
		add_child(game_over_node)
		Globals.game_state = "GameOver"
		get_tree().paused = true
		
	if Globals.game_state == "Restarted":
		game_over_node.queue_free()
		game_node.queue_free()
		game_node = game_scene.instance()
		game_node.visible = false
		add_child(game_node)
		menu_node = menu_scene.instance()
		add_child(menu_node)
		Globals.game_state = "MainMenu"
		get_tree().paused = true
		
	if Globals.game_state == "Quit":
		get_tree().quit()
