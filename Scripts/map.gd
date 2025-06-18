extends Node2D

#Placeholder player respawn
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body.position = Vector2(0,0)
