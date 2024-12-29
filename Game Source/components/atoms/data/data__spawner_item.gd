extends AtomData

@export var filters: Dictionary = {}

var spawned_nodes: Array[Node] = []
var prefab = PackedScene.new()

func _ready() -> void:
	prepare_prefab()
	self.visible = false
	get_manager().connect_watcher(_hook_data_changed)

func prepare_prefab() -> void:
	recurse_prefab(get_child(0))
	prefab.pack(get_child(0))
	get_child(0).queue_free()

func recurse_prefab(current: Node) -> void:
	for node in current.get_children():
		node.set_owner(get_child(0))
		recurse_prefab(node)

func _hook_data_changed(data: Dictionary) -> void:
	clear_items()
	for uuid in data:
		if !matches_filter(data[uuid]):
			continue
		add_item(uuid)

func clear_items() -> void:
	for item in spawned_nodes:
		item.queue_free()
	spawned_nodes.clear()

func matches_filter(item: Dictionary) -> bool:
	for key in filters:
		if filters[key] != item.get(key):
			return false
	return true

func add_item(uuid: String) -> void:
	var instance: HookDataItem = prefab.instantiate()
	spawned_nodes.append(instance)
	add_sibling(instance)
	instance.__init_item(uuid)
