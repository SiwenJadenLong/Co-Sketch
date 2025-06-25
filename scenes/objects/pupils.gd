extends AnimatedSprite2D

@onready var cursor: Node2D;
@onready var player: playerCharacter = get_parent().get_parent().get_parent();

@export var eyeTravelDistance: float;
var cursorLoaded: bool = false;

func loadCursor():
	#FIXME Neither of these work
	
	cursor = get_parent().get_parent().get_parent().lineMaker.get_node("cursor");
	# cursor = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("lineMaker").get_node("cursor");
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await player.lineMakerFinished;
	if player.playerState == player.states.editing:
		var direction: Vector2 = Vector2.ZERO.direction_to(cursor.position);
		var distance: float = cursor.position.length();
		var setPosition = direction * min(eyeTravelDistance, distance);
		setPosition.y += 3.5;
		position = setPosition;
	else:
		position = Vector2(0, 3.5);
