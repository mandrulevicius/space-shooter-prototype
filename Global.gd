extends Node

var game_state

var currentPlayerPosition
var playerCameraScreenCenter
# since camera is child of Player node, camera position always equal to Player position
# however, camera screen center can be offset by smoothing, therefore we use this
var screenSize
var halfScreenSize

var laserLock = false
var gunLock = false


func moveBackgroundStar(position):
	halfScreenSize = screenSize / 2
	if position.x < playerCameraScreenCenter.x - halfScreenSize.x:
		position.x = playerCameraScreenCenter.x + halfScreenSize.x
	if position.x > playerCameraScreenCenter.x + halfScreenSize.x:
		position.x = playerCameraScreenCenter.x - halfScreenSize.x
	if position.y < playerCameraScreenCenter.y - halfScreenSize.y:
		position.y = playerCameraScreenCenter.y + halfScreenSize.y
	if position.y > playerCameraScreenCenter.y + halfScreenSize.y:
		position.y = playerCameraScreenCenter.y - halfScreenSize.y
	return position


func despawnBullet(position):
	halfScreenSize = screenSize / 2
	if position.x < playerCameraScreenCenter.x - screenSize.x:
		return true
	if position.x > playerCameraScreenCenter.x + screenSize.x:
		return true
	if position.y < playerCameraScreenCenter.y - screenSize.y:
		return true
	if position.y > playerCameraScreenCenter.y + screenSize.y:
		return true
	return false


func get_player_stats():
	return $PlayerStats.get_stats()

func update_player_stats(stat_dict):
	$PlayerStats.set_stats(stat_dict)
	


func save_log(log_description, log_info):
	var log_file = File.new()
	log_file.open("res://log_file.txt", File.READ_WRITE)
	log_file.seek_end()
	log_file.store_string(log_description + str(log_info) + "\n") # store_line(to_json(<info>)) for json
	log_file.close()
