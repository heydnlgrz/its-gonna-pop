extern vec2 lightPosition;
extern float radius;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec2 direction = lightPosition - screen_coords;
    float distance = length(direction);
    float attenuation = 1.0 / (distance / radius + 1.0);
    vec4 pixel = Texel(texture, texture_coords);
    return pixel * color * attenuation;
}
