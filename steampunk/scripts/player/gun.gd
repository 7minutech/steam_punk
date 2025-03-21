extends Sprite2D

var can_fire: bool = true
var bullet = preload("res://scenes/player/Bullet.tscn")
@export var bullet_cd: float = 0.2
@onready var screen_shaker = $Camera2D/ScreenShaker

func _ready() -> void:
	top_level

func _physics_process(delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_instace = bullet.instantiate()
		bullet_instace.rotation = rotation + randf_range(-0.1,0.1)
		bullet_instace.position = $Muzzle.position
		bullet_instace.position.y += 19
		get_parent().get_node("Camera2D/ScreenShaker").shake(0.2,2)
		get_parent().add_child(bullet_instace)
		can_fire = false
		await get_tree().create_timer(bullet_cd).timeout
		can_fire = true
		pass
