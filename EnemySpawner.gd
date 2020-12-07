extends Node2D

var i = 0
var rng = RandomNumberGenerator.new()

var LaserEyeScene = load("res://GameObjects/LaserEye.tscn")
var LaserEyeNode

var screenSizeHalf

func _ready():
	yield(get_tree(), "idle_frame") # lets Globals initialize screen size
	rng.randomize()
	screenSizeHalf = Globals.screenSize / 2

func _process(delta):
	i += 1
	if i >= 300:
		i = 0
		LaserEyeNode = LaserEyeScene.instance()
		if rng.randi_range(0, 1) == 1:
			LaserEyeNode.position = Globals.playerCameraScreenCenter + Vector2(
				rng.randi_range(screenSizeHalf[0], Globals.screenSize[0])*pow(-1, rng.randi_range(0, 1)), 
				rng.randi_range(0, screenSizeHalf[1])*pow(-1, rng.randi_range(0, 1)))
		else:
			LaserEyeNode.position = Globals.playerCameraScreenCenter + Vector2(
				rng.randi_range(0, screenSizeHalf[0])*pow(-1, rng.randi_range(0, 1)), 
				rng.randi_range(screenSizeHalf[1], Globals.screenSize[1])*pow(-1, rng.randi_range(0, 1)))
		add_child(LaserEyeNode)
