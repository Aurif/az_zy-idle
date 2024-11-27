shader_type canvas_item;

uniform vec2 light_direction = vec2(-1.0, -1.0);

uniform sampler2D light_color_gradient: hint_default_black;
uniform float shadow_length = 1.0;
uniform int shadow_steps = 48;
uniform float decay_factor = 10.0;
uniform float glare_ratio = 0.5;

uniform sampler2D previous_texture: repeat_disable, filter_linear_mipmap;

float elevation(sampler2D tex, vec2 uv) {
    vec4 elev = texture(tex, uv);
    float normalized_elevation = elev.g - 0.5;
    return normalized_elevation * elev.a;
}

vec4 soft_light(vec4 base, vec4 blend) {
    blend = vec4(mix(vec3(0.5), blend.rgb, blend.a), 1.0);
    return (1.0-2.0*blend)*base*base+2.0*base*blend;
}

void fragment() {
    vec2 light_dir = vec2(normalize(light_direction).x*SCREEN_PIXEL_SIZE.x, normalize(light_direction).y*SCREEN_PIXEL_SIZE.y)*shadow_length;
    float this_elevation = elevation(TEXTURE, UV);

    float total_diff_shadow = 0.0;
    float total_diff_glare = 0.0;
    for(int i=0; i < shadow_steps*2; i++) {
        float fi = float(i)/2.0;
        float elevation_diff_shadow = clamp(elevation(TEXTURE, UV+light_dir*fi)-this_elevation, 0.0, 0.125)*8.0;
        float elevation_diff_glare = clamp(elevation(TEXTURE, UV-light_dir*fi)-this_elevation, 0.0, 0.125)*8.0;

        total_diff_shadow = max(total_diff_shadow, elevation_diff_shadow*exp(-fi / decay_factor));
        total_diff_glare = max(total_diff_glare, elevation_diff_glare*exp(-fi / decay_factor / glare_ratio));
    }

    float normalized_diff = (total_diff_glare - total_diff_shadow) / 2.0 + 0.5;
    vec4 target_color = texture(light_color_gradient, vec2(normalized_diff, 0.0));
    vec4 color_with_edges = soft_light(texture(previous_texture, UV), target_color);
    vec4 depth_color = texture(light_color_gradient, vec2(this_elevation+0.5, 0.0)) * vec4(1, 1, 1, abs(this_elevation)*0.5);
    COLOR = soft_light(color_with_edges, depth_color);
}