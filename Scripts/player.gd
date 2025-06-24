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

@onready var jumpTimer = $Timer;

@onready var editing: Node2D = $editing

#Player movement variables
@export_enum("Orange","Blue") var playerColor : String;
@export var debug : bool = false;

@export_subgroup("X Movement")
@export var xAcceleration : float = 50;
@export var xMaxspeed : float = 200;

@export_subgroup("Jumping")
@export var jumpTime : float = 0.08;
@export var jumpSpeed : int = 200;
@export var jumpSpeedCap : int = -500;

@export_subgroup("Resistance")
@export var groundResistance : int = 40;
@export var airReistance : int = 15;

@export_subgroup("Drawing")
@export var drawingRange : int = 300;

var horizontalAxis : float;
var upButton : String;
var editButton : String;


func _ready():
#	Set player as OrangeP1 or Blue P2, Text and self modulate
	if playerColor == "Orange":
		$Sprite2D.texture = load("res://assets/art/static/player1.svg");
	elif playerColor == "Blue":
		$Sprite2D.texture = load("res://assets/art/static/player2.svg");
	


func _physics_process(delta):
	#FIXME Fix dis Bhop jumping higher
	
	#---------Text debug code---------
	if debug:
		if playerColor == "Orange":
			$playerLabel.text = "P1 ORANGE";
		elif playerColor == "Blue":
			$playerLabel.text = "P2 BLUE";
		match playerState:
			states.onGround:
				$stateLabel.text = "onGround"
			states.groundMoving: 
				$stateLabel.text = "groundMoving"
			states.jumping:
				$stateLabel.text = "jumping"
			states.falling:
				$stateLabel.text = "falling"
			states.editing:
				$stateLabel.text = "editing"
			states.gameOver:
				$stateLabel.text = "gameOver"
			states.locked:
				$stateLabel.text = "locked"
#	----------------------------------

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
					editing.showZone()
					if Input.is_action_just_pressed(editButton):
						playerState = states.onGround;
						editing.hideZone();
				states.jumping:
					velocity += get_gravity() * delta;
					move_and_slide();
					horizontalmovement(horizontalAxis);
					print(jumpTimer.time_left);
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
#					TODO Death Animation
					pass
	#if playerState != states.editing and playerState != states.gameOver:
#
		##Handle gravity and jump timer
		#if not is_on_floor():
			#velocity += get_gravity() * delta;
			#playerState = states.gliding;
		#else:
			#jumpTimer.start(jumpTime);
			#canJump = true;
		#
		##Orange player keymap
		#if playerColor == "Orange":
			#if Input.is_action_pressed("p1_up") and jumpTimer.time_left != 0:
				#if velocity.y >= jumpSpeedCap:
					#velocity.y -= jumpSpeed;
			#elif Input.is_action_just_released("p1_up"):
				#jumpTimer.stop()
#
			#horizontalmovement(Input.get_axis("p1_left", "p1_right"));
		#
		##Blue player keymap
		#elif playerColor == "Blue":
			#if Input.is_action_pressed("p2_up") and jumpTimer.time_left != 0:
				#if velocity.y >= jumpSpeedCap:
					#velocity.y -= jumpSpeed;
			#elif Input.is_action_just_released("p2_up"):
				#jumpTimer.stop();
#
			#horizontalmovement(Input.get_axis("p2_left", "p2_right"));
#
		#move_and_slide();
#
##	Freeze player on game over #FIXME In practice doesn't work since entire level is paused 
	#elif playerState == states.gameOver or playerState == states.locked:
		#velocity = Vector2.ZERO;


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
#	TODO Make Celeste animation work
	$CPUParticles2D.emitting = true;
	playerState = states.gameOver;
	SignalBus.playerDeath.emit();
	$CPUParticles2D.emitting = true;
	
func _on_hit_detect_area_entered(area):
	#Runs when this player gets hit by projectile
	if area.is_in_group("playerkill"):
		death();
		
func lockinputs():
	playerState = states.locked
