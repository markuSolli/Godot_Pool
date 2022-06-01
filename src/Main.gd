extends Node2D

var WhiteBall = preload("res://WhiteBall.tscn")

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and !event.is_pressed():
		if $WhiteBall.dragging:
			$WhiteBall.set_dragging(false)

func _on_Ball_entered_hole(_hole, _ball_index):
	pass

func _on_white_entered_hole():
	var white_ball = WhiteBall.instance()
	add_child(white_ball)
	white_ball.global_position = Vector2(1060,380)

func _on_Button_pressed():
	get_tree().reload_current_scene()
