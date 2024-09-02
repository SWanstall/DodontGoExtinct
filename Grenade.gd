extends Node3D

@export var grenade_speed = 700

var Grenade = preload("res://grenade_projectile.tscn")

signal throw(grenade, direction, location, speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click"):
		throw.emit(Grenade, -global_transform.basis.z, global_position, grenade_speed*delta)
		queue_free()
