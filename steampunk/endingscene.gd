extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MenuMusic.stop()
	$WinMusic.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_pressed() -> void:
	$Click.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
	pass # Replace with function body.
