extends RigidBody2D

signal white_entered_hole()

var shot_force = 1
var dragging = false
var rolling = false
var falling = false
var target

func _process(delta):
	if mode == MODE_STATIC:
		if dragging:
			$Line.global_rotation = 0
			$Line.points[1] = (get_global_mouse_position() - global_position)
		if falling:
			global_position = lerp(global_position, target, delta)
	else:
		if(!rolling and linear_velocity.length() < 15):
			mode = MODE_STATIC

func set_dragging(value):
	dragging = value
	if !value:
		$Line.points[1] = Vector2.ZERO
		mode = MODE_RIGID
		rolling = true
		$ShotTimer.start()
		apply_central_impulse((global_position - get_global_mouse_position())*shot_force)

func _input_event(_viewport, event, _shape_idx):
	if mode == MODE_STATIC and event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		set_dragging(event.is_pressed())

func _on_ShotTimer_timeout():
	rolling = false

func _on_HoleArea_entered(area):
	target = area.global_position
	$Tween.interpolate_property($Sprite,"modulate",null,Color(1,1,1,0),.7,Tween.TRANS_SINE,Tween.EASE_IN)
	$Tween.interpolate_property($Sprite,"scale",null,Vector2(0.25,0.25),.7,Tween.TRANS_SINE,Tween.EASE_IN)
	$Tween.start()
	$Timer.start()
	linear_velocity = Vector2.ZERO
	falling = true
	set_deferred("mode",MODE_STATIC)

func _on_Timer_timeout():
	queue_free()
	emit_signal("white_entered_hole")
