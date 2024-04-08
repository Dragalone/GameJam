extends Area2D

class_name HealingBuff

var hp: int

@onready var timer: Timer = $Timer

func _ready():
	hp = 20
	timer.start()

func _on_timer_timeout():
	queue_free()

func _process(delta):
	pass
	
func _on_body_entered(body):
	if body is Player:
		$"../../Sounds/Bonus".play()
		if (body.disk_fill_bar.fill < hp):
			body.disk_fill_bar.fill=0
			
		else:
			body.disk_fill_bar.fill-=hp
		queue_free()
