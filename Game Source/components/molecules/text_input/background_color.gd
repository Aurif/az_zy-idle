extends NinePatchRect

var is_hovered: bool = false
var is_focused: bool = false

func _on_mouse_entered() -> void:
	is_hovered = true
	update_alpha()

func _on_mouse_exited() -> void:
	is_hovered = false
	update_alpha()

func update_alpha() -> void:
	var modulation = self_modulate
	if is_focused:
		modulation.a = 0.13
	elif is_hovered:
		modulation.a = 0.07
	else:
		modulation.a = 0
	self_modulate = modulation


func _on_focus_entered() -> void:
	is_focused = true
	update_alpha()

func _on_focus_exited() -> void:
	is_focused = false
	update_alpha()
