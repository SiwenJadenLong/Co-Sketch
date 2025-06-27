extends Area2D

@export var offsetDelay : float = 0;

func _ready() -> void:
	await get_tree().create_timer(offsetDelay).timeout;
	$AnimationPlayer.play("cut");
