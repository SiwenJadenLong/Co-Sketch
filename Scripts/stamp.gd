extends Area2D;

@export var stomping : bool;
@export var offsetDelay : float = 0;
@export var speedMultiplier : float = 1;

func _ready() -> void:
	$AnimationPlayer.speed_scale = speedMultiplier;
	await get_tree().create_timer(offsetDelay).timeout
	if stomping:
		$AnimationPlayer.play("stomp");
