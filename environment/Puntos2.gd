extends Label

var puntosp2 :int = 0

func _ready():
	GLOBALS.connect("puntosp2",self,"_on_dibujar_puntoHecho")

func _on_dibujar_puntoHecho() :
	puntosp2 = text.to_int() + 1 
	self.text = String(puntosp2)
