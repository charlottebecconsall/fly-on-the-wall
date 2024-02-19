extends Node2D

@onready var ray_cast: RayCast2D = $RayCast2D
var speed = 600

func _ready():
	ray_cast.target_position = Vector2(speed, 0)

func _physics_process(delta: float) -> void:
	var target_pos = global_position + global_transform.x * speed * delta
	ray_cast.target_position = ray_cast.to_local(target_pos)
	
	ray_cast.force_raycast_update()
	if ray_cast.is_colliding() :
		global_position = ray_cast.get_collision_point()
		var new_dir = global_transform.x.reflect(ray_cast.get_collision_normal().orthogonal())
		global_rotation = new_dir.angle()
	else:
		global_position = target_pos
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner.is_in_group("Flies"):
		area.owner.queue_free()
