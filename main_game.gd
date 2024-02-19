extends Node2D

var num_flies = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Puts defined number of flies in random places
	for i in num_flies:
		var fly_scene = preload("res://fly.tscn")
		var fly = fly_scene.instantiate() as Node2D
		add_child(fly)
		fly.position = Vector2(randi() % get_window().size.x, randi() % get_window().size.y)
		fly.rotation_degrees = randi() % 360


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
