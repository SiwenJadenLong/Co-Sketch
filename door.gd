extends Area2D
class_name door
#Select if door Orange or Blue
@export_enum("Orange","Blue") var correct_player : String

@onready var opendoor = preload("res://assets/Art/Static/opendoorplace.png")
@onready var closeddoor = preload("res://assets/Art/Static/closeddoorplace.png")

var player_in_door : bool
var win_condition : bool

func _enter_tree():
	$Label.text = correct_player


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("Player") and body.playercolor == correct_player and win_condition:
		$Sprite2D.texture = opendoor
		player_in_door = true


func _on_body_exited(body):
	if body.is_in_group("Player") and body.playercolor == correct_player and win_condition:
		$Sprite2D.texture = closeddoor
		player_in_door = false
