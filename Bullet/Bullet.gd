extends KinematicBody2D

var collidedWith
var motion = Vector2(0,0)
var currMovespeed = 100
var state = 'New'

func _ready():
	pass

func _process(delta):
	
	motion = motion.normalized() * currMovespeed
	
	collidedWith = move_and_collide(motion*delta)
	if (collidedWith != null) and (state != 'Exploding'):
		print('Bullet hit!')
		$Timer.start()
		state = 'Exploding'
		$ExplosionParticles.emitting = true
		#$Shape.disabled = true
		
	if Globals.despawnBullet(self.position):
		self.queue_free()


func _on_Timer_timeout():
	print('TimeOut')
	self.queue_free()
