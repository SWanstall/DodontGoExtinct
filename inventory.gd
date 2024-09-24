extends Control

var menu_open = false

signal weapon_select(num)

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_focus_next") and menu_open == false:
		visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		menu_open = true
	elif Input.is_action_just_pressed("ui_focus_next") and menu_open == true:
		visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		menu_open = false


func _on_item_list_item_selected(index):
	weapon_select.emit(index)
	print(index)
