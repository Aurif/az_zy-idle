extends VSplitContainer

var ratio: float = 0.5;

func _on_resized() -> void:
	self.split_offset = ratio * self.size.y


func _on_dragged(offset: int) -> void:
	ratio = offset/self.size.y
