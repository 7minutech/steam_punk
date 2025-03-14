extends Area2D

var speed = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var direction = Vector2.DOWN
	position += (direction * speed)
	pass
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		print("Hit player")
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.
