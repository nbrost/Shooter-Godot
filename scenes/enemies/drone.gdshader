shader_type canvas_item;

uniform float progress: hint_range(0.0, 1.0, 0.1);

void fragment() {
	float current_a = texture(TEXTURE, UV).a;
	float current_r = texture(TEXTURE, UV).r;
	float current_g = texture(TEXTURE, UV).g;
	float current_b = texture(TEXTURE, UV).b;
	//COLOR = mix(texture(TEXTURE, UV), vec4(color,current_a),progress);
	// Called for every pixel the material is visible on.
	COLOR = mix(texture(TEXTURE, UV), vec4(1.0-current_r, 1.0-current_g, 1.0-current_b, current_a), progress);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
