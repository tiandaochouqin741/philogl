attribute float indices;

varying vec4 vPosition;
varying float depth;
varying vec3 position;
varying float idx;

uniform sampler2D sampler1, sampler2, sampler3;

uniform float multiple;
uniform mat4 objectMatrix, viewMatrix, worldMatrix;
uniform mat4 projectionMatrix;
uniform mat4 viewProjectionMatrix;
varying vec2 vTexCoord;
varying vec3 color;

uniform float devicePixelRatio;
#include "3d.glsl"

void main(void) {
  idx = indices + multiple * 256. * 256.;
//  position = vec3(mod(indices, 32.0) / 32.0, mod(floor(indices / 32.0), 32.0) / 32.0, floor(indices / 1024.0) / 64.0);
//  position = vec3(mod(indices, 256.0) / 256.0, mod(floor(indices / 256.0), 256.0) / 256.0, 0.5);
  position = texture2D(sampler2, vec2(mod(indices, 256.0) / 256.0, floor(indices / 256.0) /256.0)).xyz;
  color = (getAA(sampler1, position) * .5 +0.2);
  position.x = position.x * 2. - 1.;
  position.y = position.y * 2. - 1.;
  position.z = position.z * 2.;
  vPosition = vec4(position, 1);
  gl_Position = projectionMatrix * worldMatrix * vPosition;
  gl_PointSize = devicePixelRatio * 20. / (gl_Position.z + 1.);
  depth = gl_Position.z; 
  vTexCoord = vec2(0);
}
