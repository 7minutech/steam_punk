extends Node

var kill_count: int
var hud: Hud
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update_kill_count(count: int):
	kill_count = count
	if hud != null:
		hud.update_kill_count(kill_count)
		hud.update_kill(kill_count)

func reset_kill_count():
	kill_count = 0
