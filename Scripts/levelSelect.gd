extends Control

@onready var levelGrid: GridContainer = $"Level Grid";
const levelButton = preload("res://scenes/UI/level_button.tscn");

func levelSelectExitPressed():
	hide();

func _ready() -> void:
	var numberOfLevels : int = 0;
	var dir := DirAccess.open("res://scenes/levels");
	if dir == null: printerr("Could not open folder"); return;
	for file in dir.get_files():
		numberOfLevels += 1;
		var newlevelbutton = levelButton.instantiate();
		newlevelbutton.levelNumber = numberOfLevels;
		levelGrid.add_child(newlevelbutton);
