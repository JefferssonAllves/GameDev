extends Control

@onready var resume_button: Button = %Continue
@onready var hint: Label = %Hint


func _ready() -> void:
	LocalCoop.configure(-1)
	var saved := Campaign.saved_milestone()
	resume_button.disabled = saved < 0
	if resume_button.disabled:
		%NewGame.grab_focus()
	else:
		resume_button.grab_focus()


func _resume() -> void:
	var saved := Campaign.saved_milestone()
	if saved < 0:
		resume_button.disabled = true
		hint.text = "Nenhum marco disponível."
		%NewGame.grab_focus()
		return
	if _configure_players():
		Campaign.begin(saved)


func _new_game() -> void:
	if Campaign.saved_milestone() >= 0:
		%Confirm.popup_centered()
	else:
		_start()


func _start() -> void:
	if not _configure_players():
		return
	Campaign.active = true
	if Campaign.record(Campaign.Milestone.START) != OK:
		hint.text = "Não foi possível gravar a campanha."
		return
	Campaign.begin(Campaign.Milestone.START)


func _configure_players() -> bool:
	if not %Coop.button_pressed:
		LocalCoop.configure(-1)
		return true
	var controllers := Input.get_connected_joypads()
	if controllers.is_empty():
		hint.text = "Conecte um controle para o jogador 2."
		return false
	LocalCoop.configure(controllers[0])
	return true


func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), Color("#211e30"))
	draw_circle(Vector2(size.x * 0.76, size.y * 0.32), 96, Color("#e7a561"), true, -1, true)
	draw_colored_polygon(PackedVector2Array([Vector2(0, size.y), Vector2(size.x * 0.42, size.y * 0.68), Vector2(size.x * 0.75, size.y * 0.53), Vector2(size.x, size.y * 0.64), size]), Color("#503646"))
