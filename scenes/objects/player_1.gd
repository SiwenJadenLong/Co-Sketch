extends CharacterBody2D

var canjump = true


@onready var jumptimer = $Timer

#Player movement variables
@export var Xacceleration : float = 50
@export var Jumptime : float = 0.08
@export var Jumpspeed : int = 80
@export var Jumpspeedcap : int = -500
@export var Camera_Speed : int = 1
@export var Gound_Reistance : int = 40
@export var Air_Reistance : int = 15


func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumptimer.start(Jumptime)
		canjump = true
	
	if Input.is_action_pressed("ui_up") and jumptimer.time_left != 0:
		if velocity.y >= Jumpspeedcap:
			velocity.y -= Jumpspeed
		else:
			velocity.y = Jumpspeedcap
	elif Input.is_action_just_released("ui_up"):
		jumptimer.stop()

	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		if velocity.x <= 200 and velocity.x >= -200:
			velocity.x += direction * Xacceleration
		else:
			velocity.x = direction * 200
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, 40)
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	#$Camera2D.position_smoothing_speed = 7 + velocity.length() * CameraSpeedmultiplier
	#print($Camera2D.position_smoothing_speed)
	
	move_and_slide()
