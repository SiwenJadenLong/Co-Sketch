extends Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
@export var speed: Vector2
var directionrotated: float
var spawnpos: Vector2

func _ready():
	#global_position = spawnpos
	speed = speed.rotated(directionrotated)

func _physics_process(delta):
	position += speed

func _on_area_entered(area):
	#get_node()
	pass
