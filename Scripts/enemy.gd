extends CharacterBody2D

class_name Enemy

@export var HealingBuff  : PackedScene
@export var BoostingBuff  : PackedScene
@export var DamageBuff  : PackedScene
@export var TripleShotBuff  : PackedScene

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
		random_buff_spawn()
		queue_free()
		
	if chase:
		var direction = Vector2.ZERO
		direction = navigation_agent.get_next_path_position() - global_position
		direction = direction.normalized()
		
		position += direction * speed
		#position += (player.position - position).normalized() * speed
		move_and_slide()
		sprite.flip_h = player.position.x - position.x > 0

func random_buff_spawn():
	if (randi_range(0, 100) <= 15):
			var buff_type = randi_range(0,3)
			match  buff_type:
				0: 
					var healling_buff = HealingBuff.instantiate()
					get_tree().root.add_child(healling_buff)
					healling_buff.global_position = global_position
				1:
					var boosting_buff = BoostingBuff.instantiate()
					get_tree().root.add_child(boosting_buff)
					boosting_buff.global_position = global_position
				2:
					var damage_buff = DamageBuff.instantiate()
					get_tree().root.add_child(damage_buff)
					damage_buff.global_position = global_position
				3:
					var triple_shot_buff = TripleShotBuff.instantiate()
					get_tree().root.add_child(triple_shot_buff)
					triple_shot_buff.global_position = global_position

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
