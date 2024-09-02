extends Node

var current_damage = 0
var current_hp = 0

#@export var gun_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var gun = find_child("Gun")
	if gun:
		gun.shoot.connect(_on_gun_shoot)
	
	var grenade = find_child("Grenade")
	if grenade:
		grenade.throw.connect(_on_grenade_throw)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gun_shoot(bullet, direction, location, speed, damage):
	var spawned_bullet = bullet.instantiate()
	add_child(spawned_bullet)
	#spawned_bullet.rotation = direction
	#print(direction)
	spawned_bullet.position = location
	spawned_bullet.velocity = direction * speed
	#print("velocity", spawned_bullet.velocity)
	current_damage = damage


func _on_target_hit(health, id):
	print("Hit for ", current_damage, " damage!")
	current_hp = health
	current_hp -= current_damage
	print("HP: ", current_hp)
	id.hp = current_hp
	if current_hp <= 0:
		id.queue_free()


func _on_grenade_throw(grenade, direction, location, speed):
	var spawned_grenade = grenade.instantiate()
	add_child(spawned_grenade)
	#spawned_bullet.rotation = direction
	#print(direction)
	spawned_grenade.position = location
	spawned_grenade.velocity = direction * speed
