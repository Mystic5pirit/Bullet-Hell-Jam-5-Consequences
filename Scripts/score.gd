extends Node2D

var score = 0
@export var bullet_score_value = 10
@onready var score_display = $Player/score
@onready var timer_display = $Player/timer
@onready var player = $Player
@onready var sub_tutorial_holder = $"Player/tutorial_holder/sub-tutorial_holder1"
@onready var label = $Player/Label
var time = 0

func _ready():
	pause()
	label.visible = false

func _process(delta):
	time += delta
	timer_display.text = "TIME: " + str(time).pad_decimals(2)
	



func _on_child_exiting_tree(node):
	if node.is_in_group("enemy_bullet"):
		score += bullet_score_value
	elif node.is_in_group("enemy"):
		score += node.score_value
	score_display.text = "SCORE: " + str(score)

func pause():
	player.visible = false
	get_tree().paused = true
	
func start():
	player.visible = true
	get_tree().paused = false


func _on_bullet_detector_game_over():
	pause()
	label.visible = true
	label.text = "GAME OVER \n SCORE: " + str(score)
	player.visible = true


func _on_tutorial_holder_finished_tutorial():
	start()
