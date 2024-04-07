extends Area2D

class_name TripleShotBuff


@onready var timer: Timer = $Timer


func _ready():
	timer.start()

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.triple_shot_timer.start()
		body.is_triple_shot_active = true
	queue_free()
