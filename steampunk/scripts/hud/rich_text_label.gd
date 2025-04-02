extends RichTextLabel

@export var speed = 5
@export var fade = false
@export var wait_time = 1.0  # Duration to stay fully visible before fading out

var time = 0
var is_fading = true
var is_visible_phase = false
var visible_time = 0  # Tracks time during visible phase

func _ready() -> void:
	modulate.a = 0  # Start invisible

func _process(delta: float) -> void:
	if fade and is_fading:
		time += delta
		var alpha = sin(time * speed)  # Fade effect (0 → 1 → 0)

		# Ensure alpha stays in range [0,1]
		modulate.a = clamp(alpha, 0, 1)

		# Once fully visible, start the wait time
		if modulate.a >= 0.99 and not is_visible_phase:
			is_visible_phase = true  # Switch to waiting phase
			visible_time = 0  # Reset visible time counter

	elif is_visible_phase:
		visible_time += delta  # Track time while fully visible

		# If visible time exceeds wait_time, begin fading out
		if visible_time >= wait_time:
			is_visible_phase = false
			is_fading = false  # Stop updating
			modulate.a = 0  # Make invisible
