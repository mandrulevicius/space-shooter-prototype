extends Sprite

var halfScreenSize

func _ready():
	halfScreenSize = Globals.screenSize / 2
	$StarAnimation.playback_speed = rand_range(0.9, 1.1)

func _process(delta):
	self.position = Globals.moveBackgroundStar(self.position)
