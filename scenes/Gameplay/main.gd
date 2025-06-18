extends Node


func _ready():
	Signalbus.playerdeath.connect(transition);

	
func transition():
	$AnimationPlayer.play("generictransition ahh");
