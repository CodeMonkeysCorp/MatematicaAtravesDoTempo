# res://scripts/FaseEgito.gd
extends Control

@onready var dialogue    = $VBoxContainer/Dialogue
@onready var lbl_problem = $VBoxContainer/Puzzle/LabelProblem
@onready var line_ans    = $VBoxContainer/Puzzle/HBoxContainer/LineEditAnswer
@onready var btn_check   = $VBoxContainer/Puzzle/HBoxContainer/BtnConfirm
@onready var lbl_feedback= $VBoxContainer/Puzzle/LabelFeedback
@onready var btn_advance = $VBoxContainer/Puzzle/BtnAdvance

var correct_numer: int = 0
var correct_denom: int = 1

func _ready() -> void:
	_generate_puzzle()
	btn_check.connect("pressed", Callable(self, "_on_check_pressed"))
	btn_advance.connect("pressed", Callable(self, "_on_advance_pressed"))
	btn_advance.disabled = true
	lbl_feedback.text = ""

# ---------- puzzle básico: soma de duas frações ----------
func _generate_puzzle() -> void:
	# Protótipo: frações fixas (1/2 + 1/3). Para randomizar, troque por randi()
	var a_num := 1
	var a_den := 2
	var b_num := 1
	var b_den := 3

	lbl_problem.text = "%d/%d + %d/%d =" % [a_num, a_den, b_num, b_den]

	correct_numer = a_num * b_den + b_num * a_den
	correct_denom = a_den * b_den
	_simplify_correct()

func _simplify_correct() -> void:
	var g := gcd(correct_numer, correct_denom)
	correct_numer = int(correct_numer / g)
	correct_denom = int(correct_denom / g)

func gcd(a, b) -> int:
	a = int(abs(a)); b = int(abs(b))
	while b != 0:
		var t = b
		b = a % b
		a = t
	return a

# recebe input do usuário, espera formato "a/b"
func _on_check_pressed() -> void:
	var input_text := line_ans.text.strip()
	var parsed := _parse_fraction(input_text)
	if parsed == null:
		lbl_feedback.text = "Formato inválido. Use a/b (ex: 5/6)."
		return
	var n := parsed[0]
	var d := parsed[1]
	if n * correct_denom == d * correct_numer:
		lbl_feedback.text = "Correto! 🎉 Você resolveu a fração."
		btn_advance.disabled = false
	else:
		lbl_feedback.text = "Incorreto. Dica: simplifique sua fração e tente novamente."

func _parse_fraction(s: String):
	if s.find("/") != -1:
		var parts := s.split("/")
		if parts.size() != 2:
			return null
		# tenta converter
		var ok_n := true
		var ok_d := true
		var n := 0
		var d := 1
		# handle spaces
		var a := parts[0].strip()
		var b := parts[1].strip()
		# conversão segura
		if a == "" or b == "":
			return null
		# try parse ints
		n = int(a) if a.is_valid_integer() else null
		d = int(b) if b.is_valid_integer() else null
		if n == null or d == null:
			return null
		if d == 0:
			return null
		var g := gcd(n, d)
		n = int(n / g); d = int(d / g)
		return [n, d]
	elif s.find(".") != -1:
		# aceita decimal aproximado (ex: 0.8333) -> converte pra frac com denom 1000
		var val := float(s)
		var denom := 1000
		var num := int(round(val * denom))
		var g := gcd(num, denom)
		num = int(num / g)
		denom = int(denom / g)
		return [num, denom]
	else:
		return null

func _on_advance_pressed() -> void:
	# por enquanto volta para "Fases" (stub) — altere para próxima fase quando houver
	GameManager.goto("Fases")
