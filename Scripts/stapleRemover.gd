extends Area2D

@export var offsetDelay : float = 0;
@export var attackSpeed : float = 1;

func _ready() -> void:
	$AnimationPlayer.speed_scale = attackSpeed;
	await get_tree().create_timer(offsetDelay).timeout;
	$AnimationPlayer.play("attackLoop");
