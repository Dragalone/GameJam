extends CharacterBody2D

var speed: float = 50
var player: Player = null
var chase = false
var canDamage: bool = false
var cooldown: bool = false
@onready var attackDelay: Timer = $DelayAttackTimer
@onready var sprite: AnimatedSprite2D = $Sprite

func _physics_process(delta):
	if chase:
		position += (player.position - position) / speed
		move_and_slide()
		sprite.flip_h = player.position.x - position.x > 0
	

func _on_detection_area_body_entered(body):
	if body is Player:
		player = body
		chase = true
		sprite.animation = "move"
		sprite.play()


func _on_detection_area_body_exited(body):
	if body is Player:
		chase = false
		player = null
		sprite.stop()


func _on_attack_area_body_entered(body):
	if body is Player:
		sprite.animation = "eat"
		canDamage = true


func _on_attack_area_body_exited(body):
	if body is Player:
		sprite.animation = "move"
		canDamage = false


func _on_delay_attack_timer_timeout():
	cooldown = false
	sprite.play()


func _on_sprite_animation_finished():
	print("animation finished")
	player.fill_disk_space(1)
	sprite.stop()
	attackDelay.start()
