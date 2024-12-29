extends Node
class_name DataManager

var data = {}
const filepath = "res://data.azzy"

static func uuid_v4():
	const BYTE_MASK: int = 0b11111111
	# 16 random bytes with the bytes on index 6 and 8 modified
	var b = [
	randi() & BYTE_MASK, randi() & BYTE_MASK, randi() & BYTE_MASK, randi() & BYTE_MASK,
	randi() & BYTE_MASK, randi() & BYTE_MASK, ((randi() & BYTE_MASK) & 0x0f) | 0x40, randi() & BYTE_MASK,
	((randi() & BYTE_MASK) & 0x3f) | 0x80, randi() & BYTE_MASK, randi() & BYTE_MASK, randi() & BYTE_MASK,
	randi() & BYTE_MASK, randi() & BYTE_MASK, randi() & BYTE_MASK, randi() & BYTE_MASK,
  ]

	return '%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x' % [
	# low
	b[0], b[1], b[2], b[3],

	# mid
	b[4], b[5],

	# hi
	b[6], b[7],

	# clock
	b[8], b[9],

	# clock
	b[10], b[11], b[12], b[13], b[14], b[15]
	]

#
# Operators
#
func get_item(uuid: String) -> Dictionary:
	return data[uuid]

func add_item(item: Dictionary) -> void:
	data[uuid_v4()] = item
	trigger_update()

func remove_item(uuid: String) -> void:
	data.erase(uuid)
	trigger_update()

func connect_watcher(callback: Callable) -> void:
	data_changed.connect(callback)
	callback.call_deferred(data)

# 
# Loading state
# 
func _ready():
	load_tasks()

func load_tasks() -> void:
	var file = FileAccess.open(filepath, FileAccess.READ)
	if file != null:
		data = file.get_var()
		file.close()

#
# Data updates
#	
signal data_changed(data)

func trigger_update() -> void:
	save_tasks()
	data_changed.emit(data)

func save_tasks() -> void:
	var file = FileAccess.open(filepath, FileAccess.WRITE)
	file.store_var(data)
	file.close()