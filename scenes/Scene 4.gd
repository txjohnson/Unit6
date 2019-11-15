extends "res://objects/Basic.gd"

# GOAL: Choose the best loop and toggle the closed switches

# There are several ways to solve this challenge. You can use while lops
# or for loops or a combination of the two.

# INSTRUCTIONS:
# Figure out a pattern and use loops to help Luigi toggle the switches.
func execute (userdata):

	pass


























func _ready():
	$Luigi.face_west()
	put_luigi_at_cell (20, 12)

	put_switch_at_cell(13, 12)
	put_switch_at_cell(20, 5)
	put_open_switch_at_cell(13, 5)
	put_switch_at_cell(15, 10)
	put_teleporters(20, 10, 15, 9)
	
