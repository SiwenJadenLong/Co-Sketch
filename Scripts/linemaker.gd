extends Node2D

#@onready var line = $segment/Line2D
#@onready var collisionline = $segment/CollisionShape2D
var last_point = Vector2(0,0)
var editting
func _process(delta):
	pass

#TODO Make Line drawing
func linecreaion():
	var point_pos = get_local_mouse_position()
	await $Timer.timeout
	$Timer.start(0.5)
	var newline = Line2D.new()
