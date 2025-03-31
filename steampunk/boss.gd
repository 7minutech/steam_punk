extends CharacterBody2D

@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_timer: Timer = $JumpTimer

@export var damage: int = 20
@onready var label: Label = $Label

var projectile = preload("res://bullet_boss.tscn")
var gravity = ProjectSettings.get("physics/2d/default_gravity")

@export var speed: float = 75.0  
@export var jump_force: float = -450.0  
var direction: int = 1  

@onready var raycast_right: RayCast2D = $RayCast2DRight
@onready var raycast_left: RayCast2D = $RayCast2DLeft

var directions = [Vector2.LEFT]
var health: int = 200  

func take_damage(amount: int):
	health -= amount
	label.text = str(health)
	if health <= 0:
		die()

func die():

	queue_free()  
	 

func _ready():
	timer.start()  
	animated_sprite_2d.play("idle")  
	
	jump_timer.start()  
	direction = randi() % 2 * 2 - 1  

func _on_timer_timeout(): 
	animated_sprite_2d.play("shoot")  
	shoot()  # Call shoot function
	
	await get_tree().create_timer(0.3).timeout  
	animated_sprite_2d.play("idle")

func shoot():
	if direction > 0:  
		var instance = projectile.instantiate()
		instance.position = $ShootingPointRight.global_position
		get_parent().add_child(instance)  

		if instance.has_method("set_direction"):  
			instance.set_direction(Vector2(1,-1))
	elif direction < 0:
		var instance = projectile.instantiate()
		instance.position = $ShootingPointLeft.global_position
		get_parent().add_child(instance)  

		if instance.has_method("set_direction"):  
			instance.set_direction(Vector2(-1,-1))

func _physics_process(delta: float) -> void:
	if animated_sprite_2d.animation != "shoot":  
		animated_sprite_2d.play("move")
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if (direction > 0 and raycast_right.is_colliding()) or (direction < 0 and raycast_left.is_colliding()):
		direction *= -1 

	velocity.x = direction * speed  

	animated_sprite_2d.flip_h = direction < 0

	if not is_on_floor():
		animated_sprite_2d.play("jump")
	elif velocity.x != 0:
		animated_sprite_2d.play("move")
	else:
		animated_sprite_2d.play("idle")

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("hit"):
		body.hit(damage)


func _on_jump_timer_timeout() -> void:
	if is_on_floor():  
		velocity.y = jump_force  
		jump_timer.start(randf_range(1.0, 3.0)) 
		direction = randi() % 2 * 2 - 1  
