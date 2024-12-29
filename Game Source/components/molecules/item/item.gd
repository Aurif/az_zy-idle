extends HookDataItem

func _init_item(item: Dictionary) -> void:
	self.text = item["content"]
