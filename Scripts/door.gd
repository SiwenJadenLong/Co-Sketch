extends Area2D;
class_name door;
signal doorOpened;

#Select if door Orange or Blue
@export_enum("Orange","Blue") var correctPlayer : String;

@onready var openDoor = preload("res://assets/Art/Static/openDoorplace.png");
@onready var closedDoor = preload("res://assets/Art/Static/closedDoorplace.png");

var playerInDoor : bool;

func _enter_tree():
	$Label.text = correctPlayer;


func _on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("Player") and body.playerColor == correctPlayer:
		$Sprite2D.texture = openDoor;
		playerInDoor = true;
	doorOpened.emit();


func _on_body_exited(body):
	if body.is_in_group("Player") and body.playerColor == correctPlayer:
		$Sprite2D.texture = closedDoor;
		playerInDoor = false;
