extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Physics2DServer.space_set_param(get_world_2d().space, Physics2DServer.SPACE_PARAM_BODY_MAX_ALLOWED_PENETRATION, 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


	

#estas son las señales que detectan los puntos realizados

func _on_area_aro1_punto_body_entered(body):
	if body.name == "ball":
		GLOBALS.emit_signal("puntosp2")#acá estoy emitiendo la señal a los demás nodos que realizo un punto el jugador


func _on_area_aro2_punto_body_entered(body):
	if body.name == "ball":
		GLOBALS.emit_signal("puntosp1")#acá estoy emitiendo la señal a los demás nodos que realizo un punto el jugador


func _on_Timer_timeout():
	if GLOBALS.tiempo>0:
		GLOBALS.tiempo -= 1
		update_time()
	if GLOBALS.tiempo == 0 && GLOBALS.termino == false:#si el tiempo llega a cero que envie la señal de que se termino el partido
		GLOBALS.emit_signal("finPartido")
		GLOBALS.termino = true
		get_tree().get_nodes_in_group("cronometro")[0].layer=-1

func update_time():
	get_tree().get_nodes_in_group("tiempo")[0].text = String(GLOBALS.tiempo/60)+ ":"+String(GLOBALS.tiempo%60)
