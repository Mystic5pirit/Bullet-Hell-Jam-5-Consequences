extends CharacterBody2D

const SECONDS_PER_ROTATION = 15

func _physics_process(delta):
	
	rotate(2 * PI * delta / (SECONDS_PER_ROTATION + 1))

	move_and_slide()
