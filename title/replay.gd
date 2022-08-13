extends Node


func _ready():
	pass


func _on_but_replay_pressed():
	get_tree().change_scene("res://world.tscn")
	get_tree().paused = false
	get_tree().get_nodes_in_group("cronometro")[0].layer=0
	GLOBALS.termino=false
	GLOBALS.tiempo=180


func _on_but_quit_pressed():
	get_tree().quit()
