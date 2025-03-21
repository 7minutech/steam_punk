extends CharacterBody2D


var speed = 300
var jump_strength = -400
var gravity = 800
var max_jumps = 1  
var jumps = 0  
var has_double_jump = false  


func _process(delta):
	
	velocity.x = 0
	
	
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	
	
	if is_on_floor():
		jumps = 0  
	
	# Jumping logic
	if Input.is_action_just_pressed("jump"):
		if jumps < max_jumps:  
			velocity.y = jump_strength
			jumps += 1
	
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	move_and_slide()


func enable_double_jump():
	has_double_jump = true  
	max_jumps += 1  
