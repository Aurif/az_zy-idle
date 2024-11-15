extends Control

@onready var viewport = $Viewport
@onready var camera = viewport.get_node(^"Camera")
@onready var view1 = $Shadows
@onready var view2 = $Glare

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_size_changed()

	get_viewport().size_changed.connect(_on_size_changed)

	view1.material.set_shader_parameter("viewport", viewport.get_texture())
	view2.material.set_shader_parameter("viewport", viewport.get_texture())


func _on_size_changed():
	var screen_size = get_viewport().get_visible_rect().size
	$Viewport.size = screen_size
