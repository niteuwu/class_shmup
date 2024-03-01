extends Area2D

@onready var screensize = get_viewport_rect().size
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@export var speed = 150
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#left right up down
	var input = Input.get_vector("left","right","up","down")
	position += input * speed * delta
	position = position.clamp(Vector2(8, 8), screensize - Vector2(8, 8))
