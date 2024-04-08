extends Node

@onready var transition: SceneTransition = $"../SceneTransition"

func _on_player_game_over():
	transition.layer = 2
	transition.change_scene("res://Scenes/game_over.tscn")
