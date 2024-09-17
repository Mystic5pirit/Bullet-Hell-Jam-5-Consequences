extends Node2D

var bullet = preload("res://Scenes/bullet.tscn")
@onready var sprite = $"../AnimatedSprite2D2"
@export var cooldown = 1
signal fired()


@onready var time_since_last_fire: float = (-1 * cooldown)
var charging = false
func _process(delta):
	if time_since_last_fire >= 0 and not charging:
		sprite.play("charge")
		time_since_last_fire += delta
		charging = true
	elif time_since_last_fire < 2: # Time to complete charge/animation
		time_since_last_fire += delta
	else:
		fire()
		time_since_last_fire = -1 * cooldown
		charging = false
		sprite.play("default")


func fire():
	var new_bullet = bullet.instantiate()
	add_child(new_bullet)
	new_bullet.reparent(find_parent("*").find_parent("*").find_parent("*"))
	new_bullet.set_as_from_enemy()
	var player = get_tree().get_first_node_in_group("player")
	new_bullet.set_bullet_velocity((player.get_global_transform().get_origin() - get_global_transform().get_origin()).normalized() * 150)
	fired.emit()
