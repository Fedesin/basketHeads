extends Label

var puntosp1 :int = 0

func _ready():
	GLOBALS.connect("puntosp1",self,"_on_dibujar_puntoHecho")

func _on_dibujar_puntoHecho() :
	puntosp1 = text.to_int() + 1 
	self.text = String(puntosp1)
