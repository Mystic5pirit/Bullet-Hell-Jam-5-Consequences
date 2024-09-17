extends CharacterBody2D


@onready var player = get_tree().get_first_node_in_group("player")
@export var vulnerable_to_enemy_bullets = false
@export var vulnerable_to_player_bullets = true
@export var speed = 0.5
@export var score_value = 100
const TARGET_DISTANCE = 200
signal enemy_died()

var time_since_fired = 0
func _physics_process(delta):
	look_at(player.get_global_transform().get_origin())
	rotate(PI / 2)
	var direction_to_player: Vector2 = (player.get_global_transform().get_origin() - get_global_transform().get_origin())
	var target_location = direction_to_player - (direction_to_player.normalized() * TARGET_DISTANCE)
	var collisionInfo = move_and_collide(target_location * delta * speed)
	if collisionInfo:
		var other = collisionInfo.get_collider()
		if check_hittable(other.collision_layer) and time_since_fired > 1:
			enemy_died.emit()
			other.queue_free()
			queue_free()
			
	time_since_fired += delta


func check_hittable(other_collider_layer):
	if vulnerable_to_enemy_bullets and other_collider_layer == 2:
		return true
	if vulnerable_to_player_bullets and other_collider_layer == 4:
		return true
	return false
	


func _on_bullet_shooter_fired():
	time_since_fired = 0
