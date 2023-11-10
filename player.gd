extends Area2D

# working on collisions
signal hit

@export var speed = 400 # how fast the player will move (pixels/sec)
var screen_size # size of the game window

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size # find the game window size
	hide() # hides the player

# Called every frame. 'delta' is the elapsed time since the previous frame.
# check for input, move in the given direction, play the appropriate animation
func _process(delta):
	# zero out our velocity first
	var velocity =  Vector2.ZERO # player movement vector
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed # normalizes diagonal movement so the speeds aren't doubled together from 2 key presses
	# $ is shorthand for get_node(), so the below code is the same as get_node("AnimatedSprite2D").play()
	# $ in GDScript reutrns the node at the relative path form the CURRENT node or reutrns null if node is not found
		$AnimatedSprite2D.play() # if player is moving, play animation
	else:
		$AnimatedSprite2D.stop() # if player is NOT moving, stop animation
		
	# clamping to prevent the sprite from exiting screen
	position += velocity * delta # delta here refers to the frame length, the amount of time that the previous frame took to complete, keeps movement consistent even in frame changes
	position = position.clamp(Vector2.ZERO, screen_size) # global variable of screen size used to keep spirte in bounds
	
	if velocity.x != 0: # if we are changing the velocity on the x axis with movement
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0 # flip the image from animation horizontally if velocity.x < 0 which means moving LEFT
	elif velocity.y != 0: # if we are changing the velocity on the y axis with movement
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0 # flip the image from animation vertically if velocity.y > 0 which means moving DOWN


func _on_body_entered(body):
	hide() # player disappears after being hit
	hit.emit()
	# must be deferred as we can't change physics properites on a physics callback
	# Disabling the area's collision shape can cause an error if it happens in the middle of engines collision 
	# processing. Using set_deferred tells Godot to WAIT to disable the shape until it's safe to do so.
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
