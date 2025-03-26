extends Node2D

@onready var path_follow = $Path2D/PathFollow2D
@onready var sprite = $Path2D/PathFollow2D/CharacterBody2D/AnimatedSprite2D
@export var speed: int = 1
@export var health: int = 100
func _ready() -> void:
	sprite.play("walk")
	pass
	
func _process(delta: float) -> void:
	if health <= 0:
		queue_free()
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

func enemy():
	pass
func hurt_flicker():
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color.WHITE

func hit():
	print("hit")
	health -= 25
	hurt_flicker()
