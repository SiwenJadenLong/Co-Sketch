extends Area2D;

@export var stomping : bool;

func moveornot():
	if stomping:
		$AnimationPlayer.play("stomp");
