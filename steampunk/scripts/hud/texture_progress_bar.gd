extends TextureProgressBar

class_name  HealthBar

func _ready() -> void:
	HealthObserver.health_bar = self
	update()

func update():
	value = HealthObserver.current_health * 100 / HealthObserver.max_health
	#$Label.text = str(HealthObserver.current_health) + " / " + str(HealthObserver.max_health)
