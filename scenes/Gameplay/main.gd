extends Node

@export var currentlevel : Node2D

func _ready():
	loadnewlevel()
	Signalbus.playerdeath.connect(transition);
	
func transition():
	$AnimationPlayer.play("generictransition ahh");

func loadnewlevel():
	$Level.add_child(currentlevel)
