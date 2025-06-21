extends Area2D
class_name projectile

# Called every frame. 'delta' is the elapsed time since the previous frame.
@export var speed: Vector2
var directionrotated: float
var spawnpos: Vector2

func _ready():
	speed = speed.rotated(directionrotated)

func _physics_process(delta):
	position += (speed*100) * delta

func _left_screen():
	queue_free()
