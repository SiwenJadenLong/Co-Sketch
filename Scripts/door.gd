extends Area2D;
class_name door;
signal doorOpened;

#Select if door Orange or Blue
@export_enum("Orange","Blue") var correctPlayer : String;

@export var openOrangeDoor : Texture2D;
@export var closedOrangeDoor : Texture2D;

@export var openBlueDoor : Texture2D;
@export var closedBlueDoor : Texture2D;

var openDoor
var closedDoor

var playerInDoor : bool;

func _enter_tree():
	$Label.text = correctPlayer;
	match correctPlayer:
		"Orange":
			openDoor = openOrangeDoor;
			closedDoor = closedOrangeDoor;
		"Blue":
			openDoor = openBlueDoor;
			closedDoor = closedBlueDoor;


func _on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("Player") and body.playerColor == correctPlayer:
		$doorHoldTimer.start();
		await $doorHoldTimer.timeout;
		$Sprite2D.texture = openDoor;
		playerInDoor = true;
	doorOpened.emit();


func _on_body_exited(body):
	if body.is_in_group("Player") and body.playerColor == correctPlayer:
		$Sprite2D.texture = closedDoor;
		playerInDoor = false;
