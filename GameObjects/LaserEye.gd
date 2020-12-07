extends KinematicBody2D

var motion = Vector2(0,0)
var collidedWith
var health
var bulletHitList = ['DummyBullet']  # might be unnecessary, but was a reason why added it

var damageSparkScene = load("res://Sparks.tscn")
var damageSparkNode

var targetPosition

func _ready():
	health = 3


func _process(delta):
	collidedWith = move_and_collide(motion*delta)
	if collidedWith != null:
		#print('Eye hit by ', collidedWith.get_collider().get_name())
		if collidedWith.get_collider().get_name() == "Player":
			print('Eye impact!')
			reduceHealth()
		if ("Bullet" in collidedWith.get_collider().get_name()) and (not bulletHitList.has(collidedWith.get_collider().get_instance_id())):
			print('Eye hurt by %s, %s' % [collidedWith.get_collider().get_name(), collidedWith.get_collider().get_instance_id()])
			bulletHitList.append(collidedWith.get_collider().get_instance_id())
			reduceHealth()
			
	if (health <= 0) and ($EyeExplosionParticle.emitting == false):
		self.queue_free()
		
	searchForTarget()

func reduceHealth():
	health -= 1
	if health == 2:
		$EyeSprite.self_modulate = Color('ff0000')
		damageSparkNode = damageSparkScene.instance()
		damageSparkNode.position = Vector2(0, 0)
		add_child(damageSparkNode)
	if health == 1:
		$EyeSprite.self_modulate = 'aa2929'
		damageSparkNode.queue_free()
	if health == 0:
		$EyeExplosionParticle.emitting = true  #issue, might want to branch a scene here
		$EyeSprite.self_modulate = Color(1,1,1,0)
		$EyeShape.disabled = true
		# send signal to  directly increase stats or to create Pickup
		Globals.update_player_stats({"Size":1.00}) # can pass whole dictionary of different stats

func searchForTarget():
	targetPosition = Vector2(0,0)
	if $EyeLaser.get_point_count() > 1:
		$EyeLaser.remove_point(1)
		$EyeLaser/EyeLaserImpact.emitting = false
		
	self.rotation += 0.001
	
	targetPosition = $EyeVision.get_collision_point()

	if $EyeVision.get_collider():
		if $EyeLaser.get_point_count() == 1:
			$EyeLaser.add_point(to_local(targetPosition))
			$EyeLaser/EyeLaserImpact.position = to_local(targetPosition)
			$EyeLaser/EyeLaserImpact.emitting = true
			
		$EyeVision.get_collider().reduceHealth()
	
	# logging
	#if Input.is_action_just_released("ui_rightclick"):
	#	Globals.save_log("-----------------------", "")
	#	Globals.save_log("Global Target Position: ", targetPosition)
	#	Globals.save_log("Global Mouse Position: ", get_global_mouse_position())
	#	Globals.save_log("Global Position Difference: ", get_global_mouse_position() - targetPosition)
	#	Globals.save_log("-----------------------", "")
	


func _on_VisibilityNotifier2D_screen_entered():
	if health == 0:
		self.queue_free()

