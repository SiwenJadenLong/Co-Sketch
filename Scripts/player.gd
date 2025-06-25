extends CharacterBody2D;
class_name playerCharacter;

var canJump = true;

#state machine
enum states {
	onGround, 
	groundMoving, 
	jumping,
	falling, 
	editing, 
	gameOver, 
	locked
	};
	
var playerState = states.onGround;

@onready var jumpTimer = $jumpTimer;
@onready var editing: Node2D = $editing;
@onready var playerSprite: Node2D = $playerSprite;
@onready var physicsHitbox: CollisionShape2D = $physicsHitbox;

var lineMaker: RigidBody2D;

#Player movement variables
@export_enum("Orange","Blue") var playerColor : String;
@export var debug : bool = false;

@export_subgroup("X Movement")
@export var xAcceleration : float = 50;
@export var xMaxspeed : float = 200;

@export_subgroup("Jumping")
@export var jumpTime : float = 0.08;
@export var jumpSpeed : int = 200;
@export var jumpSpeedCap : int = -400;

@export_subgroup("Resistance")
@export var groundResistance : int = 40;
@export var airReistance : int = 15;

@export_subgroup("Drawing")
@export var drawingRange : int = 300;

@export_subgroup("Death")
@export var rotationIntensity : float = 0.1;
@export var launchIntensity : float = 800;

var horizontalAxis : float;
var upButton : String;
var editButton : String;


func _ready():
#	Set player as OrangeP1 or Blue P2, Text and self modulate
	if playerColor == "Orange":
		$playerSprite/Sprite2D.texture = load("res://assets/art/static/player1.svg");
	elif playerColor == "Blue":
		$playerSprite/Sprite2D.texture = load("res://assets/art/static/player2.svg");
		
	lineMaker = get_parent().get_parent().get_node("lineMaker");
	print("");


func _physics_process(delta):
	#---------Text debug code---------	
	if debug:
		if playerColor == "Orange":
			$playerLabel.text = "P1 ORANGE";
		elif playerColor == "Blue":
			$playerLabel.text = "P2 BLUE";
		match playerState:
			states.onGround:
				$stateLabel.text = "onGround";
			states.groundMoving: 
				$stateLabel.text = "groundMoving";
			states.jumping:
				$stateLabel.text = "jumping";
			states.falling:
				$stateLabel.text = "falling";
			states.editing:
				$stateLabel.text = "editing";
			states.gameOver:
				$stateLabel.text = "gameOver";
			states.locked:
				$stateLabel.text = "locked";
#	----------------------------------

#TODO Make eye movement and expressions

	match playerColor:
		"Orange":
			horizontalAxis = Input.get_axis("p1_left", "p1_right");
			upButton = "p1_up";
			editButton = "p1_edit_toggle";
		"Blue":
			horizontalAxis = Input.get_axis("p2_left", "p2_right");
			upButton = "p2_up";
			editButton = "p2_edit_toggle";
		_:
			printerr("No playercolor selected");
	match playerState:
				states.onGround:
					velocity += get_gravity() * delta;
					horizontalmovement(horizontalAxis);
					jumpTimer.start(jumpTime);
					if Input.is_action_just_pressed(editButton):
						playerState = states.editing;
					if !is_on_floor():
						playerState = states.falling;
					elif Input.is_action_just_pressed(upButton):
						playerState = states.jumping;
					move_and_slide();
				states.editing:
					editing.showZone();
					$lineMaker.get_node("cursor").visible = true;
					$lineMaker.process_mode = Node.PROCESS_MODE_INHERIT;
					if Input.is_action_just_pressed(editButton):
						playerState = states.onGround;
						editing.hideZone();
						$lineMaker.get_node("cursor").visible = false;
				states.jumping:
					velocity += get_gravity() * delta;
					move_and_slide();
					horizontalmovement(horizontalAxis);
					if Input.is_action_pressed(upButton) and jumpTimer.time_left != 0:
						if velocity.y >= jumpSpeedCap:
							velocity.y -= jumpSpeed;
					elif Input.is_action_just_released(upButton):
							jumpTimer.stop();
							playerState = states.falling;
				states.falling:
					move_and_slide();
					horizontalmovement(horizontalAxis);
					velocity += get_gravity() * delta;
					if is_on_floor():
						playerState = states.onGround;
					velocity += get_gravity() * delta;
				states.locked:
					move_and_slide();
				states.gameOver:
					playerSprite.rotation += 0.4;
					velocity += get_gravity() * delta;
					move_and_slide();


#Handles player inputs for horizontalmovement
func horizontalmovement(direction):
	if direction:
		if velocity.x <= xMaxspeed and velocity.x >= -xMaxspeed:
			velocity.x += direction * xAcceleration;
		else:
			velocity.x = direction * xMaxspeed;
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, 50);
	else:
		velocity.x = move_toward(velocity.x, 0, 5);

#If this Player dies this function plays
func death():
	SignalBus.playerDeathPosition.emit(global_position, playerColor);
	physicsHitbox.set_deferred("disabled",true);
	playerState = states.gameOver;
	process_mode = Node.PROCESS_MODE_ALWAYS;
	velocity += Vector2(0,launchIntensity).rotated(PI * 15/16);
	SignalBus.playerDeath.emit();
	
func _on_hit_detect_area_entered(area):
	#Runs when this player gets hit by projectile
	if area.is_in_group("playerkill"):
		death();
		
func lockinputs():
	playerState = states.locked
