extends Area2D
var top_parent 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_parent = get_parent().get_parent().get_parent().get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enemy():
	pass

func hit():
	top_parent.hit()
