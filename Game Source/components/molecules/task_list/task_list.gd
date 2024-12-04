extends VBoxContainer

@export var task_prefab: PackedScene
@export var input_field: LineEdit

var tasks: Array[String] = []
const SAVE_FILE_PATH: String = "res://tasks.idle"

func _ready() -> void:
	load_tasks()
	render()

func _on_text_submitted(new_task: String) -> void:
	if new_task == "":
		return
	input_field.text = ""
	tasks.append(new_task)
	save_tasks()
	render()

func render() -> void:
	for child in $FlowContainer.get_children():
		child.queue_free()
	for i in tasks.size():
		var task = tasks[i]
		var instance = task_prefab.instantiate()
		$FlowContainer.add_child(instance)
		instance.get_node("Label").text = task
		instance.connect("gui_input", self._on_task_remove.bind(i))

# Callback function to remove a task
func _on_task_remove(event: InputEvent, task_index: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
		tasks.remove_at(task_index)
		save_tasks()
		render()
	
func save_tasks() -> void:
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(tasks)
	file.close()

func load_tasks() -> void:
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if file != null:
		tasks = file.get_var()
		file.close()
