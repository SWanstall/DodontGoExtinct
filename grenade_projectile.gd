extends Node3D

var velocity = Vector3.FORWARD

@export var grenade_damage = 15

signal exploded


func _ready():
	$Area3D.set_process(false)


func _physics_process(delta):
	position += velocity * delta


func _on_timer_timeout():
	$RigidBody3D/CollisionShape3D/MeshInstance3D.visible = false
	$shrapnel.emitting = true
	$smoke.emitting = true
	$Area3D.set_process(true)
	await get_tree().create_timer(1).timeout
	queue_free()
	
	
