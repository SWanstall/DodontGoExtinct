extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gun_shoot(bullet, direction, location, speed):
	var spawned_bullet = bullet.instantiate()
	add_child(spawned_bullet)
	#spawned_bullet.rotation = direction
	#print(direction)
	spawned_bullet.position = location
	spawned_bullet.velocity = direction * speed
	print("velocity", spawned_bullet.velocity)
