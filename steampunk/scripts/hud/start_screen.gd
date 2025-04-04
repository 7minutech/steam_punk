extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_start_button_pressed() -> void:
	play_click_sound()
	await get_tree().create_timer(0.5).timeout
	SceneSwitcher.switch_scene("res://scenes/hud/controls.tscn")
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	play_click_sound()
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
	pass # Replace with function body.

func play_click_sound():
	$ButtonClick.play()
	
