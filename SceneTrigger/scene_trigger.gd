class_name SceneTrigger extends Area2D

@export var connected_scene: String
var scene_folder = "res://scenes/"

func _on_body_entered(_body):
	if Global.doors_open == true:
		var full_path = scene_folder + connected_scene + ".tscn"
		var scene_tree = get_tree()
		scene_tree.call_deferred("change_scene_to_file", full_path)
	else:
		return
