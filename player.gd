extends Area2D

@onready var screensize = get_viewport_rect().size
# Called when the node enters the scene tree for the first time.
func _ready():
	start()

@export var speed = 150
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#left right up down
	var input = Input.get_vector("left","right","up","down")
	if input.x > 0:
		$Ship.frame = 2
		$Ship/Boosters.animation = "right"
	elif input.x < 0:
		$Ship.frame = 0
		$Ship/Boosters.animation = "left"
	else:
		$Ship.frame = 1
		$Ship/Boosters.animation = "forward"
	position += input * speed * delta
	position = position.clamp(Vector2(8, 8), screensize - Vector2(8, 8))
	if Input.is_action_pressed("shoot"):
		shoot()

@export var cooldown = 0.25
@export var bullet : PackedScene
var can_shoot = true

func start():
	position = Vector2(screensize.x / 2, screensize.y - 64)
	$GunCooldown.wait_time = cooldown

func shoot():
	if not can_shoot:
		return
	can_shoot = false
	$GunCooldown.start()
	var b = bullet.instantiate()
	b.start(position + Vector2(0, -8))
	get_tree().root.add_child(b)

func _on_gun_cooldown_timeout():
	can_shoot = true
