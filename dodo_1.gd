extends CharacterBody3D

@export var speed = 200
@export var angular_speed = 2
@export var jump_velocity = 600
@export var fall_acceleration = 50

var input_dir = 0
var rotation_dir = 0

var left = false
var right = false
var up = false
var down = false
var jump = false


func get_input():
	rotation_dir = 0
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
		right = true
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1
		left = true
	if Input.is_action_pressed("ui_down"):
		input_dir = 1
		down = true
	if Input.is_action_pressed("ui_up"):
		input_dir = -1
		up = true
		# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump = true
	#if InputEventMouseMotion:
		#


func _physics_process(delta):
	
	left = false
	right = false
	up = false
	down = false
	jump = false
	
	get_input()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= fall_acceleration * delta
		#print("FALLING")
	
	if left or right:
		velocity.x = 0 # no moving while turning
		velocity.z = 0
		rotation -= Vector3(0, rotation_dir, 0) * angular_speed * delta # rotate character
	elif up or down:
		var direction = get_global_transform().basis.z * input_dir # find direction character is facing
		velocity.x = direction.x * speed * delta # move forwards or back in reference to facing direction
		velocity.z = direction.z * speed * delta
		
	else:
		velocity.x = move_toward(velocity.x, 0, speed) # when not pressing buttons, smoothly stop
		velocity.z = move_toward(velocity.z, 0, speed)
	
	if jump:
		velocity.y = jump_velocity * delta
		#print("jump")
	
	move_and_slide()

