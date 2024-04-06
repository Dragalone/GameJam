extends CharacterBody2D

class_name Player

signal game_over

@export var speed: float = 100.0
@export var max_fill: int = 100
@onready var sprite: AnimatedSprite2D = $Sprite as AnimatedSprite2D
@onready var disk_fill_bar: DiskFillPanel = $"../UI/DiskFillPanel"
var input_vector: Vector2 = Vector2.ZERO

var canMove: bool = true: set = _setCanMove
var gameOver: bool = false

func fill_disk_space(size):
	disk_fill_bar.fill += size

func _setCanMove(newCanMove):
	if !newCanMove:
		sprite.stop()
	canMove = newCanMove

func _unhandled_input(_event):
	var x_axis: float = Input.get_axis("move_left", "move_right")
	var y_axis: float = Input.get_axis("move_up", "move_down")
	input_vector = (x_axis * Vector2.RIGHT + y_axis * Vector2.DOWN).normalized()

func _physics_process(_delta: float) -> void:
	if gameOver or !canMove:
		return
	if input_vector.length() > 0:
		velocity = input_vector * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)
	if velocity.length() > 0:
		sprite.play()
	else:
		sprite.stop()
	
	move_and_slide()
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0
		sprite.animation = "side"
	elif velocity.y != 0:
		if velocity.y > 0:
			sprite.animation = "front"
		else:
			sprite.animation = "back"


func _on_disk_fill_panel_filled_up():
	if gameOver:
		return
	canMove = false
	gameOver = true
	sprite.play()
	sprite.animation = "dead"
