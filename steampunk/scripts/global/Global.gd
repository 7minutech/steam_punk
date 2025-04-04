extends Node
var player 
var choosen_player: String
var current_name_level: String
var level_name: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	skip_level()
	pass

func switch_to_level(level_key: String):
	match level_key:
		"level_1":
			SceneSwitcher.switch_scene("res://scenes/main/level_1.tscn")
		"level_2":
			SceneSwitcher.switch_scene("res://scenes/main/level_2.tscn")
		"level_3":
			SceneSwitcher.switch_scene("res://scenes/main/level_3.tscn")
		"level_4":
			SceneSwitcher.switch_scene("res://scenes/main/level_4.tscn")
			
			
func skip_level():
	if Input.is_action_pressed("level_1"):
		Global.switch_to_level("level_1")
	if Input.is_action_pressed("level_2"):
		Global.switch_to_level("level_2")
	if Input.is_action_pressed("level_3"):
		Global.switch_to_level("level_3")
	if Input.is_action_pressed("level_4"):
		Global.switch_to_level("level_4")
