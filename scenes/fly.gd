extends Node2D

@onready var wing_buzz_timer: Timer = $WingBuzzTimer

signal died

func _ready() -> void:
	wing_buzz_timer.start(randf_range(0.5, 3.0))

func buzz_wings():
	var fly_sprite = $Fly
	var tween = create_tween()
	for i in randi_range(4, 10):
		tween.tween_callback(fly_sprite.set_frame.bind(1))
		tween.tween_interval(0.02)
		tween.tween_callback(fly_sprite.set_frame.bind(0))
		tween.tween_interval(0.02)
	tween.tween_callback(wing_buzz_timer.start.bind(randf_range(0.5, 3.0)))


func _on_fly_entered(area: Area2D) -> void:
	if area.is_in_group("Ricoshooters"):
		if !area.owner.is_queued_for_deletion():
			area.owner.ricoshooter_removed.emit()
			area.owner.queue_free()
