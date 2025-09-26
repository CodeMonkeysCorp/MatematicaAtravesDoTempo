extends Control

@onready var dialogo        = $VBoxContainer/Dialogo
@onready var lbl_problema   = $VBoxContainer/Puzzle/LabelProblema
@onready var entrada_resposta = $VBoxContainer/Puzzle/HBoxContainer/EntradaResposta
@onready var btn_confirmar  = $VBoxContainer/Puzzle/HBoxContainer/BtnConfirmar
@onready var lbl_feedback   = $VBoxContainer/Puzzle/LabelFeedback
@onready var btn_avancar    = $VBoxContainer/Puzzle/BtnAvancar

var resposta_num: int = 0
var resposta_den: int = 1

func _ready() -> void:
	_gerar_problema()
	btn_confirmar.pressed.connect(_quando_confirmar)
	btn_avancar.pressed.connect(_quando_avancar)
	btn_avancar.disabled = true
	lbl_feedback.text = ""

# ---------- Gera o problema ----------
func _gerar_problema() -> void:
	# Exemplo fixo: 1/2 + 1/3
	var a_num = 1
	var a_den = 2
	var b_num = 1
	var b_den = 3

	lbl_problema.text = "%d/%d + %d/%d = ?" % [a_num, a_den, b_num, b_den]

	resposta_num = a_num * b_den + b_num * a_den
	resposta_den = a_den * b_den
	_simplificar()

# Simplifica a fração correta
func _simplificar() -> void:
	var mdc_val = mdc(resposta_num, resposta_den)
	resposta_num = resposta_num / mdc_val
	resposta_den = resposta_den / mdc_val

func mdc(a: int, b: int) -> int:
	a = abs(a); b = abs(b)
	while b != 0:
		var t = b
		b = a % b
		a = t
	return a

# ---------- Confirma resposta ----------
func _quando_confirmar() -> void:
	var entrada = entrada_resposta.text.strip()
	var frac = _ler_fracao(entrada)

	if frac == null:
		lbl_feedback.text = "⚠️ Formato inválido. Use a/b (ex: 5/6)."
		return

	var n = frac[0]
	var d = frac[1]

	if n * resposta_den == d * resposta_num:
		lbl_feedback.text = "✅ Correto! Você resolveu a fração."
		btn_avancar.disabled = false
	else:
		lbl_feedback.text = "❌ Incorreto. Simplifique sua fração e tente de novo."

# ---------- Avançar ----------
func _quando_avancar() -> void:
	GameManager.ir_para("Fases")

# ---------- Função auxiliar para ler frações ----------
func _ler_fracao(txt: String):
	if txt.find("/") != -1:
		var partes = txt.split("/")
		if partes.size() != 2:
			return null
		var n_txt = partes[0].strip()
		var d_txt = partes[1].strip()
		if not n_txt.is_valid_integer() or not d_txt.is_valid_integer():
			return null
		var n = int(n_txt)
		var d = int(d_txt)
		if d == 0:
			return null
		var g = mdc(n, d)
		return [n / g, d / g]
	return null
