extends "res://objects/Basic.gd"

# GOAL: Help Luigi collect all of the coins

# Think of all the tools you've learned so far like:
#
# 	functions
#	for loops
#	conditional code (if, elif, else)
#	logical operators (not, && (and), || (or))
#	while loops

# INSTRUCTIONS:
# Try to help Luigi gather the coins using the most appropriate tool from
# your coding tool kit. 
# There are not right or wrong answers, but try to be as efficient as
# possible.
func execute (userdata):

	pass


























func _ready():
	$Luigi.face_north()
	put_luigi_at_cell (16, 7)

	put_coin_at_cell(16, 4)
	put_coin_at_cell(13, 4)
	put_coin_at_cell(13, 13)
	put_coin_at_cell(16, 13)
	put_coin_at_cell(19, 7)
	put_coin_at_cell(19, 10)
	put_coin_at_cell(10, 10)
	put_coin_at_cell(10, 7)
	



func put_random_switch (cx, cy):
	if rng.randi() % 2:
		put_switch_at_cell(cx, cy)
	else:
		put_open_switch_at_cell (cx, cy)
