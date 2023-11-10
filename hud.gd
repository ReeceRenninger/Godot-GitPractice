extends CanvasLayer

# notifies 'main' node that the button has been pressed to start
signal start_game

# temp message before game begins
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
# game over screen before repopulating the start game screen
# function is called when player loses, shows game over for 2 seconds then returns to title screen with a pause
func show_game_over():
	show_message("Game Over")
	# wait until message timer has counted down
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	
	#Make a one shot timer and wait for it to finish
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()
