extends Control
class_name Hud
@export var kill_label: Label
@export var kill_count_label: Label
@export var life_count_label: Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	KillObserver.hud = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update_life_count(count: int):
	life_count_label.text = "x " + str(count)

func update_kill_count(count: int):
	kill_count_label.text = "x " + str(count)

func update_kill(count: int):
	if count < 2:
		kill_label.text = "Your first kill… about time."
	elif count < 4:
		kill_label.text = "Get to killing already!"
	elif count < 9:
		kill_label.text = "Finally warmed up, slowpoke."
	elif count < 19:
		kill_label.text = "Not bad… for an amateur."
	elif count < 49:
		kill_label.text = "Decent. Don’t get cocky!"
	pass
