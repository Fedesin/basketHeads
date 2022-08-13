extends RigidBody2D



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var pelota : RigidBody2D = get_parent().get_node("ball")
onready var net_s : AudioStreamPlayer2D = get_node("net")

onready var buzzer_s : AudioStreamPlayer2D = get_node("buzzer")

const max_speed : int =600

var reset_state = false
var posicionInicialenX = 512
var posicionIncialenY = 320
var game_started = false
var pointsp1 = 0
var pointsp2 = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBALS.connect("puntosp1",self,"_on_aro2_puntoHecho")
	GLOBALS.connect("puntosp2",self,"_on_aro1_puntoHecho")
	GLOBALS.connect("finPartido",self,"_on_terminar_partido")

func _on_terminar_partido():
	buzzer_s.play()
	yield(buzzer_s,"finished")
	if pointsp1 == pointsp2 :
		print("Empataron")
		#tendria que pasar a pantalla de Replay
		queue_free()
		var replay_scn = load ("res://title/replay.tscn")
		get_parent().add_child(replay_scn.instance())
		get_tree().get_nodes_in_group("condicion")[0].text="Empataron"
		get_tree().paused = true
	elif pointsp1> pointsp2 :
		print("Gano Facu")
		#tendria que pasar a pantalla de Replay
		queue_free()
		var replay_scn = load ("res://title/replay.tscn")
		get_parent().add_child(replay_scn.instance())
		get_tree().get_nodes_in_group("condicion")[0].text="Gano Facu"
		get_tree().paused = true
	else:
		print("Gano Lapro")
		#tendria que pasar a pantalla de Replay
		queue_free()
		var replay_scn = load ("res://title/replay.tscn")
		get_parent().add_child(replay_scn.instance())
		get_tree().get_nodes_in_group("condicion")[0].text="Gano Lapro"
		get_tree().paused = true

func _on_aro2_puntoHecho():
	pointsp1 += 1
	print("FACU HIZO UN PUNTO")
	net_s.play()
	_reiniciarPelota()
	
func _on_aro1_puntoHecho():
	pointsp2 += 1
	print("LAPRO HIZO UN PUNTO")
	net_s.play()
	_reiniciarPelota()


func _on_VisibilityNotifier2D_screen_exited():
	#que se reinicie la posición de la pelota
	_reiniciarPelota()

func _reiniciarPelota():
	angular_velocity = 0
	linear_velocity.x = 0
	linear_velocity.y = 0
	pelota.reset_state = true #esta linea reinicia la posición de la pelota

func _integrate_forces(state): #necesito de este metodo para reiniciar la posición
	if abs(get_linear_velocity().x) > max_speed or abs(get_linear_velocity().y) > max_speed:
		var new_speed = get_linear_velocity().normalized()
		new_speed *= max_speed
		set_linear_velocity(new_speed)
	
	if reset_state:
		state.transform = Transform2D(0.0, Vector2(posicionInicialenX,posicionIncialenY))
		reset_state = false
