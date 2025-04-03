extends AnimatableBody2D

@export var time_to_disappear: float = 1.0
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


func _on_disapper_timer_timeout() -> void:
	$sprite2d.hide()
	$CollisionShape2D.disabled = true
	$AppearTimer.start()
	pass # Replace with function body.


func _on_appear_timer_timeout() -> void:
	$sprite2d.show()
	$CollisionShape2D.disabled = false
	pass # Replace with function body.
