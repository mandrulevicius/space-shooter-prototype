extends Node2D

var i = 0
var rng = RandomNumberGenerator.new()

var RockScene = load("res://GameObjects/Rock.tscn")
var RockNode

var screenSizeHalf

func _ready():
	yield(get_tree(), "idle_frame") # lets Globals initialize screen size
	rng.randomize()
	screenSizeHalf = Globals.screenSize / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	i += 1
	if i >= 300:
		i = 0
		RockNode = RockScene.instance()
		RockNode.scale = Vector2(1, 1) * rand_range(0.5, 1)
		# can spawn from playerpos - screenSizeHalf - 100 (avoid showing at the edge) to playerpos - screensize
		# avoid edges in later release
		if rng.randi_range(0, 1) == 1:
			RockNode.position = Globals.playerCameraScreenCenter + Vector2(
				rng.randi_range(screenSizeHalf[0], Globals.screenSize[0])*pow(-1, rng.randi_range(0, 1)), 
				rng.randi_range(0, screenSizeHalf[1])*pow(-1, rng.randi_range(0, 1)))
		else:
			RockNode.position = Globals.playerCameraScreenCenter + Vector2(
				rng.randi_range(0, screenSizeHalf[0])*pow(-1, rng.randi_range(0, 1)), 
				rng.randi_range(screenSizeHalf[1], Globals.screenSize[1])*pow(-1, rng.randi_range(0, 1)))
		# better, but still weird how rocks spawn where you have previously seen to be empty space
		# procedurally generate chunks, while ignoring already generated areas?
		# maybe, but sounds like a lot of work. Might be good proc gen practice
		# or could just do rocks that constantly increase or decrease in size, immitating them moving through z dimension.
		# for now, leave as is, will come back to it after essentials - V0.01 release
		add_child(RockNode)
