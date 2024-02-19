extends Node2D

signal ricoshooter_removed
signal ricoshooter_moved

var moving = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("remove_ricoshooter"):
		ricoshooter_removed.emit()
		queue_free()
		
