extends CharacterBody2D


const SPEED = 100.0
@onready var character = $display




func _physics_process(_delta):



	var horizontal_direction = Input.get_axis("Left", "Right")
	var vertical_direction = Input.get_axis("Up", "Down")
	var new_direction = Vector2(horizontal_direction, vertical_direction).normalized()
	var new_angle = new_direction.angle()
	if new_direction:
		velocity = new_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	if velocity:
		character.rotate(angle_difference(character.rotation, new_angle) + PI / 2)
	else:
		character.rotate(angle_difference(character.rotation, 0))

	move_and_slide()
