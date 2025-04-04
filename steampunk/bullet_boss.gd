extends CharacterBody2D

@export var speed: float = 300
var direction = Vector2.UP
@export var damage: int = 3
@export var gravity: float = 300 

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity.x = direction.x * speed
	
	move_and_slide()


func set_direction(new_direction: Vector2):
	direction = new_direction.normalized()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("hit"):
		body.hit(damage)
	queue_free()
	
