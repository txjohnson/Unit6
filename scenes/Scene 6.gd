extends "res://objects/Basic.gd"

# GOAL: Help Luigi collect all coins and open all closed switches.

# In this challenge, the length of the field changes between runs.

# INSTRUCTIONS:
# Try to help Luigi gather the coins using the most appropriate tool from
# your coding tool kit. 
# There are not right or wrong answers, but try to be as efficient as
# possible.
func execute ():
	while cond:
		while cond:
			
			pass
	pass


























func _ready():
	var count = 3 + rng.randi() % 6
	 
	for i in range (0, count):
		put_coin_at_cell(7 + i * 2, 7)
		put_random_switch (7 + i * 2, 5)
		put_random_switch (7 + i * 2, 9)

	for i in range (0, 5):
		$Stuff.set_cell(7 + count * 2, 5 + i, 29)
		

	$Luigi.face_east()
	put_luigi_at_cell (6, 5)
	proceed.post()
	

func put_random_switch (cx, cy):
	if rng.randi() % 2:
		put_switch_at_cell(cx, cy)
	else:
		put_open_switch_at_cell (cx, cy)

func main(userdata):
	proceed.wait()
	execute()
