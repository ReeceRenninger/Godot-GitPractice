extends Area2D

@export var speed = 400 # how fast the player will move (pixels/sec)
var screen_size # size of the game window

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size # find the game window size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
