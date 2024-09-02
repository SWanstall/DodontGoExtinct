extends Node3D

var velocity = Vector3.FORWARD


func _physics_process(delta):
	position += velocity * delta


func _on_timer_timeout():
	queue_free()
	print("Explosion!")
