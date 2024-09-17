extends Node2D

var bullet = preload("res://Scenes/bullet.tscn")



func _input(event):
	if event.is_action_pressed("Fire"):
		var new_bullet = bullet.instantiate()
		add_child(new_bullet)
		new_bullet.reparent(find_parent("*").find_parent("*").find_parent("*"))
		new_bullet.set_bullet_velocity(get_local_mouse_position().normalized().rotated(get_global_transform().get_rotation()) * 150)
	if event.is_action_pressed("Shield"):
		var new_bullet = bullet.instantiate()
		add_child(new_bullet)
		new_bullet.set_bullet_velocity(Vector2.ZERO)
		new_bullet.scale = Vector2(3, 7)

