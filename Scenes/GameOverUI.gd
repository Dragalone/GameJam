extends CanvasLayer

@onready var scene_transition: SceneTransition = $"../SceneTransition"
@onready var points_label: Label = $VBoxContainer/Points

func _ready():
	points_label.text = "Очки: "+str(ScoreManager.total_score)
	ScoreManager.total_score = 0

func _process(delta):
	if Input.is_action_just_pressed("accept_game_over"):
		scene_transition.layer = 2
		scene_transition.change_scene("res://Scenes/main_menu.tscn")
