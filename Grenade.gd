extends Node3D

var thrown = false

@export var grenade_speed = 700
@export var grenade_damage = 15

var Grenade = preload("res://grenade_projectile.tscn")

signal throw(grenade, direction, location, speed, damage)


func _ready():
	#await get_tree().create_timer(0.5).timeout
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click")  and !thrown:
		thrown = true
		throw.emit(Grenade, -global_transform.basis.z, global_position, grenade_speed*delta, grenade_damage)
		visible = false
		#process_mode = Node.PROCESS_MODE_DISABLED

