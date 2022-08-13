extends KinematicBody2D

onready var play_anim : AnimatedSprite = get_node("spr_player1")

class_name Player1

const RIGHT : int = 1
const LEFT : int = 1
const JUMP : int = -1000
const GRAVITY : int = 75



var motion = Vector2()
export var speed : int = 5



func _physics_process(delta):
	_movimiento1()
func _movimiento1():
	if Input.is_action_pressed("mover_derecha_p1"):
		play_anim.animation = "derecha"
		play_anim.playing=true 
		position.x += speed
	else:
		if Input.is_action_pressed("mover_izquierda_p1"):
			play_anim.animation = "izquierda"
			play_anim.playing=true 
			position.x -= speed
		else:
			play_anim.playing=false
	if is_on_floor():
		if Input.is_action_just_pressed("saltar_p1"):
			play_anim.playing=false
			motion.y = JUMP 
	else:
		play_anim.playing=false
		motion.y += GRAVITY
	move_and_slide(motion, Vector2.UP)

func _ready():
	pass # Replace with function body.
