extends StaticBody2D;
var shootingdirection : Vector2;

@export var projectileObject : PackedScene;
@export var projectile_speed : int = 5;
@export var firing_timer: float = 2.0;
@export var offsetDelay : float = 0;

func _ready():
	await get_tree().create_timer(offsetDelay).timeout
	$Timer.start(firing_timer);
	shootingdirection.rotated(rotation);
	

func _on_timer_timeout():
#	Create instance of cannonball projectile
	var newcannonballinstance = projectileObject.instantiate();
	newcannonballinstance.global_position = global_position;
	newcannonballinstance.speed = Vector2.LEFT * projectile_speed;
	newcannonballinstance.directionrotated = rotation;
	owner.add_child(newcannonballinstance);
	
	
	
