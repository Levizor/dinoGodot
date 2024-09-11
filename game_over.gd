extends Control



func _process(_delta: float) -> void:
	if Input.is_action_pressed("Jump"):
		get_tree().paused=false
		get_tree().reload_current_scene()
		
func _on_visibility_changed() -> void:
	$VBoxContainer/Score/Label.text="Score:   %s" % int(Globals.score)
	
