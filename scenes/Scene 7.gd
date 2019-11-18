extends "res://objects/Basic.gd"

# GOAL: Use one loop inside another loop to move around the spiral of coins.

# Before you write any code, think it through. Find the patterns that repeat.
# There is a pattern for moving toward a coin as well as a pattern for what
# to do after a coin is encountered.

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
func execute ():

	pass


























func _ready():
	put_coin_at_cell(21, 14)
	put_coin_at_cell(21, 4)
	put_coin_at_cell(10, 4)
	put_coin_at_cell(10, 12)
	put_coin_at_cell(19, 12)
	put_coin_at_cell(19, 6)
	put_coin_at_cell(13, 10)
	put_coin_at_cell(13, 6)
	put_coin_at_cell(16, 10)
	put_coin_at_cell(16, 8)
	put_coin_at_cell(14, 8)
	
	$Luigi.face_east()
	put_luigi_at_cell (11, 14)
	proceed.post()
	
func put_random_switch (cx, cy):
	if rng.randi() % 2:
		put_switch_at_cell(cx, cy)
	else:
		put_open_switch_at_cell (cx, cy)

func main(userdata):
	proceed.wait()
	execute()
