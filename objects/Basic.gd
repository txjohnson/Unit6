extends Node2D

var proceed :Semaphore
var waiting :bool
var stepper :Thread
var coins_grabbed :int = 0
var switches_toggled :int = 0
var under_coin = null
var atswitch = null
var onpad = null
var paddest = null
var is_teleporting :bool = false
var luigi_doing :int = 0
var isOnClosedSwitch = false
var isOnOpenSwitch = false
var isUnderCoin = false
var isBlocked = false
var isBlockedLeft = false
var isBlockedRight = false
var rng = RandomNumberGenerator.new()

var coin = preload("res://objects/Coin.tscn")
var switch = preload("res://objects/Switch.tscn")
var teleporter = preload("res://objects/Teleporter.tscn")


func _ready():
	rng.randomize()
	waiting = false
	proceed = Semaphore.new()
	stepper = Thread.new()
	stepper .start (self, "execute")

func _exit_tree():
	stepper.wait_to_finish()

func updateBlocked ():
	var pos = $Luigi.next_forward_position()
	var cx = (pos.x - 16) / 32
	var cy = (pos.y + 8) / 32
	
	if $Stuff.get_cell (cx, cy) != -1:
		isBlocked = true
	else:
		isBlocked = false
	
	pos = $Luigi.position_on_left()
	cx = (pos.x - 16) / 32
	cy = (pos.y + 8) / 32

	if $Stuff.get_cell (cx, cy) != -1:
		isBlockedLeft = true
	else:
		isBlockedLeft = false
	
	pos = $Luigi.position_on_right()
	cx = (pos.x - 16) / 32
	cy = (pos.y + 8) / 32

	if $Stuff.get_cell (cx, cy) != -1:
		isBlockedRight = true
	else:
		isBlockedRight = false
	
	
	
func turnLeft ():
	waiting = true
	$Luigi.turn_left()
	proceed.wait()
	
func turnRight ():
	waiting = true
	$Luigi.turn_right()
	proceed.wait()

func goForward ():
	
	if isBlocked:
		return
	
	under_coin = null
	isUnderCoin = false
	waiting = true
	luigi_doing = 1
	$Luigi.walk()
	proceed.wait()
	
func jump ():
	waiting = true
	luigi_doing = 2
	$Luigi.jump()
	proceed.wait()
	
func toggleSwitch():
	if atswitch != null:
		atswitch .toggle()
		switches_toggled += 1
		isOnClosedSwitch = atswitch.toggled == false
		isOnOpenSwitch = atswitch.toggled == true
	
func _on_Luigi_did_operation():
	updateBlocked()
	if waiting:
		waiting = false
		if luigi_doing == 1 && onpad != null:
			luigi_doing = 0
			onpad.teleport_send()
		else:
			luigi_doing = 0
			proceed.post()

func _on_Flag_area_entered(area):
	if coins_grabbed < 1:
		$Inform/RichTextLabel.bbcode_text = "You didn't get any coins"
	elif coins_grabbed < 2:
		$Inform/RichTextLabel.bbcode_text = "You got 1 coin"
	else:
		$Inform/RichTextLabel.bbcode_text = "You got " + str(coins_grabbed) + " coins"
		
	$Inform.show()
	pass # Replace with function body.

func _on_Luigi_grabbing():
	if under_coin != null:
		coins_grabbed += 1
		under_coin.queue_free ()
		under_coin = null
		isUnderCoin = false

func collected (who):
	under_coin = who
	isUnderCoin = true

func at_switch (who):
	atswitch = who
	isOnClosedSwitch = who.toggled == false
	isOnOpenSwitch = who.toggled == true
	
func not_at_switch (who):
	isOnClosedSwitch = false
	atswitch = null
	
func put_luigi_at_cell (cx, cy):
	print("cell: ", cx, ", ", cy)
	var x = cx * 32 + 16
	var y = cy * 32 - 8
	print("coord: ", x, ", ", y)
	$Luigi.position = Vector2(x, y)
	updateBlocked()

func put_coin_at_cell (cx, cy):
	var newcoin = coin.instance()
	var x = cx * 32 + 16
	var y = cy * 32 - 16
	newcoin.position = Vector2(x, y)
	newcoin.listener = self.get_path()
	$Coins.add_child (newcoin)

func put_switch_at_cell (cx, cy):
	var newsw = switch.instance()
	var x = cx * 32 + 16
	var y = cy * 32 + 8
	newsw .position = Vector2(x,y)
	newsw.listener = self.get_path()
	$Switches.add_child (newsw)

func put_open_switch_at_cell (cx, cy):
	var newsw = switch.instance()
	var x = cx * 32 + 16
	var y = cy * 32 + 8
	newsw .position = Vector2(x,y)
	newsw.listener = self.get_path()
	$Switches.add_child (newsw)
	newsw.toggle()

func put_random_switch_at_cell (cx, cy):
	var newsw = switch.instance()
	var x = cx * 32 + 16
	var y = cy * 32 + 8
	newsw .position = Vector2(x,y)
	newsw.listener = self.get_path()
	$Switches.add_child (newsw)
	
	if rng.randi() % 2:
		newsw.toggle()
	
func put_flag_at_cell (cx, cy):
	var x = cx * 32 + 16
	var y = cy * 32 - 32
	$Flag.position = Vector2 (x, y)
	

func put_teleporters (c1x, c1y, c2x, c2y):
	var x1 = c1x * 32 + 16
	var y1 = c1y * 32 + 16
	var x2 = c2x * 32 + 16
	var y2 = c2y * 32 + 16
	
	var src = teleporter.instance()
	var des = teleporter.instance()
	
	src.position = Vector2 (x1, y1)
	des.position = Vector2 (x2, y2)
	
	src.destpad = des
	des.destpad = src
	
	src.listener = self.get_path()
	des.listener = self.get_path()
	
	$Teleporters .add_child (src)
	$Teleporters .add_child (des)
	

func on_pad (who):
	onpad = who
	paddest = who.destpad
	
func off_pad (who):
	onpad = null
	paddest = null
	
func pad_transit (who):
	if $Luigi.visible == true:
		$Luigi.visible = false
	else:
		var x = (who.position.x - 16) / 32
		var y = (who.position.y - 16) / 32
		print (x, ", ", y)
		put_luigi_at_cell(x, y)
		$Luigi.visible = true
		
func pad_worked (who):
	proceed.post()

