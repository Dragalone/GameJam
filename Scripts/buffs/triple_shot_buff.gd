extends Area2D

class_name TripleShotBuff


@onready var timer: Timer = $Timer
@onready var buff_indicator = $"../../UI/DisplayBuffs/HBoxContainer/TripleShotDisplay"

func _ready():
	timer.start()

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body is Player:
		$"../../Sounds/Bonus".play()
		buff_indicator.visible = true
		body.triple_shot_timer.start()
		body.is_triple_shot_active = true
		queue_free()
