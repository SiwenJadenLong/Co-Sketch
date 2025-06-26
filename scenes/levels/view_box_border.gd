@tool
extends StaticBody2D

@export var borderPadding : int = 0;
		
@onready var viewBoxBorderCollision: CollisionPolygon2D = $viewBoxBorderCollision;
@onready var polygon2D: Polygon2D = $Polygon2D

func _ready() -> void:
	var newBorderExtremeX = get_viewport_rect().size.x/2 - borderPadding;
	var newBorderExtremeY = get_viewport_rect().size.y/2 - borderPadding;
	var borderCorners : PackedVector2Array;
	borderCorners.append(Vector2(-newBorderExtremeX,-newBorderExtremeY));
	borderCorners.append(Vector2(newBorderExtremeX,-newBorderExtremeY));
	borderCorners.append(Vector2(newBorderExtremeX,newBorderExtremeY));
	borderCorners.append(Vector2(-newBorderExtremeX,newBorderExtremeY));
	viewBoxBorderCollision.polygon = borderCorners;
	polygon2D.polygon = borderCorners;
