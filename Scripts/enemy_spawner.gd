extends Node2D

@export var average_spawn_distance = 300
@export var max_spawn_distance_variation = 50
@export var average_spawn_cooldown = 15
@export var max_spawn_cooldown_variation = 5
@onready var timer = average_spawn_cooldown


var enemy_list = [preload("res://Scenes/enemy_v2b.tscn"), preload("res://Scenes/enemy_v2p.tscn"), preload("res://Scenes/enemy_v2e.tscn")]
var enemy_probability_list = [0.5, 0.3, 0.2]
var enemy_threshold_list = [0.0, 0.5, 0.8]

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = 3
	adjust_enemy_threshold()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta
	if timer < 0:
		spawn_enemy()
		timer = average_spawn_cooldown + (max_spawn_cooldown_variation * (randf() - 0.5) * 2)

func spawn_enemy():
	var angle = randf() * 2 * PI
	position = Vector2.from_angle(angle) * (average_spawn_distance + max_spawn_distance_variation * (randf() - 0.5) * 2)
	var enemy_number := randf()
	var new_enemy

	for i in enemy_threshold_list.size():
		var index = enemy_threshold_list.size() - i - 1
		if enemy_number >= enemy_threshold_list[index]:
			new_enemy = enemy_list[index]
			new_enemy = new_enemy.instantiate()


			break
	add_child(new_enemy)
	new_enemy.reparent(find_parent("*").find_parent("*"))

	position = Vector2.ZERO
	
func adjust_enemy_threshold():
	var current_threshold = 0.0
	for i in enemy_probability_list.size() - 1:
		enemy_threshold_list[i] = current_threshold
		current_threshold += enemy_probability_list[i]
		
