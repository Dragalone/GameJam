extends Area2D
class_name Bullet


var speed: int
var damage: int
var crit_chance: float
@onready var timer: Timer = $Timer


func _ready():
	damage = 20
	speed = 750
	crit_chance = 0.2
	timer.start()
	
func _physics_process(delta):
	position += transform.x * speed * delta
	

func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if body is Enemy:
		var cur_damage = damage
		var is_critical = crit_chance > randf()
		if (is_critical):
			cur_damage = cur_damage * 1.5
		body.health -= cur_damage
		DamageNumbers.display_number(cur_damage,body.damage_numbers_origin.global_position,is_critical)
	queue_free()
