extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer
signal on_transition_finished

func _ready() -> void:
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)

func transition():
	color_rect.visible = true
	animation_player.play("fade_out")

func _on_animation_finished(anim_name):
	if anim_name == "fade_in":
		animation_player.play("fade_out")  # Start fading out after fade in completes
	elif anim_name == "fade_out":
		on_transition_finished.emit()
		color_rect.visible = false  # Hide the ColorRect after fade out finishes
