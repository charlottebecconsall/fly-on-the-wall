extends Node2D

@onready var preview_ray: RayCast2D = $PreviewRay
@onready var preview_line: Line2D = $PreviewLine

signal bullet_left

var can_shoot = true
var gun_rotation_speed = 0.005

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("aim_left"):
		rotate(delta * -gun_rotation_speed)
		gun_rotation_speed += 0.005
	if Input.is_action_pressed("aim_right"):
		rotate(delta * gun_rotation_speed)
		gun_rotation_speed += 0.005
	if Input.is_action_just_released("aim_left") or Input.is_action_just_released("aim_right"):
		gun_rotation_speed = 0.005
	update_preview_line()

func update_preview_line():
	preview_ray.transform = Transform2D.IDENTITY
	
	preview_line.clear_points()
	preview_line.add_point(Vector2(0,0))
	
	for i in 100:
		preview_ray.force_raycast_update()
		if preview_ray.is_colliding():
			var point = preview_ray.get_collision_point()
			var norm = preview_ray.get_collision_normal()
			preview_line.add_point(to_local(point))
			var new_dir = preview_ray.global_transform.x.reflect(norm.orthogonal())
			preview_ray.global_position = point + new_dir*8
			preview_ray.global_rotation = new_dir.angle()
		else:
			preview_line.add_point(to_local(preview_ray.to_global(preview_ray.target_position)))
			break


func shoot():
	if not can_shoot:
		return
	$Gunshot.play()
	var bullet = preload("res://scenes/bullet.tscn").instantiate() as Node2D
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation
	bullet.tree_exited.connect(bullet_left.emit)
	add_sibling(bullet)
	can_shoot = false
