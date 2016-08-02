
varying lowp vec4 frag_Color;
varying highp vec3 frag_Normal;
varying lowp vec3 frag_Position;

struct Light {
  
  lowp vec3 Color;
  lowp float AmbientIntensity;
  
  lowp vec3 Direction;
  lowp float DiffuseIntensity;
  
  lowp float Shininess;
  lowp float SpecularIntensity;
  
};

uniform Light light;

void main(void) {
  
  //Ambient
  lowp vec3 AmbientColor = light.Color * light.AmbientIntensity;
  
  //Diffuse
  lowp vec3 Normal = normalize(frag_Normal);
  lowp float DiffuseFactor = max(-dot(light.Direction, Normal), 0.0);
  lowp vec3 DiffuseColor = light.Color * DiffuseFactor * light.DiffuseIntensity;
  
  //Specular
  lowp vec3 Eye = normalize(frag_Position);
  lowp vec3 Reflection = reflect(light.Direction, Normal);
  lowp float SpecularFactor = pow(max(0.0, -dot(Reflection, Eye)), light.Shininess);
  lowp vec3 SpecularColor = light.Color * SpecularFactor * light.SpecularIntensity;
  
  gl_FragColor = frag_Color * vec4(AmbientColor + DiffuseColor , 1);
}