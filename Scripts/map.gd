extends Node2D;

var winCondition : bool;
@export var levelNumber : String;
@export var inkLimit: float;
@export var requiredPennies: int = 0;
@export var music : String = "bird";
@onready var allObjects : Array[Node] = $objects.get_children();
@onready var allPlayers : Array[Node] = $players.get_children();

var stopped;

#Make better level designs

#Freeze Objects
func stopobjects():
	stopped = true;
	$objects.process_mode = Node.PROCESS_MODE_DISABLED;
	$players.process_mode = Node.PROCESS_MODE_DISABLED;

func _process(delta: float) -> void:
	if !stopped:
		GlobalVariables.levelTime += delta

#Run on node entering game
func _ready():
	Audiomanager.changeBGMusic(music);
	GlobalVariables.inkLimit = inkLimit;
	GlobalVariables.totalLineDistance= 0;
	
	GlobalVariables.winConditionCoins = 0;
	
	GlobalVariables.levelTime = 0
	SignalBus.playerDeath.connect(stopobjects);
	
#	Placeholder always win
#	TODO Make win condition with coins or smth	
	winCondition = true;
	for object in allObjects:
		if object is door:
			object.doorOpened.connect(levelWinCheck);

#Checks if win condition is met, then checks if both doors are occupied by correct players
func levelWinCheck():
	if GlobalVariables.winConditionCoins < requiredPennies:
		return
	for object in allObjects:
		if object is door:
			if !object.playerInDoor:
				return;
	call_deferred("stopobjects");
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	SignalBus.levelWon.emit();
	process_mode = Node.PROCESS_MODE_PAUSABLE;
