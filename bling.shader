shader_type canvas_item;

uniform bool active = true;

void fragment(){
	//获取每一个位置的颜色像素
	vec4 previous_color = texture(TEXTURE, UV);
	vec4 white = vec4(1.0,1.0,1.0,previous_color.a);
	vec4 new_color = previous_color;
	if (active == true){
		new_color = white;
	}
	//函数最后需要这个
	COLOR = new_color;
}