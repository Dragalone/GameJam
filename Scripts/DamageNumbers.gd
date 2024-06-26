extends Node


func display_number(value: int, position: Vector2, is_critical: bool = false):
	var number = Label.new()
	
	number.global_position = position
	number.text = str(value)
	number.z_index = 5
	
	number.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	number.label_settings = LabelSettings.new()
	
	var color = "#FFF"
	if is_critical:
		color = "#F03"
	if value == 0:
		color = "#FF8"
		
	number.label_settings.font_color = color
	number.label_settings.font_size = 100
	number.scale = Vector2(0.1,0.1)
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 0
	number.label_settings.shadow_size = 0
	
	
	#var font = FontVariation.new()
	#font.set_base_font(load("res://Assets/Fonts/PixelCode.ttf"))
#
	#number.label_settings.font = font
	
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size * 0.1 / 2)
	
	var tween = get_tree().create_tween()
	tween.tween_property(
		number, "position:y", number.position.y - 24, 0.25
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:y", number.position.y, 0.5
	).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
	).set_ease(Tween.EASE_IN).set_delay(0.5)
	
	await  tween.finished
	number.queue_free()	


