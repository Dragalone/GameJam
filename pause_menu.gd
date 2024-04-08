extends Control

@onready var transition: SceneTransition = $"../../SceneTransition"


func _on_resume_button_pressed():
	visible = false
	get_tree().paused = false


func _on_exit_button_pressed():
	ScoreManager.total_score = 0
	transition.layer = 2
	transition.change_scene("res://Scenes/main_menu.tscn")
	get_tree().paused = false
	# либо поменять сцену на главное меню
