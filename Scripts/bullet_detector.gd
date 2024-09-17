extends Area2D

@onready var sprite = $"../display/AnimatedSprite2D"
var health = 7
const POWER_LEVELS = ["empty", "one_sevenths",
		 "two_sevenths", "three_sevenths", "four_sevenths",
		 "five_sevenths", "six_sevenths", "full", "over-overflowing"]
signal game_over()

func _on_body_entered(body:PhysicsBody2D):
	if body.collision_layer == 2 and health >= 0: # enemy_bullet
		health -= 1
		sprite.play(POWER_LEVELS[health])

	if health < 0:

		game_over.emit()
