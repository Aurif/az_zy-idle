extends AtomData


func _ready() -> void:
	get_parent().connect("gui_input", _on_gui_input)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
		delete_item()

func delete_item() -> void:
	var parent = get_parent() as HookDataItem
	get_manager().remove_item(parent.item_key, parent.item_uuid)
