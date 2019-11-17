extends "res://objects/Basic.gd"

# GOAL: Use a while loop and an if statement to open all the switches

# Make the while loop even smarter by using a condition.

# INSTRUCTIONS:
# 1. Add a while loop and set the condition that will make Luigi stop
# 2. Use an if statement in the loop to toggle only close switches.

func execute ():

	pass


























func _ready():
	put_teleporters(10, 13, 15, 5)
	put_teleporters(15, 14, 19, 4)

	for i in range (0, 8):
		put_random_switch (10, 5 + i)
		put_random_switch (15, 6 + i)

	for i in range (0, 4):
		put_random_switch (19, 5 + i)
	
	put_open_switch_at_cell(19, 9)

	$Luigi.face_south()
	put_luigi_at_cell (10, 4)
	proceed.post()


func put_random_switch (cx, cy):
	if rng.randi() % 2:
		put_switch_at_cell(cx, cy)
	else:
		put_open_switch_at_cell (cx, cy)


func main(userdata):
	proceed.wait()
	execute()
