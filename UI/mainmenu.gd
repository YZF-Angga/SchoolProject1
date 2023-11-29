extends Control



func _on_button_pressed():
	get_tree().change_scene_to_file("res://world_map.tscn")
	
	
	if Input.is_action_just_pressed("Exit"):
		get_tree().quit(
			
		)
