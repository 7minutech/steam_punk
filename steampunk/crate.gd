extends StaticBody2D

var health: int = 50
var gun_scene = preload("res://player_gun.tscn")
var gun: String
var hit: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gun = GunObserver.pick_random_gun()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		remove()
		
func remove():
	if gun_scene:
		var gun = gun_scene.instantiate()
		gun.position = global_position
		get_parent().add_child(gun)
	queue_free()

func set_crate_texture(name: String):
	var crate: Sprite2D = $Sprite2D
	match name:
		"yellow_gun":
			crate.texture = load("res://assests/player/yellow_gun.png")
		"green_gun":
			crate.texture = load("res://assests/player/green_gun.png")
		"blue_rifle":
			crate.texture = load("res://assests/player/blue_rifle.png")
		"blue_gun":
			crate.texture = load("res://assests/player/blue_gun.png")
		"ant_shotgun":
			crate.texture = load("res://assests/player/ant_shotgun.png")
		"ant_gun":
			crate.texture = load("res://assests/player/ant_gun.png")
		_:
			crate.texture = load("res://assests/player/sGun.png")
	crate.scale = Vector2(0.8,0.8)
	pass


func _on_hitbox_body_entered(body: Node2D) -> void:
	var bullet: Bullet
	print(body)
	if body.has_method("bullet"):
			bullet = body
			set_crate_texture(gun)
			hit = true
	
	pass # Replace with function body.


func _on_pick_range_body_entered(body: Node2D) -> void:
	var player: Player
	if body.has_method("player") and hit:
		player = body
		player.swap_gun(gun)
		queue_free()
		pass
	pass # Replace with function body.


func _on_hitbox_area_entered(area: Area2D) -> void:
	var bullet: Bullet
	if area.has_method("bullet"):
			bullet = area
			set_crate_texture(gun)
			hit = true
	pass # Replace with function body.
