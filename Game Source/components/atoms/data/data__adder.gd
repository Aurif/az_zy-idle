extends AtomData

@export var tags: Dictionary = {}

func _ready() -> void:
	if get_parent().get_class() == "LineEdit":
		get_parent().connect("text_submitted", _hook_line_edit)

func _hook_line_edit(content: String) -> void:
	if content == "":
		return
	var item = { "content": content }
	item.merge(tags)
	get_manager().add_item(item)
	get_parent().text = ""
