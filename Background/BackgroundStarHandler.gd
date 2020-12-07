extends Node2D
# resizing sometimes shows blank sections along a wall, probably monitor scaling issue, low prio, needs investigation

const NUMBEROFBACKGROUNDSTARS = 300

var rng = RandomNumberGenerator.new()
var screenSize
var screenSizeHalf

var particleStarScene = load("res://Background/BackgroundStarScene.tscn")
var particleStarNode
var staticStarScene = load("res://Background/BackgroundStaticStar.tscn")
var staticStarNode
var animatedStarScene = load("res://Background/BackgroundAnimatedStar.tscn")
var animatedStarNode

func _ready():
	yield(get_tree(), "idle_frame")  # Resume execution on the next frame.
	# Not necessary here, but might be useful for delaying until other notes initialise
	
	rng.randomize()
	screenSize = get_viewport().get_visible_rect().size
	screenSizeHalf = screenSize / 2
	Globals.screenSize = screenSize
	Globals.playerCameraScreenCenter = get_node("../Player/PlayerCamera").get_camera_screen_center()
	
	print('screen size half: ', screenSizeHalf)
	
	createBackgroundStars(particleStarScene, particleStarNode)
	createBackgroundStars(staticStarScene, staticStarNode)
	createBackgroundStars(animatedStarScene, animatedStarNode)
	

func createBackgroundStars(starScene, starNode):
	for i in NUMBEROFBACKGROUNDSTARS / 3:
		starNode = starScene.instance()
		starNode.position = Globals.playerCameraScreenCenter + Vector2(rng.randi_range(screenSizeHalf[0]* -1, screenSizeHalf[0]), rng.randi_range(screenSizeHalf[1] * -1, screenSizeHalf[1]))
		starNode.scale = Vector2(rand_range(0.5, 1), rand_range(0.5, 1))
		#color variation - needs tweaking
		#starNode.modulate = Color(1, rand_range(0.8, 1), rand_range(0, 0.8))
		add_child(starNode)

