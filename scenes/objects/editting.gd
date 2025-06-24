extends Node2D;

@onready var edittingZoneSprite: Sprite2D = $edittingZone;
var drawingRange : int = get_node(".").drawingRange

func showZone():
	show()
	var tweenShow = create_tween().set_ease(Tween.EASE_OUT);
	tweenShow.tween_property(self, "scale", Vector2(5,5),0.20);
	#tweenShow.tween_property(self, "modulate", Color(1,1,1,1),0.05);

func hideZone():
	var tweenhide = create_tween().set_ease(Tween.EASE_IN);
	tweenhide.tween_property(self, "scale", Vector2(0,0),0.20);
	#tweenhide.tween_property(self, "modulate", Color(1,1,1,0),0.20);
	await tweenhide.finished
	hide()
