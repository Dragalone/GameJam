extends Area2D

class_name DamageBuff

var damage: float 

@onready var timer: Timer = $Timer


func _ready():
	damage = 40
	timer.start()

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.damage = damage
		body.damage_boost_timer.start()
	queue_free()
