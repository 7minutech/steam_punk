extends CharacterBody2D


@export var speed: float = 200.0
const JUMP_VELOCITY: float = -400.0 
@export var gravity: bool = true
@export var health: int = 100
@onready var sprite = $AnimatedSprite2D
var invincbility: bool = false
var running: bool = false
var idling: bool = false
func _ready() 	-> void:
	Global.player = self

func _physics_process(delta: float) -> void:
	if health <= 0:
		sprite.hide()
	# Add the gravity.
	if not is_on_floor():
		if gravity:
			velocity += get_gravity() * delta
		pass
	if invincbility:
		set_collision_layer_value(1,false)
	else:
		set_collision_layer_value(1,true)
	# Handle jump.G
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction < 0:
		$AnimatedSprite2D.flip_h = true
		$Gun.flip_h = true
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
		$Gun.flip_h = false
	if direction:
		running = true
		run()
		idling = false
		velocity.x = direction * speed
	else:
		idling = true
		idle()
		running = false
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
func player() -> void:
	return
	
func hurt_flicker():
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color.WHITE

func hit(damage:int):
	health -= damage
	hurt_flicker()

func i_frames():
	invincbility = true
	$InvincTimer.start()
	


func _on_invinc_timer_timeout() -> void:
	invincbility = false
	pass # Replace with function body.

func run() -> void:
	if running:
		if idling:
			$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("run")

func idle() -> void:
	if idling:
		if running:
			$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("idle")
	
