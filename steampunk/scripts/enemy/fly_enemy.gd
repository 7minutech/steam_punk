extends Node2D

var chasing_player = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CharacterBody2D/AnimatedSprite2D.play("fly")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		
		
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		chasing_player = true
		return
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		chasing_player = false
		return
	pass # Replace with function body.

func flying_enemy():
	pass
