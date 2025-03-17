extends CharacterBody2D

var speed = 300
var jump_strength = -400
var gravity = 800

func _ready():
	pass

func _process(delta):
	velocity.x = 0

	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed

	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = jump_strength

	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()
