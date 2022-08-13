extends Node


func _ready():
	pass


func _on_but_start_pressed():
	get_tree().change_scene("res://world.tscn")


func _on_but_quit_pressed():
	get_tree().quit()
