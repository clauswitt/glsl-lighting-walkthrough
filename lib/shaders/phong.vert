attribute vec4 position;
attribute vec2 uv;
attribute vec3 normal;

uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;

varying vec3 vNormal;
varying vec2 vUv;
varying vec3 vViewPosition;

#pragma glslify: transpose = require('glsl-transpose')
#pragma glslify: inverse = require('glsl-inverse')

void main() {
  mat4 modelViewMatrix = view * model;
  vec4 viewModelPosition = modelViewMatrix * position;

  // Rotate the object normals by a 3x3 normal matrix.
  // We could also do this CPU-side to avoid doing it per-vertex
  mat3 normalMatrix = transpose(inverse(mat3(modelViewMatrix)));

  vNormal = normalize(normalMatrix * normal);
  vViewPosition = viewModelPosition.xyz;
  vUv = uv;

  gl_Position = projection * view * model * vec4(position.xyz, 1.0);
}