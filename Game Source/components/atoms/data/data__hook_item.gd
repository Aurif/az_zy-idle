extends AtomData
class_name HookDataItem

var item_uuid: String;

#
# Util methods
#
func get_item_data() -> Dictionary:
	return get_manager().get_item(item_uuid)

#
# Overridables
#
func _init_item(_item: Dictionary) -> void:
	pass

#
# Other 
#
func __init_item(uuid: String) -> void:
	item_uuid = uuid
	self._init_item(get_item_data())
	
