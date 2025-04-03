extends Node

var available_guns: Array[String] = ["yellow_gun","green_gun","blue_rifle","blue_gun","ant_shotgun","ant_gun"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func pick_random_gun() -> String:
	var choosen_gun: String
	if available_guns.size() > 0:
		var index = randi() % available_guns.size()  
		choosen_gun = available_guns.pop_at(index) 
	return choosen_gun
	
	
