extends "res://objects/Basic.gd"

# GOAL: Choose the best loop to collect all the coins

# There are six coins. Provided is a function that will move Luigi and
# collect one coin. Choose the best loop for making Luigi collect all
# coins.


func turnAndCollectGem():
	goForward()
	goForward()
	turnLeft()
	goForward()
	goForward()
	jump()
	turnRight()

# INSTRUCTIONS:
# 1. Identify the pattern to move from coin to coin
# 2. Choose a type of loop and use it to solve the problem
func execute ():

	pass


























func _ready():
	put_teleporters(9, 11, 12, 2)
	put_coin_at_cell(7, 7)
	put_coin_at_cell(9, 9)
	put_coin_at_cell(14, 2)
	put_coin_at_cell(16, 4)
	put_coin_at_cell(18, 6)
	put_coin_at_cell(20, 8)

	$Luigi.face_south()
	put_luigi_at_cell (5, 5)
	proceed.post()
	
func main(userdata):
	proceed.wait()
	execute()
