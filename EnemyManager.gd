extends Node

class_name EnemyManager

signal enemy_changed(count:int)

# Called when the node enters the scene tree for the first time.
func change_enemies(count:int):
	enemy_changed.emit(count)
