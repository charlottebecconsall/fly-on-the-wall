extends Node2D

@onready var wing_buzz_timer: Timer = $WingBuzzTimer

func _ready() -> void:
	wing_buzz_timer.start(randf_range(0.5, 3.0))

func buzz_wings():
	var fly_sprite = $Area2D/Fly
	var tween = create_tween()
	for i in randi_range(4, 10):
		tween.tween_callback(fly_sprite.set_frame.bind(1))
		tween.tween_interval(0.02)
		tween.tween_callback(fly_sprite.set_frame.bind(0))
		tween.tween_interval(0.02)
	tween.tween_callback(wing_buzz_timer.start.bind(randf_range(0.5, 3.0)))
