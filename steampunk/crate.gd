extends StaticBody2D


var health: int = 50  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func take_damage(amount: int):
	health -= amount
	if health <= 0:
		die()
		
func die():
	queue_free() 
