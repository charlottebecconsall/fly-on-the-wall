extends Node2D

@onready var ray_cast: RayCast2D = $RayCast2D
var speed = 600
var bullet_points: PackedVector2Array
var target_index = 0

func _ready():
	ray_cast.target_position = Vector2(speed, 0)

func _physics_process(delta: float) -> void:
	global_rotation = rotation + get_angle_to(bullet_points[target_index])
	global_position = position.move_toward(bullet_points[target_index], speed*delta)
	if global_position == bullet_points[target_index]:
		target_index += 1	
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner.is_in_group("Flies"):
		area.owner.queue_free()
		area.owner.died.emit()
	if area.name == "OutOfBounds":
		queue_free()
