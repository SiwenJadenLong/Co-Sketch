extends Node2D

@onready var player1 = $Player1

# Called when the node enters the scene tree for the first time.

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body.position = Vector2(0,0)
