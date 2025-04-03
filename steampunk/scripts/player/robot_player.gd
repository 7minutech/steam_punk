extends CharacterBody2D
class_name Player

@export var speed: float = 200.0
const JUMP_VELOCITY: float = -400.0 
@export var gravity: bool = true
@export var health: int = 100
var max_health: int = 100
@onready var sprite = $AnimatedSprite2D
var invincbility: bool = false
var running: bool = false
var idling: bool = false
var lives: int = 3
@onready var player_hud: Hud = $CanvasLayer/Hud
@export_enum("yellow_gun","green_gun","blue_rifle","blue_gun","ant_shotgun","ant_gun") var gun_sprite: String
@export_enum("yellow_gun","green_gun","blue_rifle","blue_gun","ant_shotgun","ant_gun") var gun_texture: String
@export_enum("double_jump","grappling_hook","wings") var ability_texture: String
func _ready() 	-> void:
	swap_gun_sprite(gun_sprite)
	print(player_hud)
	if player_hud != null:
		set_ability_ui(ability_texture)
		set_weapon_ui(gun_texture)
	
	Global.player = self
	HealthObserver.player = self
	HealthObserver.update_current_health(health)
	KillObserver.update_life_count(lives)

func _physics_process(delta: float) -> void:
	if health <= 0:
		lives -= 1
		KillObserver.update_life_count(lives)
	# Add the gravity.\
	if lives <= 0:
		$AnimatedSprite2D.hide()
		SceneSwitcher.switch_scene("res://scenes/hud/start_screen.tscn")
	
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
	HealthObserver.update_current_health(health)
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
	


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	lives -= 1
	KillObserver.update_life_count(lives)
	SignalBus.player_fell_off.emit()
	pass # Replace with function body.

func swap_gun_sprite(name: String):
	match name:
		"yellow_gun":
			$Gun.texture = load("res://assests/player/yellow_gun.png")
		"green_gun":
			$Gun.texture = load("res://assests/player/green_gun.png")
		"blue_rifle":
			$Gun.texture = load("res://assests/player/blue_rifle.png")
		"blue_gun":
			$Gun.texture = load("res://assests/player/blue_gun.png")
		"ant_shotgun":
			$Gun.texture = load("res://assests/player/ant_shotgun.png")
		"ant_gun":
			$Gun.texture = load("res://assests/player/ant_gun.png")
		_:
			$Gun.texture = load("res://assests/player/sGun.png")
			
func set_ability_ui(ability: String):
	var ability_texture: TextureRect = player_hud.get_node("Ability_Texture")
	match ability:
		"double_jump":
			ability_texture.texture = load("res://assests/ability/double_jump.png")
			player_hud.ability_label.text = "Double Jump"
		"grappling_hook":
			ability_texture.texture = load("res://assests/ability/grappling_hook.png")
			player_hud.ability_label.text = "Grappling Hook"
		"wings":
			ability_texture.texture = load("res://assests/ability/wings.png")
			player_hud.ability_label.text = "Wings"
	pass
	
func set_weapon_ui(weapon: String):
	var weapon_texture: TextureRect = player_hud.get_node("Weapon_Texture")
	match weapon:
		"yellow_gun":
			weapon_texture.texture = load("res://assests/player/yellow_gun.png")
			player_hud.weapon_label.text = "King Harley"
		"green_gun":
			weapon_texture.texture = load("res://assests/player/green_gun.png")
			player_hud.weapon_label.text = "Oakley"
		"blue_rifle":
			weapon_texture.texture = load("res://assests/player/blue_rifle.png")
			player_hud.weapon_label.text = "Oz"
		"blue_gun":
			weapon_texture.texture = load("res://assests/player/blue_gun.png")
			player_hud.weapon_label.text = "Neptune"
		"ant_shotgun":
			weapon_texture.texture = load("res://assests/player/ant_shotgun.png")
			player_hud.weapon_label.text = "Big Lenny"
		"ant_gun":
			weapon_texture.texture = load("res://assests/player/ant_gun.png")
			player_hud.weapon_label.text = "Ant Storm"
		_:
			weapon_texture.texture = load("res://assests/player/sGun.png")
			player_hud.weapon_label.text = "Bronco"
	pass
