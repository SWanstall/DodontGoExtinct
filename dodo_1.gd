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
	var direction = ($Pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if up or down:
		velocity = direction * speed * delta
	elif left or right:
		var target = Basis.looking_at(direction)
		$Pivot.transform  = $Pivot.transform.interpolate_with(target, angular_speed * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	#var rotate = (transform.basis * Vector3(0, input_dir.angle(), 0)).normalized()
	#var move = (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	#if direction:
		##velocity.x = direction.x * speed
		#velocity.z = direction.z * speed
	#else:
		##velocity.x = move_toward(velocity.x, 0, speed)
		#velocity.z = move_toward(velocity.z, 0, speed)


	move_and_slide()
	
	#if direction != Vector3.ZERO:
		## Setting the basis property will affect the rotation of the node.
		#$Pivot.basis = Basis.looking_at(direction)
		
