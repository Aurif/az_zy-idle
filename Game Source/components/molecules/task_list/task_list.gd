extends VBoxContainer

@export var task_prefab: PackedScene
@export var input_field: LineEdit

func _on_text_submitted(new_task: String) -> void:
	if new_task == "":
		return
	var instance = task_prefab.instantiate()
	$FlowContainer.add_child(instance)
	instance.get_node("Label").text = new_task
	input_field.text = ""
