extends CharacterBody2D
class_name playercharacter

var canjump = true

#state machine
enum states {idle, running, gliding, editting, gameover}
var playerstate = states.idle

@onready var jump_timer = $Timer

#Player movement variables
@export_enum("Orange","Blue") var playercolor : String

@export_subgroup("X Movement")
@export var x_acceleration : float = 50
@export var x_maxspeed : float = 200

@export_subgroup("Jumping")
@export var jump_time : float = 0.08
@export var jump_speed : int = 80
@export var jump_speed_cap : int = -500

@export_subgroup("Resistance")
@export var ground_reistance : int = 40
@export var air_reistance : int = 15
#@export var Timescale : float = 0.5



func _ready():
#	Set player as OrangeP1 or Blue P2, Text and self modulate
	if playercolor == "Orange":
		$Sprite2D.self_modulate = Color(1,1,0)
		$Label.text = "P1 ORANGE"
	elif playercolor == "Blue":
		$Sprite2D.self_modulate = Color(1.0, 0.6, 0.0)
		$Label.text = "P2 BLUE"
		

func _physics_process(delta):
	#FIXME Fix dis Bhop jumping higher
	if playerstate != states.editting and playerstate != states.gameover:

		#Handle gravity and jump timer
		if not is_on_floor():
			velocity += get_gravity() * delta
			playerstate = states.gliding
		else:
			jump_timer.start(jump_time)
			canjump = true
		
		#Orange player keymap
		if playercolor == "Orange":
			if Input.is_action_pressed("p1_up") and jump_timer.time_left != 0:
				if velocity.y >= jump_speed_cap:
					velocity.y -= jump_speed
				else:
					velocity.y = jump_speed_cap

			#elif Input.is_action_just_released("p1_up"):
				#jump_timer.stop()

			horizontalmovement(Input.get_axis("p1_left", "p1_right"))
		
		#Blue player keymap
		elif playercolor == "Blue":
			if Input.is_action_pressed("p2_up") and jump_timer.time_left != 0:
				if velocity.y >= jump_speed_cap:
					velocity.y -= jump_speed
				else:
					velocity.y = jump_speed_cap

			elif Input.is_action_just_released("p2_up"):
				jump_timer.stop()

			horizontalmovement(Input.get_axis("p2_left", "p2_right"))

		move_and_slide()
#	Freeze player on game over #FIXME In practice doesn't work since entire level is paused 
	elif playerstate == states.gameover:
		velocity = Vector2.ZERO

#Handles player inputs for horizontalmovement
func horizontalmovement(direction):
	if direction:
		if velocity.x <= x_maxspeed and velocity.x >= -x_maxspeed:
			velocity.x += direction * x_acceleration
		else:
			velocity.x = direction * x_maxspeed
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, 50)
	else:
		velocity.x = move_toward(velocity.x, 0, 5)

#If this Player dies this function plays
func death():
#	TODO Make Celeste animation work
	$CPUParticles2D.emitting = true
	playerstate = states.gameover
	Signalbus.playerdeath.emit()
	$CPUParticles2D.emitting = true
	
func _on_hit_detect_area_entered(area):
	#Runs when this player gets hit by projectile
	if area.is_in_group("playerkill"):
		death()
