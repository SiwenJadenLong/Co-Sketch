extends Area2D;
class_name door;
signal doorOpened;

#Select if door Orange or Blue
@export_enum("Orange","Blue") var correctPlayer : String;

@export var orangeIcon : Texture2D;
@export var blueIcon : Texture2D;

@onready var icon: Sprite2D = $icon;

var openDoor
var closedDoor

var playerInDoor : bool;

func _ready() -> void:
	$Label.text = correctPlayer;
	match correctPlayer:
		"Orange":
			icon.texture = orangeIcon;
		"Blue":
			icon.texture = blueIcon;


func _on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("Player") and body.playerColor == correctPlayer:
		$doorHoldTimer.start();
		await $doorHoldTimer.timeout;
		icon.hide();
		$AnimatedSprite2D.play("opening");
		await $AnimatedSprite2D.animation_finished;
		if $AnimatedSprite2D.animation == "opening":
			playerInDoor = true;
			doorOpened.emit();


func _on_body_exited(body):
	if body.is_in_group("Player") and body.playerColor == correctPlayer:
		playerInDoor = false;
		$AnimatedSprite2D.play_backwards("opening");
		await $AnimatedSprite2D.animation_finished;
		icon.show();
