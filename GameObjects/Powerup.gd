extends Area2D
# INHERIT TYPES OF PICKUPS

func _ready():
	pass # Replace with function body.

#func _process(delta):
#	pass

func _on_Pickup_body_entered(body):
	if body.name == "Player":
		#$PickupAnimation.play("Pickup")
		print('powerup picked up!')
		self.queue_free()
