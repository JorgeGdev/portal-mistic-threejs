
uniform float uTime;
uniform vec3 uColorStart;
uniform vec3 uColorEnd;

varying vec2 vUv;

#include ./perlin3d.glsl


void main()
{


    //displace UV
    vec2 displacedUv = vUv + cnoise(vec3(vUv.x * 10.0, vUv.y * 10.0, uTime * 0.1)); //añade movimiento al UV

    //float strenght = cnoise(vec3(vUv.x * 10.0, vUv.y * 10.0, uTime)); // animacion que se mueve poquito
    float strenght = cnoise(vec3(displacedUv * 10.0, uTime * 0.2));

    //outer glow

    float outerGlow = distance(vUv, vec2(0.5)) * 3.5 - 1.1; //distance to center
    strenght += outerGlow;

    // Apply step

    strenght += step(-0.2, strenght) *0.8;

    //clamp the value from 0 to 1

    strenght = clamp(strenght, 0.0, 1.0);

    //final color
    vec3 color = mix(uColorStart, uColorEnd, strenght);


    
    
    gl_FragColor = vec4(color, 1.0);
    #include <colorspace_fragment>
}