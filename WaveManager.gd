extends Node

class_name WaveManager

@export var enemy_list: Array[PackedScene]
@export var spawn_rate: Array[float]
@export var spawn_points: Array[Marker2D]

@onready var timeoutTimer = $WaveTimeout
@onready var countdownTimer = $WaveCountdown

signal waveChanged(num: int)
signal timeoutSet(seconds: int)
signal enemiesLeftSet(enemies: int)

var wave: int = 0 : set = _set_wave
var timeout_value = 5
var enemies_left: int = 0
var timeout: bool = false
var wave_fighting: bool = false

func _set_wave(new_num):
	waveChanged.emit(new_num)
	wave = new_num

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func change_enemy(count: int):
	enemies_left += count
	enemiesLeftSet.emit(enemies_left)
	if enemies_left <= 0:
		enemies_left = 0
		timeoutTimer.start(timeout_value)
		countdownTimer.start()
		timeoutSet.emit(timeout_value)
		timeout = true
		wave_fighting = false

func _start_wave():
	wave_fighting = true
	
	enemies_left = int(0.5 * wave * wave + 6)
	
	var enemies_to_spawn = enemies_left
	while enemies_to_spawn > 0:
		var rnd = randf_range(0,1)
		for i in range(len(enemy_list)):
			if rnd > spawn_rate[i]:
				var enemy: Enemy = enemy_list[i].instantiate()
				var spawn_id = randi_range(0, len(spawn_points)-1)
				enemy.position = spawn_points[spawn_id].position + Vector2(randf_range(0, 5), randf_range(0, 5))
				get_node("../EnemyManager").add_child(enemy)
				await get_tree().create_timer(0.5).timeout
				enemies_to_spawn -= 1
				if enemies_to_spawn == 0:
					break
	enemiesLeftSet.emit(enemies_left)
	wave += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if timeout or wave_fighting:
		return
	_start_wave()


func _on_wave_timeout_timeout():
	countdownTimer.stop()
	timeout = false
