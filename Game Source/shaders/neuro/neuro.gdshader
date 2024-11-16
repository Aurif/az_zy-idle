shader_type canvas_item;

uniform sampler2D light_color_gradient: hint_default_black;

uniform vec2 light_direction = vec2(-1.0, -1.0);
uniform float shadow_length = 0.001;
uniform float shadow_decay = 0.85;
uniform int shadow_steps = 16;

float elevation(sampler2D tex, vec2 uv) {
    vec4 elev = texture(tex, uv);
    float normalized_elevation = elev.r - 0.5;
    return normalized_elevation * elev.a;
}

void fragment() {
    vec2 light_dir = normalize(light_direction);
    float this_elevation = elevation(TEXTURE, UV);

    float total_diff = 0.0;
    float current_mult = 1.0;
    float normalization_factor = 0.0;
    for(int i=0; i < shadow_steps; i++) {
        float elevation_diff = (this_elevation-elevation(TEXTURE, UV+light_dir*float(i)*shadow_length));
        total_diff += elevation_diff * current_mult;

        normalization_factor += current_mult;
        current_mult -= 1.0/float(shadow_steps);
    }

    float normalized_diff = total_diff / normalization_factor + 0.5;
    COLOR = texture(light_color_gradient, vec2(normalized_diff, 0.0));
}