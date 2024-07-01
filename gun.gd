extends Node3D

signal particle_hit(damage)

@export var lifetime = 2.0
var fired = false


func _process(delta):
	
	if Input.is_action_just_pressed("click") and !fired:
		pass

