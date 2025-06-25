@tool
extends Sprite2D


@export var speed = 1:
	# Update speed and reset the rotation.
	set(new_speed):
		speed = new_speed
		rotation = 0


func _process(delta):
	rotation += PI * delta * speed
