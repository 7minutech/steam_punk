extends CharacterBody2D

var chasing_player = false
var speed = 150
var player = Global.player
var parent
var gear_bullet = preload("res://scenes/enemy/GearBullet.tscn")
var atk_cd = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = Global.player
	parent = get_parent()
	$AnimatedSprite2D.play("fly")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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

func flip():
	if Global.player.position.x < position.x:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func hover_over_player():
	if abs(player.position.x - position.x) < 5:
		return
	if player.position.x < position.x:
		var direction = Vector2.LEFT
		velocity = direction * speed
	else:
		var direction = Vector2.RIGHT
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
