extends CharacterBody2D

class_name Player

signal game_over

@export var speed: float
@export var max_fill: int
@export var bullet  : PackedScene

@onready var camera: Camera2D = $Camera2D
@onready var marker: Marker2D = $Marker2D
@onready var sprite: AnimatedSprite2D = $Sprite as AnimatedSprite2D
@onready var delay_timer: Timer = $Timer

@onready var disk_fill_bar: DiskFillPanel = $"../UI/DiskFillPanel"
var input_vector: Vector2 = Vector2.ZERO

var canMove: bool = true: set = _setCanMove
var gameOver: bool = false


func _ready():
	speed = 100.0
	max_fill = 100
	
func fill_disk_space(size):
	disk_fill_bar.fill += size

func _setCanMove(newCanMove):
	if !newCanMove:
		sprite.stop()
	canMove = newCanMove

var side_right_marker_pos = Vector2(15,0)
var side_left_marker_pos = Vector2(-15,0)
var back_marker_pos = Vector2(8,-5)
var front_marker_pos = Vector2(-6,11)

func _unhandled_input(_event):
	var x_axis: float = Input.get_axis("move_left", "move_right")
	var y_axis: float = Input.get_axis("move_up", "move_down")
	input_vector = (x_axis * Vector2.RIGHT + y_axis * Vector2.DOWN).normalized() 


func _physics_process(_delta: float) -> void:
	if delay_timer.is_stopped() && Input.is_action_pressed("shoot") && !gameOver:
		shoot()
		delay_timer.start()	
	
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
	var mouse_pos = get_viewport().get_mouse_position()
	
	mouse_pos.x -= get_viewport().get_visible_rect().size.x/2
	mouse_pos.y -= get_viewport().get_visible_rect().size.y/2

	mouse_pos = mouse_pos.rotated(PI/4)
		
	if mouse_pos.x > 0:
		if mouse_pos.y > 0:
			sprite.flip_h = false
			sprite.animation = "side"
			marker.position = side_right_marker_pos
		else:
			sprite.animation = "back"
			sprite.flip_h = false
			marker.position = back_marker_pos
	else:
		if mouse_pos.y > 0:
			sprite.animation = "front"
			sprite.flip_h = false
			marker.position = front_marker_pos
		else:
			sprite.flip_h = true
			sprite.animation = "side"
			marker.position = side_left_marker_pos

func shoot():
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	b.transform = marker.global_transform
	var mouse_pos = get_viewport().get_mouse_position()
	mouse_pos.x -= get_viewport().get_visible_rect().size.x/2
	mouse_pos.y -= get_viewport().get_visible_rect().size.y/2
	b.rotation_degrees = mouse_pos.angle() * 180 / PI


func _on_disk_fill_panel_filled_up():
	if gameOver:
		return
	canMove = false
	gameOver = true
	sprite.play()
	sprite.animation = "dead"
