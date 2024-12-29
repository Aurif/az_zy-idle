@tool
extends Node

@export var top_left_color: int = 64
@export var bottom_right_color: int = 32

func _ready():
	update_gradient()

func _set(property: StringName, value):
	if property == "top_left_color":
		top_left_color = value
		update_gradient()
		return true
	elif property == "bottom_right_color":
		bottom_right_color = value
		update_gradient()
		return true

	return false

func update_gradient():
	update_vertical_gradient()
	update_horizontal_gradient()

func update_vertical_gradient():
	var gradient = Gradient.new()
	gradient.set_color(0, Color(float(top_left_color)/256.0, float(top_left_color)/256.0, float(top_left_color)/256.0))
	gradient.set_color(1, Color(float(bottom_right_color)/256.0, float(bottom_right_color)/256.0, float(bottom_right_color)/256.0))

	var gradient_texture = GradientTexture2D.new()
	gradient_texture.set_use_hdr(true)
	gradient_texture.set_fill_to(Vector2(0.0, 1.0))
	gradient_texture.gradient = gradient

	$VerticalGradient.texture = gradient_texture
	
func update_horizontal_gradient():
	var gradient = Gradient.new()
	gradient.set_color(0, Color(float(bottom_right_color)/256.0, float(bottom_right_color)/256.0, float(bottom_right_color)/256.0, 0))
	gradient.set_color(1, Color(float(bottom_right_color)/256.0, float(bottom_right_color)/256.0, float(bottom_right_color)/256.0, 0.684))

	var gradient_texture = GradientTexture2D.new()
	gradient_texture.set_use_hdr(true)
	gradient_texture.set_fill_to(Vector2(1.0, 0.349))
	gradient_texture.gradient = gradient

	$HorizontalGradient.texture = gradient_texture
