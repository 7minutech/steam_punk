extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Human.play("idle")
	$Robot.play("idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_human_button_pressed() -> void:
	play_click_sound()
	await get_tree().create_timer(0.5).timeout
	Global.choosen_player = "human"
	SceneSwitcher.switch_scene("res://scenes/main/level_1.tscn")
	pass # Replace with function body.


func _on_robot_button_pressed() -> void:
	play_click_sound()
	await get_tree().create_timer(0.5).timeout
	Global.choosen_player = "robot"
	SceneSwitcher.switch_scene("res://scenes/main/level_1.tscn")
	pass # Replace with function body.

func play_click_sound():
	$ButtonClick.play()
