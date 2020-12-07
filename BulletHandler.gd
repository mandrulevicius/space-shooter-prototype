extends Node2D

var lastOrderGlobalMousePos
var BulletScene = load("res://Bullet/Bullet.tscn")
var bulletSpeedMultiplier = 2

func _process(delta):
	if Input.is_action_pressed("ui_rightclick") and $BulletSpawnDelay.is_stopped():
		lastOrderGlobalMousePos = get_global_mouse_position()
		var BulletNode = BulletScene.instance()
		BulletNode.position = get_node("../Player/PlayerSprite2/TurretBarrel/MuzzlePosition").global_position
		if Globals.gunLock:
			BulletNode.motion = get_node("../Player/PlayerSprite2/TurretBarrel/MuzzlePosition").global_position - Globals.currentPlayerPosition
		else:
			BulletNode.motion = lastOrderGlobalMousePos - get_node("../Player/PlayerSprite2/TurretBarrel/MuzzlePosition").global_position 
			
		BulletNode.currMovespeed = BulletNode.currMovespeed * bulletSpeedMultiplier
		
		add_child(BulletNode)
		$BulletSpawnDelay.start()
		$BulletSpawnSound.play()
		get_node("../Player/PlayerSprite2/TurretBarrel/MuzzleFlashParticle").emitting = true
		get_node("../Player/PlayerSprite2/TurretBarrel/MuzzleFlashLight").enabled = true
		get_node("../Player/PlayerSprite2/TurretBarrel/MuzzleFlashLight/MFLightTimer").start()
		get_node("../Player/PlayerSprite2/TurretBarrel/MuzzleFlashLight/MFLightAnimation").play()
		get_node("../Player/PlayerSprite2/TurretBarrel/MuzzleFlashSprite/MFSpriteAnimation").play()
		#print('Bullet Spawned')



#var mouseButtonPressed = InputEventMouseButton
#func _input(event):
	# Mouse in viewport coordinates
	#if event is mouseButtonPressed.get_button_index() == 0:
#	if event is mouseButtonPressed:
#		print(get_viewport().get_mouse_position())
#		if mouseButtonPressed.button_index == 0:
#			print("Mouse Click/Unclick at: ", event.position)


func _on_Pickup_body_entered(body):
	bulletSpeedMultiplier = bulletSpeedMultiplier * 2
