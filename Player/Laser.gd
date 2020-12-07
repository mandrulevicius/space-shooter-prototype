extends Line2D

var laserHit

var laserTickLength = 60
var laserTicking = true
var laserFrameCount = 0

var canShootLaser = true
var beamHeat = 0 # cool down while not shooting
var maxBeamHeat = 60

var lastLaseredObject

func _process(delta):
	if Input.is_action_pressed("ui_leftclick") and canShootLaser:
		shootLaser()
		beamHeat += 1
		$LaserCharge.value = beamHeat
		$LaserStatus.text = "laser shooting"
		if beamHeat == maxBeamHeat:
			canShootLaser = false
			if self.get_point_count() > 1:
				self.remove_point(1)
	else:
		$LaserImpact.emitting = false
		$LaserImpact/LaserImpactLight.enabled = false
		
		if beamHeat > 0:
			beamHeat -= 1
			$LaserCharge.value = beamHeat
			$LaserStatus.text = 'laser cooling'
		else:
			if $LaserStatus:
				$LaserStatus.text = 'laser cool'
	
	if Input.is_action_just_released("ui_leftclick"):
		if self.get_point_count() > 1:
			self.remove_point(1)
		canShootLaser = true
		
func shootLaser():
	if self.get_point_count() > 1:
		self.remove_point(1)
		
	laserHit = castBeam()

	if laserHit:
		$LaserImpact.position = to_local(laserHit.position)
		$LaserImpact.emitting = true
		$LaserImpact/LaserImpactLight.enabled = true
		
		var laserHitNode = laserHit.collider
		
		if laserHitNode != lastLaseredObject:
			laserFrameCount = 0
			#print("New Object Hit!")
			
		lastLaseredObject = laserHitNode
		
		laserFrameCount += 1
		if laserFrameCount == laserTickLength:
			laserFrameCount = 0
			laserTicking = false
		
		#print('laserFrameCount: ', str(laserFrameCount))
		
		if not laserTicking:
			#print('Health reduced to: ', laserHitNode.name)
			laserTicking = true
			laserHitNode.reduceHealth()

func castBeam():
	var beamDirection
	if Globals.laserLock:
		var spriteRotation = get_parent().get_node("PlayerSprite2").rotation
		beamDirection = Vector2(cos(spriteRotation), sin(spriteRotation))
	else:
		beamDirection = get_local_mouse_position().normalized()
	var spaceState = get_world_2d().direct_space_state
	var result = spaceState.intersect_ray(self.global_position, self.global_position + beamDirection*2000, [self], 18)
	if result:
		self.add_point(to_local(result.position))
	else:
		self.add_point(beamDirection*2000) 
	return result

	# Can also find nodes with find_node()
	#print(find_node("Child2",true,false).name)
	#print(find_node("Child",true,false).name) #can somehow take partial string?


func _on_Pickup_body_entered(body):
	#NUMBERS!!! Avoid if possible - numbers increase really slowly by killing certain types of enemies, while powerups provide additional abilities/effects?
	laserTickLength = laserTickLength / 2
	maxBeamHeat =  maxBeamHeat * 2
	#add cooling speed
	#self.width = self.width * 2
	self.scale = self.scale * 2




# BUG FIXING HISTORY

		# REDUCES HEALTH FROM 1 TO 0 TOO FAST - fixed, was due to invisible staticbody copy of Player node also shooting laser.

		# THIS CAUSES THE PROBLEM OF SAME TICKING FOR DIFFERENT OBJECTS.
		# reproduce: shoot a bit at one object, then a bit at another.
		# result: second object gets damaged too quickly due to ticking increasing during shot at different object

		# Possible solution - Every object has internal HP?
		# Reset on target change? - YES, SOLVED

