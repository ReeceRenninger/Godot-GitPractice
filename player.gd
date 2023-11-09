extends Area2D

@export var speed = 400 # how fast the player will move (pixels/sec)
var screen_size # size of the game window

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size # find the game window size


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
