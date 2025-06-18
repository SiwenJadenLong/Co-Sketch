extends StaticBody2D

const CANNONBALL = preload("res://scenes/objects/Cannonball.tscn")
var shootingdirection : Vector2

@export var projectile_speed : int
@export var firing_timer: float

func _ready():
	$Timer.wait_time = firing_timer
	shootingdirection.rotated(rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass


func _on_timer_timeout():
#	Create instance of cannonball projectile
	var newcannonballinstance = CANNONBALL.instantiate()
	newcannonballinstance.global_position = global_position
	newcannonballinstance.speed = Vector2.LEFT * projectile_speed
	newcannonballinstance.directionrotated = rotation
	get_tree().current_scene.add_child(newcannonballinstance)
	
	
	
