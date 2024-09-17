extends Node

signal finished_tutorial()
@onready var sub_tutorial_holder_1 = $"sub-tutorial_holder1"
@onready var sub_tutorial_holder_2 = $"sub-tutorial_holder2"


# Called when the node enters the scene tree for the first time.
func _ready():
	sub_tutorial_holder_2.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_up1():
	sub_tutorial_holder_1.queue_free()
	sub_tutorial_holder_2.visible = true


func _on_button_button_up():
	finished_tutorial.emit()
	queue_free()
