extends Node2D

signal player_fell_off
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.player_fell_off.connect(_on_player_fell_off)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_fell_off() -> void:
	var player: Player = get_tree().get_first_node_in_group("hero")
	player.position = $SpawnPoint.position
	pass # Replace with function body.
