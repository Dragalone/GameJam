extends CharacterBody2D
class_name Enemy


var health: int
var speed: float
var damage: int
var player: Player = null

var chase = false
var canDamage: bool = false
var cooldown: bool = false
@onready var attackDelay: Timer = $DelayAttackTimer
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var damage_numbers_origin = $DamageNumbersOrigin
@onready var navigation_agent = $Navigation/NavigationAgent2D

var enemyManager: EnemyManager

signal enemy_changed(count: int)

func _ready():
	health = 120
	speed = 1.5
	damage = 1
	enemyManager = get_parent()
	enemy_changed.connect(enemyManager.change_enemies)

func _physics_process(_delta):
	if (health <= 0):
		enemy_changed.emit(-1)
		queue_free()
		
	if chase:
		var direction = Vector2.ZERO
		direction = navigation_agent.get_next_path_position() - global_position
		direction = direction.normalized()
		
		position += direction * speed
		#position += (player.position - position).normalized() * speed
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
	player.fill_disk_space(damage)
	sprite.stop()
	attackDelay.start()


func _on_nav_timer_timeout():
	if player != null:
		navigation_agent.target_position = player.global_position
