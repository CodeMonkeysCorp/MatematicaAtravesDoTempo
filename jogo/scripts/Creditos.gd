extends Area2D

func _ready():
	input_pickable = true  # garante que pode receber clique

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Cliquei no objeto!")
		minha_funcao()

func minha_funcao():
	Manager.goto("MainMenu")
