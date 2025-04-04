extends Node2D
var chasing_player = false
var speed = 150
var player = Global.player
var gear_bullet = preload("res://scenes/enemy/GearBullet.tscn")
var atk_cd = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enemy():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $FlyingEnemy.player_in_atk_range() and not atk_cd:
		drop_gear()
	pass

func drop_gear():
	var gear = gear_bullet.instantiate()
	gear.position = $FlyingEnemy.position
	add_child(gear)
	$ATKCD.start()
	atk_cd = true


func _on_atkcd_timeout() -> void:
	atk_cd = false
	pass # Replace with function body.
