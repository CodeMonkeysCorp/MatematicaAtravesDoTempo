# res://scripts/MainMenu.gd
extends Control

@onready var btn_jogar   = $CenterContainer/MenuBox/BtnJogar
@onready var btn_fases   = $CenterContainer/MenuBox/BtnFases
@onready var btn_creditos= $CenterContainer/MenuBox/BtnCreditos
@onready var btn_sair    = $CenterContainer/MenuBox/BtnSair

func _ready() -> void:
	btn_jogar.connect("pressed", Callable(self, "_on_jogar_pressed"))
	btn_fases.connect("pressed", Callable(self, "_on_fases_pressed"))
	btn_creditos.connect("pressed", Callable(self, "_on_creditos_pressed"))
	btn_sair.connect("pressed", Callable(self, "_on_sair_pressed"))

func _on_jogar_pressed() -> void:
	GameManager.goto("FaseEgito")

func _on_fases_pressed() -> void:
	GameManager.goto("Fases")

func _on_creditos_pressed() -> void:
	GameManager.goto("Creditos")

func _on_sair_pressed() -> void:
	get_tree().quit()
