extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicAutoplay.play_file("res://assets/Menu Music.mp3")
