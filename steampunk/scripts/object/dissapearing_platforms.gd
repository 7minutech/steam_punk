extends AnimatableBody2D

@export var time_to_disappear: float = 0.6
@export var time_to_appear: float = 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("hero"):
		print("player entered area")
		$DisapperTimer.start()
		$AnimationPlayer.play("shake")
		


func _on_disapper_timer_timeout() -> void:
	$Sprite2D.hide()
	$CollisionShape2D.disabled = true
	$AppearTimer.start()
	pass # Replace with function body.


func _on_appear_timer_timeout() -> void:
	$Sprite2D.show()
	$CollisionShape2D.disabled = false
	$AnimationPlayer.stop()
	pass # Replace with function body.
