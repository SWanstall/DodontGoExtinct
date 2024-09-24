extends Node

var current_damage = 0
var current_hp = 0

var gun = find_child("Gun")
var grenade = find_child("Grenade")
var inventory = find_child("Inventory")
#@export var gun_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	gun = find_child("Gun")
	if gun:
		gun.shoot.connect(_on_gun_shoot)
		gun.process_mode = Node.PROCESS_MODE_DISABLED
		gun.visible = false
	
	grenade = find_child("Grenade")
	if grenade:
		grenade.throw.connect(_on_grenade_throw)
		grenade.process_mode = Node.PROCESS_MODE_DISABLED
		grenade.visible = false
	
	inventory = find_child("Inventory")
	if inventory:
		inventory.weapon_select.connect(_on_weapon_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_weapon_selected(num):
	#grenade.paused = true
	#gun.paused = true
	if num == 0 and gun:
		grenade.process_mode = Node.PROCESS_MODE_DISABLED
		grenade.visible = false
		gun.process_mode = Node.PROCESS_MODE_DISABLED
		gun.visible = false
		await get_tree().create_timer(0.1).timeout
		gun.process_mode = Node.PROCESS_MODE_INHERIT
		gun.visible = true
	
	
	if num == 1 and grenade:
		gun.process_mode = Node.PROCESS_MODE_DISABLED
		gun.visible = false
		grenade.process_mode = Node.PROCESS_MODE_DISABLED
		grenade.visible = false
		await get_tree().create_timer(0.1).timeout
		grenade.process_mode = Node.PROCESS_MODE_INHERIT
		grenade.visible = true


func _on_gun_shoot(bullet, direction, location, speed, damage):
	#print("FIRED")
	var spawned_bullet = bullet.instantiate()
	add_child(spawned_bullet)
	#spawned_bullet.rotation = direction
	#print(direction)
	spawned_bullet.position = location
	spawned_bullet.velocity = direction * speed
	#print("velocity", spawned_bullet.velocity)
	current_damage = damage


func _on_grenade_throw(grenade, direction, location, speed, damage):
	var spawned_grenade = grenade.instantiate()
	add_child(spawned_grenade)
	#spawned_bullet.rotation = direction
	#print(direction)
	spawned_grenade.position = location
	spawned_grenade.velocity = direction * speed
	current_damage = damage


func _on_target_hit(health, id):
	print("Hit for ", current_damage, " damage!")
	current_hp = health
	current_hp -= current_damage
	print("HP: ", current_hp)
	id.hp = current_hp
	if current_hp <= 0:
		id.queue_free()
