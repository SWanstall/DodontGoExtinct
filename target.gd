extends Node3D

@export var hp = 30

signal hit(health, id)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	$GPUParticlesCollisionBox3D


func _on_area_3d_area_entered(area):
	hit.emit(hp, self)
	#print(self)

