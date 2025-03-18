extends StaticBody2D

var health: int = 50 
var heart_scene = preload("res://temporary_weapon.tscn") 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		remove()
		
func remove():
	if heart_scene:
		var coin = heart_scene.instantiate()  
		coin.position = global_position 
		get_parent().add_child(coin)  
	queue_free() 
