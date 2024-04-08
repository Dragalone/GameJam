extends CanvasLayer

class_name SceneTransition

func change_scene(target: String) -> void:
	transition_dissolve(target)

func transition_dissolve(target: String) -> void:
	$AnimationPlayer.play('dissolve')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards('dissolve')
