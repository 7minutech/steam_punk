extends Node

var parent_sprite 
@export var pivot_below = false

var x_max = 1.5
var r_max = 10
const STOP_THRESHOLD = 0.1
const TWEEN_DURATION = 0.05
const RECOVERY_FACTOR = 2.0/3
const TRANSITION_TYPE = Tween.TRANS_SINE
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var parent = get_parent()
	if parent.has_node("Sprite"):
		parent_sprite = parent.get_node("Sprite")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
fuc


func _process(delta: float) -> void:
	pass
