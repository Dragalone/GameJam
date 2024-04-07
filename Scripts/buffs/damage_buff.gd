extends Area2D

class_name DamageBuff

var damage_scale: float 

@onready var timer: Timer = $Timer


func _ready():
	damage_scale = 2
	timer.start()

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.damage*=damage_scale
		body.damage_boost_timer.start()
	queue_free()
