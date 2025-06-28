extends Control;

enum button{
	start,
	levelSelect,
	settings,
	quit
}
var focused : button;

@export var logo1 : Texture2D;
@export var logo2 : Texture2D;


@onready var title: TextureRect = $title
@onready var highLight: TextureRect = $highLight;
@onready var start: TextureButton = $VBoxContainer/Start;
@onready var levelSelect: TextureButton = $VBoxContainer/levelSelect;
@onready var settings: TextureButton = $VBoxContainer/Settings;
@onready var quit: TextureButton = $VBoxContainer/Quit;

func _process(delta: float) -> void:
	match focused:
		button.start:
			highLight.position.y = move_toward(highLight.position.y, 282.0,10);
		button.levelSelect:
			highLight.position.y = move_toward(highLight.position.y, 365.0,10);
		button.settings:
			highLight.position.y = move_toward(highLight.position.y, 443.0,10);
		button.quit:
			highLight.position.y = move_toward(highLight.position.y, 547,10);

func mainMenuStartPressed():
	SignalBus.levelChange.emit(1);
	hide();

func mainMenuLevelSelectPressed() -> void:
	get_parent().get_node("levelSelect").show();

func _on_start_focus_entered() -> void:
	focused = button.start;


func _on_level_select_focus_entered() -> void:
	focused = button.levelSelect;


func _on_settings_focus_entered() -> void:
	focused = button.settings;

func _on_quit_focus_entered() -> void:
	focused = button.quit;

func _ready() -> void:
	start.grab_focus();

func _on_timer_timeout() -> void:
	if title.texture == logo1:
		title.texture = logo2;
		title.position = Vector2(393,77)
	else:
		title.texture = logo1;
		title.position = Vector2(345,77)


func _on_start_mouse_entered() -> void:
	focused = button.start;


func _on_level_select_mouse_entered() -> void:
	focused = button.levelSelect;


func _on_settings_mouse_entered() -> void:
	focused = button.settings;


func _on_quit_mouse_entered() -> void:
	focused = button.quit;
