extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_play_pressed():
	#TODO change out test level for real one
	get_tree().change_scene_to_file("res://Scenes/Levels/test_level_1.tscn")
