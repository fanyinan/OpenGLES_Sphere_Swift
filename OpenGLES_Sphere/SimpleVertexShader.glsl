
attribute vec4 Position;
attribute vec4 Color;
attribute vec3 Normal;

varying vec4 frag_Color;
varying highp vec3 frag_Normal;
varying lowp vec3 frag_Position;

uniform mat4 ProjectionMatrix;
uniform mat4 ModelViewMatrix;

void main(void) {
  
  frag_Color = Color;
  frag_Normal = (ModelViewMatrix * vec4(Normal, 0)).xyz;
  frag_Position = (ModelViewMatrix * Position).xyz;
  gl_Position = ProjectionMatrix * ModelViewMatrix * Position;
}