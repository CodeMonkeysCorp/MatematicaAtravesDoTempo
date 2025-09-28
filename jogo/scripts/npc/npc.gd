extends Node2D

@export var dialog_text: String = "texto texto texto texto texto texto texto texto texto"
@export var dialog_label: Label  # Arraste o Label no Inspector

func _ready():
	$Area2D.body_entered.connect(_on_area_body_entered)
	#dialog_label.visible = false  # Começa escondido

func _on_area_body_entered(body):
	if body.name == "player":
		print("penis")
		#start_dialog()

#func start_dialog():
	#dialog_label.text = dialog_text
	#dialog_label.visible = true
