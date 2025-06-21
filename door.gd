extends Area2D

@export_enum("Orange","Blue") var correct_player : String
@onready var opendoor = preload("res://assets/Art/Static/opendoorplace.png")
@onready var closeddoor = preload("res://assets/Art/Static/closeddoorplace.png")
var win_condition : bool
func _enter_tree():
	$Label.text = correct_player


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("Player") and body.player == correct_player and win_condition:
			$Sprite2D.texture = opendoor
	


func _on_body_exited(body):
	$Sprite2D.texture = closeddoor
