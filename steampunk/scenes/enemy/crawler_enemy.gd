extends Node2D

@onready var path_follow = $Path2D/PathFollow2D
@onready var sprite = $Path2D/PathFollow2D/CharacterBody2D/AnimatedSprite2D
@onready var speed = 1

func _ready() -> void:
	sprite.play("walk")
	pass
	
func _process(delta: float) -> void:
	if path_follow.progress_ratio > 0.5:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	path_follow.progress += speed
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		pass
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		pass
	pass # Replace with function body.
