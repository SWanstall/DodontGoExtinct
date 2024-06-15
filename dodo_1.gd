extends CharacterBody3D

@export var speed = 200
@export var angular_speed = 2
@export var jump_velocity = 400
@export var fall_acceleration = 75


func _physics_process(delta):
	
	var left: bool = Input.is_action_pressed("ui_left")
	var right: bool = Input.is_action_pressed("ui_right")
	var up: bool = Input.is_action_pressed("ui_up")
	var down: bool = Input.is_action_pressed("ui_down")
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= fall_acceleration * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity * delta

	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if left or right:
		velocity = Vector3(0, 0, 0) # no moving while turning
		rotation -= Vector3(0, input_dir.x, 0) * angular_speed * delta # rotate character
	elif up or down:
		var direction = get_global_transform().basis.z * input_dir.y # find direction character is facing
		velocity = direction * speed * delta # move forwards or back in reference to facing direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed) # when not pressing buttons, smoothly stop
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

