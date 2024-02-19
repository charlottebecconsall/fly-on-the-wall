extends Node2D

var num_flies = 10
var num_ricoshooters = 3

func load_flies(num_flies):
	for i in num_flies:
		var fly_scene = preload("res://scenes/fly.tscn")
		var fly = fly_scene.instantiate() as Node2D
		add_child(fly)
		fly.entry_refused.emit(reject_ricoshooter)
		fly.position = Vector2(randi() % (get_window().content_scale_size.x-100), randi() % (get_window().content_scale_size.y-100))
		fly.rotation_degrees = randi() % 360
		

func load_ricoshooter_info(num_ricoshooters):
	$RicoshooterNum.text = str(num_ricoshooters)
	
	
func remove_ricoshooter():
	num_ricoshooters += 1
	load_ricoshooter_info(num_ricoshooters)
	
	
func reject_ricoshooter():
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Prepares game by loading in all the essentials
	load_flies(num_flies)
	load_ricoshooter_info(num_ricoshooters)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("place_ricoshooter") and num_ricoshooters > 0:
		var ricoshooter_scene = preload("res://scenes/ricoshooters.tscn")
		var ricoshooter = ricoshooter_scene.instantiate()
		add_child(ricoshooter)
		ricoshooter.position = get_global_mouse_position()
		ricoshooter.ricoshooter_removed.connect(remove_ricoshooter)
		num_ricoshooters -= 1
		load_ricoshooter_info(num_ricoshooters)
	
