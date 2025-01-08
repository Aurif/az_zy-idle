extends AtomData
class_name HookDataItem

var item_key: String;
var item_uuid: String;

#
# Util methods
#
func get_item_data() -> Dictionary:
	return get_manager().get_item(item_key, item_uuid)

#
# Overridables
#
func _init_item(_item: Dictionary) -> void:
	pass

#
# Other 
#
func __init_item(key: String, uuid: String) -> void:
	item_key = key
	item_uuid = uuid
	self._init_item(get_item_data())
	
