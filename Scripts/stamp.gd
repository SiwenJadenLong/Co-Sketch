extends Area2D;

@export var stomping : bool;
@export var offsetDelay : float = 0;

func _ready() -> void:
	await get_tree().create_timer(offsetDelay).timeout
	if stomping:
		$AnimationPlayer.play("stomp");
