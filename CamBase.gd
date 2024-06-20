extends Node3D

@onready var hnode = $HorizontalPivot
@onready var vnode = $HorizontalPivot/VerticalPivot
@onready var camera = $HorizontalPivot/VerticalPivot/SpringArm3D/Camera3D

var horizontal: float = 0.0
var vertical: float = 0.0

@export var hsensitivity: float = 0.07
@export var vsensitivity: float = 0.07

@export var hacceleration: float = 15
@export var vacceleration: float = 15

@export var pitch_max: float = 75
@export var pitch_min: float = -55


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event is InputEventMouseMotion:
		horizontal += -event.relative.x * hsensitivity
		vertical += event.relative.y * vsensitivity


func _physics_process(delta):
	vertical = clamp(vertical, pitch_min, pitch_max)
	
	hnode.rotation_degrees.y = lerp(hnode.rotation_degrees.y, horizontal, hacceleration * delta)
	vnode.rotation_degrees.x = lerp(vnode.rotation_degrees.x, vertical, vacceleration * delta)
