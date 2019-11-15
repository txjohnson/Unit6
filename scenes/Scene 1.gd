extends "res://objects/Basic.gd"


# GOAL: Use a loop to keep moving while not on an open switch

# This challenge has a line of switches. There is a different number of 
# switches each time. Instead of making Luigi walk the entire line,
# have him stop when he reaches an open switch.

# INSTRUCTIONS:
# 1. Choose a condition for while that determine when Luigi will stop
# 2. Add commands to the while block to toggle closed switches
func execute (userdata):

	pass


























func _ready():
	$Luigi.face_east()
	put_luigi_at_cell (6, 8)

	var last = 4 + rng.randi() % 5
	for i in range(0, last):
		put_switch_at_cell(6 + i, 8)
	
	put_open_switch_at_cell(6 + last, 8)
		