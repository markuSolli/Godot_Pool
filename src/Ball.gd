extends RigidBody2D

signal entered_hole(hole)
var target
var hole

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	global_position = lerp(global_position, target, delta)

func _on_HoleArea_entered(area: Area2D):
	target = area.global_position
	$Tween.interpolate_property($Sprite,"modulate",null,Color(1,1,1,0),.7,Tween.TRANS_SINE,Tween.EASE_IN)
	$Tween.interpolate_property($Sprite,"scale",null,Vector2(0.25,0.25),.7,Tween.TRANS_SINE,Tween.EASE_IN)
	$Tween.start()
	$Timer.start()
	linear_velocity = Vector2.ZERO
	set_physics_process(true)
	hole = area

func _on_Timer_timeout():
	emit_signal("entered_hole",hole)
	queue_free()
