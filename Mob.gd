extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# play the animation and randomly choose one of the 3 animation types
	#get the list of animations names from the AnimatedSprite2D frames property
	# this returns an array of all 3 names [ "walk", "swim", "fly"]
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	# pick a random number between 0 and 2 to select one of the names from the array 
	# using randi() % n selects a random integer between 0 and n - 1
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# added signal to Mob node that auto populated this function
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# this func generated when originally creating the signal BUT it was not connected to the Mob node
#func _on_screen_exited():
	#queue_free()
	
# we need to have the mobs delete themselves when they leave screen
# notes from here https://docs.godotengine.org/en/stable/getting_started/first_2d_game/04.creating_the_enemy.html
# need to connect the screen_exited() signal to the VisibleOnScreenNotifier2D node to the MOb and add the func below
#func _on_visible_on_screen_notifier_2d_screen_exited():
	#queue_free()
