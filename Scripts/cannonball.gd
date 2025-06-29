extends Area2D;
class_name projectile;

# Called every frame. 'delta' is the elapsed time since the previous frame.
@export var speed: Vector2;
@export var lineKill: bool = true;

var directionrotated: float;
var spawnpos: Vector2;

func _ready():
	speed = speed.rotated(directionrotated);
	if lineKill:
		$AnimatedSprite2D.animation = "hardProjectile";

func _physics_process(delta):
	position += (speed*100) * delta;
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("drawing") or body.is_in_group("staticLevelObject"):
		queue_free();
		if body.is_in_group("drawing") and lineKill:
			SignalBus.lineKill.emit();
			print("lineKill() emitted");
