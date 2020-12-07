extends KinematicBody2D

const BASE_MOVESPEED = 200

var movespeedMultiplier = 1
var maxMovespeed = BASE_MOVESPEED*movespeedMultiplier
var currMovespeed = 0
var currDirection = Vector2(0,0)
var motion = Vector2()

var player_stats = {}

var player_health = 1000

func _ready():
	pass

func _process(delta):
	move(delta)
	
	turretLock()
	
	Globals.currentPlayerPosition = self.position
	Globals.playerCameraScreenCenter = $PlayerCamera.get_camera_screen_center()
	
	
func move(delta):
	update_stats()
	
	$PlayerShape/ThrusterParticle.emitting = false
	if Input.is_key_pressed(KEY_W):
		if currMovespeed < maxMovespeed:
			currMovespeed += player_stats["Acceleration"]
		$PlayerShape/ThrusterParticle.emitting = true

	if Input.is_key_pressed(KEY_S):
		if currMovespeed > maxMovespeed * -1:
			currMovespeed -= player_stats["Acceleration"]

	if Input.is_key_pressed(KEY_A):
		# ONLY SPRITE AND SHAPE ROTATE, PLAYER NODE DOES NOT
		$PlayerSprite2.rotation -= 0.02
		$PlayerShape.rotation -= 0.02
		#self.rotation -= 0.02

	if Input.is_key_pressed(KEY_D):
		# ONLY SPRITE AND SHAPE ROTATE, PLAYER NODE DOES NOT, BECAUSE LASER RAYCAST POSITIONING MESS
		$PlayerSprite2.rotation += 0.02
		$PlayerShape.rotation += 0.02
		#self.rotation += 0.02
		
	if Input.is_key_pressed(KEY_SPACE):
		if currMovespeed != 0:
			currMovespeed /= 2
			if (currMovespeed < 1) or (currMovespeed > -1):
				currMovespeed = 0
				
			
	currDirection = Vector2(cos($PlayerShape.rotation), sin($PlayerShape.rotation))
	#currDirection = Vector2(cos(self.rotation), sin(self.rotation))
	currDirection = currDirection.normalized()
	#print(currDirection)
	
	# if currDirection != Vector2(0,0):
		# ONLY SPRITE AND SHAPE ROTATE, PLAYER NODE DOES NOT
		# $PlayerSprite2.rotation = currDirection.angle()
		# $PlayerShape.rotation = currDirection.angle()
		# $PlayerSprite2/Tween.interpolate_property($PlayerSprite2, "rotation", $PlayerSprite2.rotation, currDirection.angle(), 0.2)
		# $PlayerSprite2/Tween.start()
		# TODO - smooth rotation
	
	motion = currDirection * currMovespeed

	move_and_slide(motion)
	
	
func turretLock():
	if Input.is_action_just_pressed("laserLock"):
		Globals.laserLock = not Globals.laserLock
		
	if Input.is_action_just_pressed("gunLock"):
		Globals.gunLock = not Globals.gunLock


func update_stats():
	player_stats = Globals.get_player_stats()
	
	self.scale = Vector2(player_stats["Size"],player_stats["Size"])


func reduceHealth():
	player_health -= 1
	$PlayerHealth.text = str(player_health)
	# $PlayerSprite2.modulate = Color(1, player_health/1000, player_health/1000, 1)
	# not sure why color change doesnt work, but not necessary for V0.01
	if player_health == 0:
		Globals.game_state = "Over"
	


func _on_Pickup_body_entered(body):
	print('pickup')
	movespeedMultiplier = movespeedMultiplier * 2
	maxMovespeed = BASE_MOVESPEED*movespeedMultiplier
	# MOVE THIS TO GLOBAL STAT HANDLING
