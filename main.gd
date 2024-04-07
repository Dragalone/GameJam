extends Node2D

@onready var camera: Camera2D = $Player/Camera2D
@onready var marker_top_left = $CameraLimits/TopLeft
@onready var marker_bottom_right = $CameraLimits/BottomRight
# Called when the node enters the scene tree for the first time.
func _ready():
	#camera.limit_top = marker_top_left.position.y
	#camera.limit_left = marker_top_left.position.x
	#camera.limit_right = marker_bottom_right.position.x
	#camera.limit_bottom = marker_bottom_right.position.y
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
