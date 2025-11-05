shader_type canvas_item;


uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float wave_strength : hint_range(0.0, 20.0) = 8.0;
uniform float wave_speed : hint_range(0.0, 10.0) = 1.5;
uniform float distortion_strength : hint_range(0.0, 0.05) = 0.01;
uniform vec4 water_tint : source_color = vec4(0.0, 0.4, 0.6, 0.25);
uniform float blur_amount : hint_range(0.0, 5.0) = 1.0;

void fragment() {
	vec2 uv = SCREEN_UV;
	
	// Add wave effect
	float wave = sin(uv.y * wave_strength + TIME * wave_speed) * distortion_strength;
	uv.x += wave;
	uv.y += sin(uv.x * wave_strength * 0.5 + TIME * wave_speed * 1.2) * distortion_strength;
	
	// Add slight blurr
	vec4 col = texture(SCREEN_TEXTURE, uv);
	col += texture(SCREEN_TEXTURE, uv + vec2(blur_amount * 0.001, 0.0));
	col += texture(SCREEN_TEXTURE, uv - vec2(blur_amount * 0.001, 0.0));
	col += texture(SCREEN_TEXTURE, uv + vec2(0.0, blur_amount * 0.001));
	col += texture(SCREEN_TEXTURE, uv - vec2(0.0, blur_amount * 0.001));
	col /= 5.0;
	
	// Add tint
	COLOR = mix(col, water_tint, water_tint.a);
}
