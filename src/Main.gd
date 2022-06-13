extends Node2D

var spawn = null
var SpawnSprite = preload("res://SpawnSprite.tscn")

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and !event.is_pressed():
		if $WhiteBall.dragging:
			$WhiteBall.set_dragging(false)

func _on_Ball_entered_hole(_hole, _ball_index):
	pass

func _on_white_entered_hole():
	$UI/PlaceButton.visible = true
	var spawn_sprite = SpawnSprite.instance()
	spawn_sprite.global_position = Vector2(1060,380)
	add_child(spawn_sprite)
	spawn = spawn_sprite

func _on_PlaceButton_pressed():
	if spawn.valid:
		$UI/PlaceButton.visible = false
		$WhiteBall.respawn(spawn.global_position)
		spawn.queue_free()
		spawn = null

func _on_ResetButton_pressed():
	get_tree().reload_current_scene()
