extends Node2D

#@onready var line = $segment/Line2D
#@onready var collisionline = $segment/CollisionShape2D
var last_point = Vector2(0,0)

func _process(delta):
	pass

func _input(event):
	var point_pos = get_local_mouse_position()
	#if event.is_action("ui_cancel"):
		
	await $Timer.timeout
	$Timer.start(0.5)
	var newsegmentbody = RigidBody2D.new()
	var newline = Line2D.new()
	if event.is_action("ui_accept"):
		newline.width = 5
		if newline.points.size() == 0:
			newline.add_point(point_pos)
		else:
			newline.add_point(last_point)
		newsegmentbody.add_child(newline)

		var new_line_segment = CollisionShape2D.new()
		new_line_segment.shape = SegmentShape2D.new()
		new_line_segment.shape.a = last_point
		new_line_segment.shape.b = point_pos

		newsegmentbody.add_child(new_line_segment)
		add_child(newsegmentbody)

		last_point = point_pos
		
