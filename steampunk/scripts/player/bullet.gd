extends Area2D

@export var speed = 1500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_level
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#fire bullet straight in the direction the gun is pointed
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	pass

func _physics_process(delta: float) -> void:
	#flash 
	await get_tree().create_timer(0.01).timeout
	#actual bullet
	$Sprite2D.frame = 1
	set_physics_process(false)
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if not body.has_method("player"):
		queue_free()
	pass # Replace with function body.


func bullet():
	pass


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		print("hit")
		body.hit()
	pass # Replace with function body.


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.has_method("enemy"):
		area.hit()
	pass # Replace with function body.
