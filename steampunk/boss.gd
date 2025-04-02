extends CharacterBody2D

@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_timer: Timer = $JumpTimer

@export var damage: int = 20
@onready var label: Label = $Label

var projectile = preload("res://bullet_boss.tscn")
var gravity = ProjectSettings.get("physics/2d/default_gravity")

@export var speed: float = 40.0  
@export var jump_force: float = -400.0  
var direction: int = 1  


@onready var ray_cast_2d_down_right: RayCast2D = $"RayCast2DDown-Right"
@onready var ray_cast_2d_down_left: RayCast2D = $"RayCast2DDown-Left"

@export var attack_range = 50  
@export var attack_damage = 10  
@export var attack_cooldown = 1.5  


@onready var teleport_timer: Timer = $TeleportTimer
@onready var area_2d: Area2D = $Area2D


var player = null
var can_attack = true

var directions = [Vector2.LEFT]
var health: int = 200  

var teleport_points = [
	Vector2(752, 270),
	Vector2(672, 260),
	Vector2(576, 236),
	Vector2(496, 260)
]
#this needs to be changed to the coordinates of the points from the platforms where the boss will teleport

func hit(amount: int):
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()  

func _ready():
	timer.start()  
	animated_sprite_2d.play("idle")  
	
	jump_timer.start()  
	direction = randi() % 2 * 2 - 1  
	
	teleport_timer.start()

func _on_timer_timeout(): 
	animated_sprite_2d.play("shoot")  
	shoot()  
	
	await get_tree().create_timer(0.3).timeout  
	animated_sprite_2d.play("idle")

func shoot():
	if direction > 0: 
		spawn_projectile($ShootingPointRight.global_position, Vector2(1, -5))  
		spawn_projectile($ShootingPointRight.global_position, Vector2(1, -3)) 
		spawn_projectile($ShootingPointRight.global_position, Vector2(1, -1))  

	elif direction < 0:  
		spawn_projectile($ShootingPointLeft.global_position, Vector2(-1, -5))  
		spawn_projectile($ShootingPointLeft.global_position, Vector2(-1, -4))  
		spawn_projectile($ShootingPointLeft.global_position, Vector2(-1, -3))
		#more projectile can be added here
		#the direction and speed of projectiles can be changed in bullet_boss scene 
		
func spawn_projectile(position: Vector2, direction: Vector2):
	var instance = projectile.instantiate()
	instance.position = position
	get_parent().add_child(instance)  

	if instance.has_method("set_direction"):  
		instance.set_direction(direction) 

func _physics_process(delta: float) -> void:
	if animated_sprite_2d.animation != "attack":  
		animated_sprite_2d.play("move")
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if (direction > 0 and (not ray_cast_2d_down_right.is_colliding())) or (direction < 0 and (not ray_cast_2d_down_left.is_colliding())):
		direction *= -1 

	velocity.x = direction * speed  

	animated_sprite_2d.flip_h = direction < 0

	if animated_sprite_2d.animation != "attack": 
		if not is_on_floor():
			animated_sprite_2d.play("jump")
		elif velocity.x != 0:
			animated_sprite_2d.play("move")
		else:
			animated_sprite_2d.play("idle")
		
	if player:
		var distance = global_position.distance_to(player.global_position)
		if distance <= attack_range:
			attack_player()

	move_and_slide()
	
func attack_player():
	if can_attack:
		can_attack = false
		print("Enemy attacks the player!")
		player.hit(damage)
		animated_sprite_2d.play("attack")
		await get_tree().create_timer(1.5).timeout
		$AttackCooldownTimer.start(attack_cooldown)
		
func _on_attack_cooldown_timer_timeout() -> void:
	can_attack = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("hero"):
		player = body
		
func _on_jump_timer_timeout() -> void:
		velocity.y = jump_force  
		jump_timer.start(randf_range(1.0, 3.0)) 
		direction = randi() % 2 * 2 - 1     

func _on_teleport_timer_timeout() -> void:
	teleport_randomly()
	
func teleport_randomly():
	var random_index = randi() % teleport_points.size()  # Pick a random index
	position = teleport_points[random_index]  # Teleport to the chosen position
