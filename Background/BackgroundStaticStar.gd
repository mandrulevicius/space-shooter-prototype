extends Sprite

var halfScreenSize

func _ready():
	halfScreenSize = Globals.screenSize / 2

func _process(delta):
	self.position = Globals.moveBackgroundStar(self.position)
