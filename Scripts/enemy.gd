extends CharacterBody2D
class_name Enemy

@export var HealingBuff  : PackedScene
@export var BoostingBuff  : PackedScene
@export var DamageBuff  : PackedScene
@export var TripleShotBuff  : PackedScene

var health: int
var speed: float
var player: Player = null

var chase = false
var canDamage: bool = false
var cooldown: bool = false
@onready var attackDelay: Timer = $DelayAttackTimer
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var damage_numbers_origin = $DamageNumbersOrigin

func _ready():
	health = 120
	speed = 50


func _physics_process(delta):
	if (health <= 0):
		random_buff_spawn()
		#var healling_buff = HealingBuff.instantiate()
		#get_tree().root.add_child(healling_buff)
		#healling_buff.global_position = global_position
		
		#var boosting_buff = BoostingBuff.instantiate()
		#get_tree().root.add_child(boosting_buff)
		#boosting_buff.global_position = global_position
		
		#var damage_buff = DamageBuff.instantiate()
		#get_tree().root.add_child(damage_buff)
		#damage_buff.global_position = global_position
		
		#var triple_shot_buff = TripleShotBuff.instantiate()
		#get_tree().root.add_child(triple_shot_buff)
		#triple_shot_buff.global_position = global_position
		
		queue_free()
		
	if chase:
		position += (player.position - position) / speed
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
	print("animation finished")
	player.fill_disk_space(1)
	sprite.stop()
	attackDelay.start()
