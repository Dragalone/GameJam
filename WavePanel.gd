extends Control

@onready var wave_number_text = $Background/MarginContainer/VBoxContainer/WaveNumber
@onready var enemies_left_text = $Background/MarginContainer/VBoxContainer/EnemiesLeft

var timeoutSecondsLeft = 0

func _make_timeout_text(seconds: int):
	enemies_left_text.text = "Следующая волна через " + str(seconds)

func _on_wave_manager_wave_changed(num: int):
	wave_number_text.text = "Волна: "+str(num)


func _on_wave_timeout_timeout():
	timeoutSecondsLeft = 0
	enemies_left_text.text = "Волна начинается!"


func _on_wave_countdown_timeout():
	timeoutSecondsLeft -= 1
	_make_timeout_text(timeoutSecondsLeft)


func _on_wave_manager_timeout_set(seconds: int):
	timeoutSecondsLeft = seconds
	_make_timeout_text(timeoutSecondsLeft)
	


func _on_wave_manager_enemies_left_set(enemies: int):
	enemies_left_text.text = "Осталось врагов: "+str(enemies)
