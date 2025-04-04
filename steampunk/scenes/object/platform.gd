extends AnimatableBody2D
@export var final: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player") and final:
		if Global.current_name_level == "Level_1":
			SceneSwitcher.switch_scene("res://scenes/main/level_2.tscn")
		elif Global.current_name_level == "Level_2":
			SceneSwitcher.switch_scene("res://scenes/main/level_3.tscn")
		elif Global.current_name_level == "Level_3":
			SceneSwitcher.switch_scene("res://scenes/main/level_4.tscn")
			
	pass # Replace with function body.
