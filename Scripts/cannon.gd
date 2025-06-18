extends StaticBody2D

const CANNONBALL = preload("res://scenes/objects/Cannonball.tscn")
var shootingdirection : Vector2
func _ready():
	shootingdirection.rotated(rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
#	Create instance of cannonball projectile
	var newcannonballinstance = CANNONBALL.instantiate()
	newcannonballinstance.global_position = global_position
	newcannonballinstance.speed = Vector2.RIGHT * Vector2(10,10)
	newcannonballinstance.directionrotated = rotation
	get_tree().current_scene.add_child(newcannonballinstance)
	
	
	
