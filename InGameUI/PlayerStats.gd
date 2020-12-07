extends Node


var stats = {"Size":1.00,
				"Acceleration":1.00,
				"Movespeed":1.00,
				"Turnspeed":1.00}


func get_stats():
	return stats


func set_stats(stats_to_update):
	print("old stats: ", stats)
	print("stats_to_update: ", stats_to_update)
	for stat in stats_to_update:
		stats[stat] = stats[stat] + stats_to_update[stat] / 100
		# print("stat: ", stat)
		
	print("new stats: ", stats)

#dir1 = {"a": 1, "b": 2, "c": 3}
#dir2 = {"a": 1, "b": 2, "c": 3}

#func compare_dictionaries():
#    print(dir1.hash() == dir2.hash()) # Will print true.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
