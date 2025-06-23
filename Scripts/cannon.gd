extends StaticBody2D;

const CANNONBALL : PackedScene= preload("res://scenes/objects/Cannonball.tscn");
var shootingdirection : Vector2;

@export var projectile_speed : int = 5;
@export var firing_timer: float = 2.0;

func _ready():
	$Timer.wait_time = firing_timer;
	shootingdirection.rotated(rotation);

func _on_timer_timeout():
#	Create instance of cannonball projectile
	var newcannonballinstance = CANNONBALL.instantiate();
	newcannonballinstance.global_position = global_position;
	newcannonballinstance.speed = Vector2.LEFT * projectile_speed;
	newcannonballinstance.directionrotated = rotation;
	get_parent().add_child(newcannonballinstance);
	
	
	
