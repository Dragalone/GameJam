extends Control

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

func _process(delta):
	#print("fill:"+str(fill))
	#print("max_fill:"+str(max_fill))
	currentGB_text.text = "Свободно "+str(fill)+" ГБ из "+str(max_fill)+" ГБ"
	if Input.is_action_just_pressed("ui_accept"):
		fill += 1

func _set_fill(new_fill):
	print("new fill:"+str(new_fill))
	var prev_fill = fill
	fill = clamp(new_fill, damage_bar.min_value,damage_bar.max_value)
	print("after clamp fill:"+str(fill))
	damage_bar.value = fill
	if fill != prev_fill:
		timer.start()
	else:
		disk_fill_bar.value = fill

func init_fill(_max_fill):
	fill = 0
	max_fill = _max_fill
	disk_fill_bar.max_value = _max_fill
	disk_fill_bar.value = fill
	damage_bar.max_value = _max_fill
	damage_bar.value = fill

func _on_damage_show_timer_timeout():
	disk_fill_bar.value = fill
