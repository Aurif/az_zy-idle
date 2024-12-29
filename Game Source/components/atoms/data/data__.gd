extends Node
class_name AtomData

func get_manager() -> DataManager:
	return (get_node("/root/Root/DataManager") as DataManager)
