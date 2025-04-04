extends Area2D

@export var speed = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	position += (Vector2.DOWN*speed) * delta
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


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		body.hit(25)
	pass # Replace with function body.
