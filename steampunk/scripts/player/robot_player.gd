extends CharacterBody2D


@export var speed: float = 200.0
const JUMP_VELOCITY: float = -400.0 
@export var gravity: bool = true
func _ready() 	-> void:
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if gravity:
			velocity += get_gravity() * delta
		pass

	# Handle jump.G
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction < 0:
		$AnimatedSprite2D.flip_h = true
		$Gun.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
		$Gun.flip_h = false
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
func player() -> void:
	return
