extends KinematicBody2D

var motion = Vector2(0,0)
var collidedWith
var health
var bulletHitList = ['DummyBullet']  # might be unnecessary, but was a reason why added it

var damageSparkScene = load("res://Sparks.tscn")
var damageSparkNode

func _ready():
	health = 3


func _process(delta):
	collidedWith = move_and_collide(motion*delta)
	if collidedWith != null:
		#print('Rock hit by ', collidedWith.get_collider().get_name())
		if collidedWith.get_collider().get_name() == "Player":
			print('Rock impact!')
			reduceHealth()
		if ("Bullet" in collidedWith.get_collider().get_name()) and (not bulletHitList.has(collidedWith.get_collider().get_instance_id())):
			print('Rock hurt by %s, %s' % [collidedWith.get_collider().get_name(), collidedWith.get_collider().get_instance_id()])
			bulletHitList.append(collidedWith.get_collider().get_instance_id())
			reduceHealth()
			
	if (health <= 0) and ($RockExplosionParticle.emitting == false):
		self.queue_free()
		
	# despawn if too far from player
	if self.position.distance_to(Globals.playerCameraScreenCenter) > 2000:
		self.queue_free()

func reduceHealth():
	health -= 1
	print()
	if health == 2:
		$RockSprite.self_modulate = Color('ff0000')
		damageSparkNode = damageSparkScene.instance()
		damageSparkNode.position = Vector2(0, 0)
		add_child(damageSparkNode)
	if health == 1:
		$RockSprite.self_modulate = 'aa2929'
		damageSparkNode.queue_free()
	if health == 0:
		$RockExplosionParticle.emitting = true  #issue, might want to branch a scene here
		$RockSprite.self_modulate = Color(1,1,1,0)
		$RockShape.disabled = true
		# send signal to  directly increase stats or to create Pickup
		Globals.update_player_stats({"Size":1.00})


func _on_VisibilityNotifier2D_screen_exited():
	#GODOT pauses particle2D if it is invisible. Solution is to clean up 0 health objects after leaving the screen
	# doesnt work when screen is exited before health is 0
	if health == 0:
		self.queue_free()
	pass


func _on_VisibilityNotifier2D_screen_entered():
	#fixes issue when exited before heath is 0
	if health == 0:
		self.queue_free()
