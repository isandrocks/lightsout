shader_type canvas_item;
varying vec2 iResolution;
varying vec2 canvas;

vec2 rotate2D(vec2 _st, float _angle){
    _st -= 0.5;
    float a = cos(_angle);
    float b = -sin(_angle);
    float c = sin(_angle);
    float d = cos(_angle);
    vec2 row1 = vec2(a, b);
    vec2 row2 = vec2(c, d);
    mat2 built_mat2 = mat2(row1, row2);
    _st = built_mat2 * _st.xy;
    _st += 0.5;
    return _st;
}

vec2 tile(vec2 _st, float _zoom){
    _st *= _zoom;
    return fract(_st);
}

float box(vec2 _st, vec2 _size, float _smoothEdges){
    _size = vec2(0.5)-_size*0.5;
    vec2 aa = vec2(_smoothEdges*0.01);
    vec2 uv = smoothstep(_size,_size+aa,_st);
    uv *= smoothstep(_size,_size+aa,vec2(1.0)-_st);
    return uv.x*uv.y;
}

void vertex() {
	// Called for every vertex the material is visible on.
	iResolution = (SCREEN_MATRIX * vec4(1.0, 0.5 , 1.0, 1.0)).xy;
	
}

void fragment() {
	vec2 st = (UV.xy/iResolution.xy);
	float angle = 0.25;
	float i = mod(TIME, 7.0);
	 
	while (i < 0.76) {
			if (i >= 0.25 && i <= 0.75) {
					angle = i;
			} else {
					angle = 0.25;
			}
			break; // Exit the loop to avoid infinite loop
	}
	
	// tile setup
	st = tile(st,8.);
	st = rotate2D(st, PI * angle);

	// clamp setup
	vec3 vec3_min = vec3(0.0);
	vec3 vec3_max = vec3(1.0);

    // Draw a square
	vec3 fcolor = (vec3(box(st,vec2(0.880),10))) - vec3(.88,.88,.88);
	fcolor = clamp(fcolor, vec3_min, vec3_max);
	
	// setting the final colors 
	fcolor = fcolor + vec3(0.12,0.12,0.14);

    COLOR = vec4(fcolor, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
