extends Node

var player : String;

@export var ORANGE_DEATH_MARKER : Texture2D;
@export var BLUE_DEATH_MARKER : Texture2D;

func _ready() -> void:
	match player:
		"Orange":
			$deathMarkerSprite.texture = ORANGE_DEATH_MARKER;
			$playerLabel.text = "P1"
		"Blue":
			$deathMarkerSprite.texture = BLUE_DEATH_MARKER;
			$playerLabel.text = "P2"
