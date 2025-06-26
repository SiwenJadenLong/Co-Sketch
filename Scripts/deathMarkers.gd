extends Node2D

const DEATH_MARKER = preload("res://scenes/Gameplay/deathMarker.tscn")
var currentLevelName : String = "NO LEVEL";


func _ready() -> void:
	SignalBus.playerDeathPosition.connect(addDeathMarker);
	
#Add a new deathMarker based on player death position signal.
func addDeathMarker(deathposition : Vector2, playerColor : String):
	
#	Updates the current level every time a death marker is made.
	if currentLevelName != GlobalVariables.currentLevelName:
		clearMarkers();
	currentLevelName = GlobalVariables.currentLevelName;
	
	
	var newDeathMarker = DEATH_MARKER.instantiate()
	newDeathMarker.global_position = deathposition;
	match playerColor:
		"Orange":
			newDeathMarker.player = "Orange";
			GlobalVariables.orangeDeathCounter += 1;
			GlobalVariables.perLevelOrangeDeathCounter += 1;
		"Blue":
			newDeathMarker.player = "Blue";
			GlobalVariables.blueDeathCounter += 1;
			GlobalVariables.perLevelBlueDeathCounter += 1;
	add_child(newDeathMarker);

func clearMarkers():
#	Kill all children lmao.
#	Called on a level change of a different level.
	for child in get_children():
		child.queue_free();
