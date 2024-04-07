extends Area2D

class_name BoostingBuff

var hit_rate: float 

@onready var timer: Timer = $Timer


func _ready():
	hit_rate = 0.2
	timer.start()

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.boosting_timer.start()
		body.delay_timer.wait_time = hit_rate
	queue_free()
