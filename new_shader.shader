shader_type canvas_item;

uniform bool apply = true;
uniform float amount = 1.0;
uniform sampler2D offset_texture : hint_white;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	vec4 color = texture_color;
	
	if (apply == true) {
		float adjusted_amount_x = amount * sin(2.0*TIME)/50.0;
		float adjusted_amount_y = amount * cos(2.0*TIME)/ 50.0;
		color.r = texture(TEXTURE, vec2(UV.x + adjusted_amount_x, UV.y+ adjusted_amount_y)).r;
		color.g = texture(TEXTURE, UV).g;
		color.b = texture(TEXTURE, vec2(UV.x -adjusted_amount_x, UV.y- adjusted_amount_y)).b;
	}
	COLOR = color;
}