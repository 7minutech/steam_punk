extends StaticBody2D

var health: int = 50
var gun_scene = preload("res://player_gun.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hit(amount: int):
	health -= amount
	if health <= 0:
		remove()
		
func remove():
	if gun_scene:
		var gun = gun_scene.instantiate()
		gun.position = global_position
		get_parent().add_child(gun)
	queue_free()
