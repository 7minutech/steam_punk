extends Node

var current_health: int = 100
var max_health: int = 100
var player: Player
var health_bar: HealthBar


func update_current_health(health: int):
	current_health = health
	if health_bar != null:
		health_bar.update()
		
	
