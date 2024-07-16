extends Node3D

var velocity = Vector3.FORWARD

func _physics_process(delta):
	position += velocity * delta
