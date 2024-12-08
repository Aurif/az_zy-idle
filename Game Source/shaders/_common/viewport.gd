@tool
extends SubViewport

func _ready() -> void:
	self.world_2d = get_parent().get_world_2d()

	if Engine.is_editor_hint():
		self.size = get_tree().edited_scene_root.size

	if not Engine.is_editor_hint():
		_on_size_changed()
		get_parent().get_viewport().size_changed.connect(_on_size_changed)


func _on_size_changed():
	var screen_size = get_parent().get_viewport().get_visible_rect().size
	self.size = screen_size
