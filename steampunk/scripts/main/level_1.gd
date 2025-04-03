extends Node2D

signal player_fell_off
var player_scene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.name == "Level_1":
		Global.level_name = "The Obsidian Foundry"
	elif self.name == "Level_2":
		Global.level_name = "The Emerald Boilerworks"
	elif self.name == "Level_3":
		Global.self.name == "The Crimson Crucible"
	set_player_choosen()
	SignalBus.player_fell_off.connect(_on_player_fell_off)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_player_choosen():
	if Global.choosen_player == "human":
		player_scene = preload("res://scenes/player/HumPlayer.tscn")
		var player_instance = player_scene.instantiate()
		add_child(player_instance)
		player_instance.position = $SpawnPoint.position
	else:
		player_scene = preload("res://scenes/player/RobPlayer.tscn")
		var player_instance = player_scene.instantiate()
		add_child(player_instance)
		player_instance.position = $SpawnPoint.position

	
	

func _on_player_fell_off() -> void:
	var player: Player = get_tree().get_first_node_in_group("hero")
	player.position = $SpawnPoint.position
	pass # Replace with function body.
