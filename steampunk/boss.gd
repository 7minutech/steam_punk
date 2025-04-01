extends CharacterBody2D

@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_timer: Timer = $JumpTimer

@export var damage: int = 20
@onready var label: Label = $Label

var projectile = preload("res://bullet_boss.tscn")
var gravity = ProjectSettings.get("physics/2d/default_gravity")

@export var speed: float = 75.0  
@export var jump_force: float = -500.0  
var direction: int = 1  

@onready var raycast_right: RayCast2D = $RayCast2DRight
@onready var raycast_left: RayCast2D = $RayCast2DLeft
@onready var ray_cast_2d_down_right: RayCast2D = $"RayCast2DDown-Right"
@onready var ray_cast_2d_down_left: RayCast2D = $"RayCast2DDown-Left"

@export var attack_range = 50  
@export var attack_damage = 10  
@export var attack_cooldown = 1.5  


@export var base_jump_force: float = -400.0  
@export var max_jump_force: float = -650.0 

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2
@onready var ray_cast_2d_3: RayCast2D = $RayCast2D3
@onready var ray_cast_2d_4: RayCast2D = $RayCast2D4

var player = null
var can_attack = true

var directions = [Vector2.LEFT]
var health: int = 200  

func hit(amount: int):
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
	shoot()  
	
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
	if animated_sprite_2d.animation != "attack":  
		animated_sprite_2d.play("move")
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if (direction > 0 and raycast_right.is_colliding()) or (direction < 0 and raycast_left.is_colliding()):
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
		
	if ((not ray_cast_2d_down_right.is_colliding()) or (not ray_cast_2d_down_left.is_colliding())) and (is_on_floor()):
		velocity.y = jump_force
		
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
		
func detect_next_platform():
	if ray_cast_2d.is_colliding():
		return ray_cast_2d.get_collision_point()
	elif ray_cast_2d_2.is_colliding():
		return ray_cast_2d_2.get_collision_point()
	elif ray_cast_2d_3.is_colliding():
		return ray_cast_2d_3.get_collision_point()
	elif ray_cast_2d_4.is_colliding():
		return ray_cast_2d_4.get_collision_point()
	return null

func jump_to(target_position):
	var distance_x = target_position.x - global_position.x
	var distance_y = target_position.y - global_position.y
	var jump_force = base_jump_force - (distance_y * 1.2)  

	velocity = Vector2(speed * direction, jump_force)
	
	if (not raycast_right.is_colliding()) and (is_on_floor()):
		velocity.y = jump_force 


func _on_jump_timer_timeout() -> void:
	if is_on_floor() and ray_cast_2d_down_left.is_colliding() and ray_cast_2d_down_right.is_colliding():  
		var collider = ray_cast_2d_down_right.get_collider()
		
		if collider and not collider.is_in_group("platforms"):  
			velocity.y = jump_force  
			jump_timer.start(randf_range(1.0, 3.0)) 
			direction = randi() % 2 * 2 - 1     
