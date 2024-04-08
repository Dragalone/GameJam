extends Control

@onready var transition: SceneTransition = $SceneTransition
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	transition.layer = 2
	transition.change_scene("res://main.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
