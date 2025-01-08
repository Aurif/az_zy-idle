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
func get_item(key: String, uuid: String) -> Dictionary:
	return data[key][uuid]

func add_item(key: String, item: Dictionary) -> void:
	if not data.has(key):
		data[key] = {}
	data[key][uuid_v4()] = item
	trigger_update()

func remove_item(key: String, uuid: String) -> void:
	data[key].erase(uuid)
	trigger_update()

func connect_watcher(key: String, callback: Callable) -> void:
	if not update_signals.has(key):
		self.add_user_signal("key_"+key)
		update_signals[key] = Signal(self, "key_"+key)
	update_signals[key].connect(callback)
	callback.call_deferred(data.get(key, {}))

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
var update_signals = {}

func trigger_update() -> void:
	save_tasks()
	for key in update_signals:
		update_signals[key].emit(data.get(key, {}))

func save_tasks() -> void:
	var file = FileAccess.open(filepath, FileAccess.WRITE)
	file.store_var(data)
	file.close()
