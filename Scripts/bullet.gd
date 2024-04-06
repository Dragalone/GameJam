extends Area2D

var speed = 750
@onready var timer: Timer = $Timer
func _ready():
	timer.start()
	
func _physics_process(delta):
	position += transform.x * speed * delta
	

func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if body is Enemy:
		body.queue_free()
	queue_free()
