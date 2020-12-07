extends Particles2D

var i = 99

func _ready():
	pass


func _process(delta):
	i += 1
	if i == 100:
		self.emitting = true
		#yield(get_tree().create_timer(self.lifetime*1.5), "timeout")
		#self.emitting = false
		i = 0
	
