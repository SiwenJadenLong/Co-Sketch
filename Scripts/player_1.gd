extends CharacterBody2D

var canjump = true

#state machine
enum states {idle, running, gliding, editting, gameover}
var playerstate

@onready var jumptimer = $Timer

#Player movement variables
@export_enum("Orange","Blue") var player : String

@export var Xacceleration : float = 50
@export var Jumptime : float = 0.08
@export var Jumpspeed : int = 80
@export var Jumpspeedcap : int = -500
@export var Camera_Speed : int = 1
@export var Gound_Reistance : int = 40
@export var Air_Reistance : int = 15
#@export var Timescale : float = 0.5



func _ready():
	playerstate = states.idle
	if player == "Orange":
		$Sprite2D.self_modulate = Color(1,1,0)
		$Label.text = "P1 ORANGE"
	elif player == "Blue":
		$Sprite2D.self_modulate = Color(1.0, 0.6, 0.0)
		$Label.text = "P2 BLUE"
		

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		playerstate = states.gliding
	else:
		jumptimer.start(Jumptime)
		canjump = true
		velocity.y = 0
	if playerstate != states.editting or playerstate != states.gameover:
		#Orange player keymap
		if player == "Orange":
			if Input.is_action_pressed("p1_up") and jumptimer.time_left != 0:
				if velocity.y >= Jumpspeedcap:
					velocity.y -= Jumpspeed
				else:
					velocity.y = Jumpspeedcap

			elif Input.is_action_just_released("p1_up"):
				jumptimer.stop()

			horizontalmovement(Input.get_axis("p1_left", "p1_right"))
		
		#Blue player keymap
		elif player == "Blue":
			if Input.is_action_pressed("p2_up") and jumptimer.time_left != 0:
				if velocity.y >= Jumpspeedcap:
					velocity.y -= Jumpspeed
				else:
					velocity.y = Jumpspeedcap

			elif Input.is_action_just_released("p2_up"):
				jumptimer.stop()

			horizontalmovement(Input.get_axis("p2_left", "p2_right"))

		move_and_slide()
	elif states.gameover:
		process_mode = Node.PROCESS_MODE_DISABLED

#Handles player inputs for horizontalmovement
func horizontalmovement(direction):
	if direction:
		if velocity.x <= 200 and velocity.x >= -200:
			velocity.x += direction * Xacceleration
		else:
			velocity.x = direction * 200
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, 50)
	else:
		velocity.x = move_toward(velocity.x, 0, 5)

#If this Player dies this function plays
func death():
	$CPUParticles2D.emitting = true
	await $CPUParticles2D.finished
	Signalbus.playerdeath.emit()
	
func _on_hit_detect_area_entered(area):
	#Runs when this player gets hit by projectile
	if area.is_in_group("Projectile"):
		death()
