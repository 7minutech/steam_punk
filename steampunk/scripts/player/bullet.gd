extends Area2D

@export var speed = 1500
@export var laser: bool = false
@export var water:bool = false
@onready var laser_bullet = $Sprite2D
@onready var water_bullet = $Sprite2D2
var sprite
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if laser:
		set_laser_bullet()
	elif water:
		set_water_bullet()
	else:
		set_laser_bullet()
	top_level
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#laser bullet straight in the direction the gun is pointed
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	pass

func _physics_process(delta: float) -> void:
	#flash 
	await get_tree().create_timer(0.01).timeout
	#actual bullet
	sprite.frame = 1
	set_physics_process(false)
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if not body.has_method("player"):
		queue_free()
	pass # Replace with function body.

func set_laser_bullet():
	sprite = laser_bullet
	water_bullet.hide()
func set_water_bullet():
	sprite = water_bullet
	laser_bullet.hide()
