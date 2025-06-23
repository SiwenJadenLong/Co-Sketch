extends CharacterBody2D;
class_name playerCharacter;

var canJump = true;

#state machine
enum states {idle, running, gliding, editing, gameOver, locked};
var playerState = states.idle;

@onready var jumpTimer = $Timer;

#Player movement variables
@export_enum("Orange","Blue") var playerColor : String;
@export var debug : bool = false;

@export_subgroup("X Movement")
@export var xAcceleration : float = 50;
@export var xMaxspeed : float = 200;

@export_subgroup("Jumping")
@export var jumpTime : float = 0.08;
@export var jumpSpeed : int = 100;
@export var jumpSpeedCap : int = -500;

@export_subgroup("Resistance")
@export var groundResistance : int = 40;
@export var airReistance : int = 15;
#@export var Timescale : float = 0.5



func _ready():
#	Set player as OrangeP1 or Blue P2, Text and self modulate
	if playerColor == "Orange":
		$Sprite2D.texture = load("res://assets/art/static/player1.svg");
	elif playerColor == "Blue":
		$Sprite2D.texture = load("res://assets/art/static/player2.svg");
	
	var edittingZoneTween = create_tween().bind_node($line).set_ease(Tween.EASE_OUT)
	edittingZoneTween.tween_property()


func _physics_process(delta):
	#FIXME Fix dis Bhop jumping higher
	
	#---------Text debug code---------
	if debug:
		if playerColor == "Orange":
			$playerLabel.text = "P1 ORANGE";
		elif playerColor == "Blue":
			$playerLabel.text = "P2 BLUE";
		if playerState == states.editing:
			$editingLabel.text = "editing!";
		else:
			$editingLabel.text = "";
	
	
	
	
	
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
