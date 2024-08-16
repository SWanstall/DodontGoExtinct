extends Node3D

var fired = false

signal shoot(bullet, direction, location, speed)

var Bullet = preload("res://bullet.tscn")

@export var bullet_speed = 1000


func _process(delta):
	
	if Input.is_action_just_pressed("click") and !fired:
		shoot.emit(Bullet, -global_transform.basis.z, global_position, bullet_speed*delta)
		print(-global_transform.basis.z)

