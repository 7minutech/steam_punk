extends CharacterBody2D


const SPEED = 100
const JUMP_VELOCITY = -400.0
func _ready() -> void:
	Global.player = self
	var direction = Vector2.LEFT
	velocity = direction * SPEED
func _physics_process(delta: float) -> void:
	move_and_slide()
	
func player():
	pass
