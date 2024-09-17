extends CharacterBody2D


var bullet_velocity := Vector2(150, 0)
const MAX_SPEED := 300
const BASE_SPEED := 150.0
@onready var sprite_1 = $Node2D


	

func _physics_process(delta):
	var collisionInfo = move_and_collide(bullet_velocity * delta)
	if collisionInfo:
		var other = collisionInfo.get_collider()
		bullet_velocity = bullet_velocity.bounce(collisionInfo.get_normal())
		bullet_velocity += collisionInfo.get_collider_velocity()
		move_and_collide(bullet_velocity * delta)
		if other.collision_layer == 1:
			if collision_layer == 4: #player_bullet
				set_as_enemy()
		elif check_hittable(other.collision_layer):
			other.queue_free()
			queue_free()
			pass
	else:
		var speed = bullet_velocity.distance_to(Vector2.ZERO)
		bullet_velocity = lerp(speed, BASE_SPEED, delta *  10)* bullet_velocity.normalized()



func set_as_enemy():
	set_collision_layer_value(2, true)
	set_collision_layer_value(3, false)
	#set_collision_mask_value(2, false)
	set_collision_mask_value(3, true)
	sprite_1.modulate = Color.RED
	
func set_as_from_enemy():
	set_collision_layer_value(2, true)
	set_collision_layer_value(3, false)
	set_collision_mask_value(2, false)
	set_collision_mask_value(3, true)
	add_to_group("enemy_bullet")
	sprite_1.modulate = Color.WEB_MAROON

	
func set_bullet_velocity(new_velocity: Vector2):
	bullet_velocity = new_velocity
	
func check_hittable(other_collision_layer):
	return (collision_layer == 4 and other_collision_layer == 2) or ( # player_bullet hitting enemy_bullet
			collision_layer == 2 and other_collision_layer == 4) # enemy_bullet hitting player_bullet

