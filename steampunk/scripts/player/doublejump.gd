extends Area2D

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D:
		body.enable_double_jump()
		queue_free()  # Remove the power-up after collection
