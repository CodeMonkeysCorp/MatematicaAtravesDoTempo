extends Control

@onready var btn_jogar    = $CenterContainer/MenuBox/BtnJogar
@onready var btn_opcoes    = $CenterContainer/MenuBox/BtnOpcoes
@onready var btn_creditos = $CenterContainer/MenuBox/BtnCreditos
@onready var btn_sair     = $CenterContainer/MenuBox/BtnSair

func _ready() -> void:
	# Conectando os botões às funções
	btn_jogar.pressed.connect(_quando_jogar)
	btn_opcoes.pressed.connect(_quando_opcoes)
	btn_creditos.pressed.connect(_quando_creditos)
	btn_sair.pressed.connect(_quando_sair)

func _quando_jogar() -> void:
	Manager.ir_para("fase_egito")

func _quando_opcoes() -> void:
	Manager.ir_para("opcoes")

func _quando_creditos() -> void:
	Manager.ir_para("Creditos")

func _quando_sair() -> void:
	get_tree().quit()
