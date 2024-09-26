extends Node3D

var velocity = Vector3.FORWARD
var primed = false

@export var grenade_damage = 15

signal exploded


func _ready():
	$Area3D.process_mode = Node.PROCESS_MODE_DISABLED


func _physics_process(delta):
	position += velocity * delta
	if Input.is_action_just_pressed("click"):
		primed = true
	if Input.is_action_just_pressed("click") and primed:
		primed = false
		$RigidBody3D/CollisionShape3D/MeshInstance3D.visible = false
		$shrapnel.emitting = true
		$smoke.emitting = true
		$Area3D.process_mode = Node.PROCESS_MODE_INHERIT
		await get_tree().create_timer(1).timeout
		queue_free()


func _on_timer_timeout():
	print("Bang!")
	$RigidBody3D/CollisionShape3D/MeshInstance3D.visible = false
	$shrapnel.emitting = true
	$smoke.emitting = true
	$Area3D.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(1).timeout
	queue_free()
	
	
