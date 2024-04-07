extends Enemy

class_name HorseEnemy
var enemies_to_spawn = 5
var enemyToSpawn: PackedScene = preload("res://Scenes/enemy.tscn")


func _ready():
	health = 400
	speed = 1.25
	damage = 3
	enemyManager = get_parent()
	enemy_changed.connect(enemyManager.change_enemies)

func _physics_process(_delta):
	if (health <= 0):
		for i in range(enemies_to_spawn):
			var enemy: Enemy = enemyToSpawn.instantiate()
			enemy.position = position + Vector2(randf_range(0,10), randf_range(0,10))
			get_parent().add_child(enemy)
		enemy_changed.emit(enemies_to_spawn - 1)
		queue_free()
		
	if chase:
		#position += (player.position - position).normalized() * speed
		var direction = Vector2.ZERO
		direction = navigation_agent.get_next_path_position() - global_position
		direction = direction.normalized()
		position += direction * speed
		move_and_slide()
		sprite.flip_h = player.position.x - position.x > 0
