extends Node2D


# Called when the node enters the scene tree for the first time.
func _on_return_to_start_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
