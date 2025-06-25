@tool
extends StaticBody2D
@export var borderPadding : int;
@onready var viewBoxBorderCollision: CollisionPolygon2D = $viewBoxBorderCollision;

func _ready() -> void:
	var newBorderExtremeX = get_viewport_rect().size.x/2 - borderPadding;
	var newBorderExtremeY = get_viewport_rect().size.y/2 - borderPadding;
	var borderCorners : PackedVector2Array;
	borderCorners.append(Vector2(-newBorderExtremeX,-newBorderExtremeY));
	borderCorners.append(Vector2(newBorderExtremeX,-newBorderExtremeY));
	borderCorners.append(Vector2(newBorderExtremeX,newBorderExtremeY));
	borderCorners.append(Vector2(-newBorderExtremeX,newBorderExtremeY));
	viewBoxBorderCollision.polygon = borderCorners;
