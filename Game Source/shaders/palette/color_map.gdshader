shader_type canvas_item;
render_mode unshaded;

uniform sampler2D gradient: hint_default_black;
const float precision = 1.0/255.0;

float random(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453123) * 2.0 - 1.0;
}

void fragment() {
	vec4 input_color = texture(TEXTURE, UV);
	float greyscale_value = dot(input_color.rgb, vec3(0.299, 0.587, 0.114));
	float dithered_value = greyscale_value + random(UV)*precision;
	vec3 sampled_color = texture(gradient, vec2(dithered_value, 0.0)).rgb;

	COLOR.rgb = sampled_color;
	COLOR.a = input_color.a;
}
