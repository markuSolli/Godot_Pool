extends Area2D

var areas = []
var bodies = []
var valid = false
var dragging = false

func _ready():
	verify()

func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position()
		verify()

func verify():
	if areas.size() == 1 and bodies.size() == 0:
		valid = true
		$Sprite.modulate = Color.green
	else:
		valid = false
		$Sprite.modulate = Color.red

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		dragging = event.is_pressed()

func _on_area_entered(area):
	areas.append(area)
	verify()

func _on_area_exited(area):
	areas.erase(area)
	verify()

func _on_body_entered(body):
	bodies.append(body)
	verify()

func _on_body_exited(body):
	bodies.erase(body)
	verify()
