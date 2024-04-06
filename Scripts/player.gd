extends CharacterBody2D

class_name Player

@export var speed: float = 100.0

@onready var sprite: AnimatedSprite2D = $Sprite as AnimatedSprite2D

var input_vector: Vector2 = Vector2.ZERO

var canMove: bool = true

func _unhandled_input(_event):
	var x_axis: float = Input.get_axis("move_left", "move_right")
	var y_axis: float = Input.get_axis("move_up", "move_down")
	input_vector = (x_axis * Vector2.RIGHT + y_axis * Vector2.DOWN).normalized() 
		

func _physics_process(_delta: float) -> void:
	if !canMove:
		sprite.stop()
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
	print(position)
	var mouse_pos = get_viewport().get_mouse_position()
	
	mouse_pos.x -= get_viewport().get_visible_rect().size.x/2
	mouse_pos.y -= get_viewport().get_visible_rect().size.y/2

	mouse_pos = mouse_pos.rotated(PI/4)
	
	if mouse_pos.x > 0:
		if mouse_pos.y > 0:
			sprite.flip_h = false
			sprite.animation = "side"
		else:
			sprite.animation = "back"
	else:
		if mouse_pos.y > 0:
			sprite.animation = "front"
		else:
			sprite.flip_h = true
			sprite.animation = "side"
