extends Node

@onready var pause_menu: Control = $UI/PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_menu.visible = false


# Called every frame. 'delta' is the elapsed t                     ime since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		pause_menu.visible = true
