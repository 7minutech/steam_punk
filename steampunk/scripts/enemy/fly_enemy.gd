extends CharacterBody2D

var chasing_player = false
@export var speed = 150
var player = Global.player
var parent
var gear_bullet = preload("res://scenes/enemy/GearBullet.tscn")
var atk_cd = false
@onready var sprite = $AnimatedSprite2D
@export var health = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = Global.player
	parent = get_parent()
	$AnimatedSprite2D.play("fly")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 0:
		queue_free()
	pass

func _physics_process(delta: float) -> void:
	if chasing_player:
		hover_over_player()
	flip()
	if player_in_atk_range():
		var gear_instace = gear_bullet.instantiate()
		self.add_child(gear_instace)
		gear_instace.position = $Drop.position
		
	
	

func flying_enemy():
	pass
	
func enemy():
	pass

func flip():
	if Global.player.position.x < position.x:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func hover_over_player():
	var height_distance = 85
	var max_height_distance = height_distance + 5
	var direction = Vector2(0,0)
	var x_distance = player.position.x - position.x
	if abs(x_distance) < 5:
		pass
	elif player.position.x < position.x:
		direction += Vector2.LEFT
	else:
		direction += Vector2.RIGHT
	if (player.position.y - position.y) < height_distance:
		direction += Vector2.UP
	elif (player.position.y - position.y) > max_height_distance:
		direction += Vector2.DOWN
	velocity = direction * speed
	move_and_slide()

func player_in_atk_range():
	if abs(Global.player.position.x - position.x) < 5 and not atk_cd:
		atk_cd = true
		$Atk_cd.start()
		return true
	return false


		
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	var distance = player.position.x - position.x
	print("Player x: " + str(player.position.x))
	print("Enmey x: " + str(position.x))
	print("Distanct to player: " + str(distance))
	if body.has_method("player"):
		player = body
		chasing_player = true
		print("chasing player now")
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		chasing_player = false
		print("not chasing player now")
	pass # Replace with function body.


func _on_atk_cd_timeout() -> void:
	atk_cd = false
	pass # Replace with function body.

func hurt_flicker():
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color.WHITE

func hit():
	print("hit")
	health -= 25
	hurt_flicker()
