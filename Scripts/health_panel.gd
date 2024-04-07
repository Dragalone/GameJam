extends Control

class_name DiskFillPanel

@onready var timer: Timer = $VBoxContainer/TextureProgressBar/DamageShowTimer
@onready var disk_fill_bar: TextureProgressBar = $VBoxContainer/TextureProgressBar
@onready var damage_bar: TextureProgressBar = $VBoxContainer/TextureProgressBar/TextureProgressBar
@onready var currentGB_text: Label = $VBoxContainer/HBoxContainer/HBoxContainer/CurrentGB
@onready var player: Player = $"../../Player"

signal filled_up

var fill: int = 0 : set = _set_fill
var max_fill: int = 0

func _ready():
	init_fill(player.max_fill)

func _process(_delta):
	currentGB_text.text = "Свободно "+str(max_fill-fill)+" ГБ из "+str(max_fill)+" ГБ"
	#if Input.is_action_just_pressed("ui_accept"):
		#fill += 10

func _set_fill(new_fill):
	var prev_fill = fill
	fill = clamp(new_fill, damage_bar.min_value,damage_bar.max_value)
	if(fill == max_fill):
		filled_up.emit()
		return
	damage_bar.value = fill
	if fill != prev_fill:
		timer.start()
	else:
		disk_fill_bar.value = fill

func init_fill(_max_fill):
	max_fill = _max_fill
	fill = 0
	disk_fill_bar.max_value = _max_fill
	disk_fill_bar.value = fill
	damage_bar.max_value = _max_fill
	damage_bar.value = fill

func _on_damage_show_timer_timeout():
	disk_fill_bar.value = fill
