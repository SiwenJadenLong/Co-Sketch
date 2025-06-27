extends Node

var player : String;

const ORANGE_DEATH_MARKER = preload("res://assets/art/static/orangeDeathMarker.svg")
const BLUE_DEATH_MARKER = preload("res://assets/art/static/blueDeathMarker.svg")

func _ready() -> void:
	match player:
		"Orange":
			$deathMarkerSprite.texture = ORANGE_DEATH_MARKER;
			$playerLabel.text = "P1"
		"Blue":
			$deathMarkerSprite.texture = BLUE_DEATH_MARKER;
			$playerLabel.text = "P2"
