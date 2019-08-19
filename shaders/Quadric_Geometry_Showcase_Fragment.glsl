#version 300 es

precision highp float;
precision highp int;
precision highp sampler2D;

#include <pathtracing_uniforms_and_defines>

uniform mat4 uTorusInvMatrix;
uniform mat3 uTorusNormalMatrix;

#define N_SPHERES 5
#define N_PLANES 1
#define N_DISKS 1
#define N_TRIANGLES 1
#define N_QUADS 1
#define N_BOXES 2
#define N_ELLIPSOIDS 2
#define N_PARABOLOIDS 1
#define N_HYPERBOLICPARABOLOIDS 1
#define N_HYPERBOLOIDS 1
#define N_OPENCYLINDERS 1
#define N_CAPPEDCYLINDERS 1
#define N_CONES 1
#define N_CAPSULES 1
#define N_TORII 1




//-----------------------------------------------------------------------

struct Ray { vec3 origin; vec3 direction; };
struct Sphere { float radius; vec3 position; vec3 emission; vec3 color; int type; };
struct Ellipsoid { vec3 radii; vec3 position; vec3 emission; vec3 color; int type; };
struct Paraboloid { float rad; float height; vec3 pos; vec3 emission; vec3 color; int type; };
struct HyperbolicParaboloid { float rad; float height; vec3 pos; vec3 emission; vec3 color; int type; };
struct Hyperboloid { float rad; float height; vec3 pos; vec3 emission; vec3 color; int type; };
struct OpenCylinder { float radius; float height; vec3 position; vec3 emission; vec3 color; int type; };
struct CappedCylinder { float radius; vec3 cap1pos; vec3 cap2pos; vec3 emission; vec3 color; int type; };
struct Cone { vec3 pos0; float radius0; vec3 pos1; float radius1; vec3 emission; vec3 color; int type; };
struct Capsule { vec3 pos0; float radius0; vec3 pos1; float radius1; vec3 emission; vec3 color; int type; };
struct Torus { float radius0; float radius1; vec3 emission; vec3 color; int type; };
struct Disk { float radius; vec3 pos; vec3 normal; vec3 emission; vec3 color; int type; };
struct Intersection { vec3 normal; vec3 emission; vec3 color; int type; };

Sphere spheres[N_SPHERES];
Ellipsoid ellipsoids[N_ELLIPSOIDS];
Paraboloid paraboloids[N_PARABOLOIDS];
HyperbolicParaboloid hyperbolicParaboloids[N_HYPERBOLICPARABOLOIDS];
Hyperboloid hyperboloids[N_HYPERBOLOIDS];
OpenCylinder openCylinders[N_OPENCYLINDERS];
CappedCylinder cappedCylinders[N_CAPPEDCYLINDERS];
Cone cones[N_CONES];
Capsule capsules[N_CAPSULES];
Torus torii[N_TORII];
Disk disks[N_DISKS];


#include <pathtracing_random_functions>

#include <pathtracing_calc_fresnel_reflectance>

#include <pathtracing_sphere_intersect>

#include <pathtracing_ellipsoid_intersect>

#include <pathtracing_disk_intersect>

#include <pathtracing_opencylinder_intersect>

#include <pathtracing_cappedcylinder_intersect>

#include <pathtracing_cone_intersect>

#include <pathtracing_capsule_intersect>

#include <pathtracing_paraboloid_intersect>

#include <pathtracing_torus_intersect>

#include <pathtracing_sample_sphere_light>


//-------------------------------------------------------------------------------
float HyperboloidIntersect( float rad, float height, vec3 pos, Ray r, out vec3 n )
//-------------------------------------------------------------------------------
{
	vec3 rd = r.direction;
	vec3 ro = r.origin - pos;
	float k = height / (rad * rad);
	
	// quadratic equation coefficients
	float a = k * ((rd.x * rd.x) - (rd.y * rd.y) + (rd.z * rd.z));
	float b = k * 2.0 * ( (rd.x * ro.x) - (rd.y * ro.y) + (rd.z * ro.z) );
	float c = k * ((ro.x * ro.x) - (ro.y * ro.y) + (ro.z * ro.z)) - (rad * rad);
	
	float t0, t1;
	if (!solveQuadratic( a, b, c, t0, t1))
		return INFINITY;
	
	vec3 ip;
	
	if (t0 > 0.0)
	{
		ip = ro + rd * t0;
		n = vec3( 2.0 * ip.x, -2.0 * ip.y, 2.0 * ip.z );
		// flip normal if it is facing away from us
		n *= sign(-dot(rd, n)) * 2.0 - 1.0; // sign is 0 or 1, map it to -1 and +1
		
		if (abs(ip.y) < height)
			return t0;		
	}

	if (t1 > 0.0)
	{	
		ip = ro + rd * t1;
		n = vec3( 2.0 * ip.x, -2.0 * ip.y, 2.0 * ip.z );
		// flip normal if it is facing away from us
		n *= sign(-dot(rd, n)) * 2.0 - 1.0; // sign is 0 or 1, map it to -1 and +1
		
		if (abs(ip.y) < height)
			return t1;	
	}
	
	return INFINITY;	
}


//-----------------------------------------------------------------------------------------
float HyperbolicParaboloidIntersect( float rad, float height, vec3 pos, Ray r, out vec3 n )
//-----------------------------------------------------------------------------------------
{
	vec3 rd = r.direction;
	vec3 ro = r.origin - pos;
	float k = height / (rad * rad);
	
	// quadratic equation coefficients
	float a = k * (rd.x * rd.x - rd.z * rd.z);
	float b = k * 2.0 * (rd.x * ro.x - rd.z * ro.z) - rd.y;
	float c = k * (ro.x * ro.x - ro.z * ro.z) - ro.y;
	
	float t0, t1;
	if (!solveQuadratic( a, b, c, t0, t1))
		return INFINITY;
	
	vec3 ip;

	if (t0 > 0.0)
	{
		ip = ro + rd * t0;
		n = vec3( 2.0 * ip.x, -1.0 / k, -2.0 * ip.z );
		// flip normal if it is facing away from us
		n *= sign(-dot(rd, n)) * 2.0 - 1.0; // sign is 0 or 1, map it to -1 and +1
		
		if (abs(ip.x) < height && abs(ip.y) < height && abs(ip.z) < height)
			return t0;		
	}

	if (t1 > 0.0)
	{	
		ip = ro + rd * t1;
		n = vec3( 2.0 * ip.x, -1.0 / k, -2.0 * ip.z );
		// flip normal if it is facing away from us
		n *= sign(-dot(rd, n)) * 2.0 - 1.0; // sign is 0 or 1, map it to -1 and +1
		
		if (abs(ip.x) < height && abs(ip.y) < height && abs(ip.z) < height)
			return t1;		
	}
		
	return INFINITY;	
}



//-----------------------------------------------------------------------
float SceneIntersect( Ray r, inout Intersection intersec )
//-----------------------------------------------------------------------
{
	float d;
	float t = INFINITY;
	vec3 n;
	
        for (int i = 0; i < N_SPHERES; i++)
        {
		d = SphereIntersect( spheres[i].radius, spheres[i].position, r );
		if (d < t)
		{
			t = d;
			intersec.normal = normalize((r.origin + r.direction * t) - spheres[i].position);
			intersec.emission = spheres[i].emission;
			intersec.color = spheres[i].color;
			intersec.type = spheres[i].type;
		}
        }
	
	for (int i = 0; i < N_ELLIPSOIDS; i++)
        {
		d = EllipsoidIntersect( ellipsoids[i].radii, ellipsoids[i].position, r );
		if (d < t)
		{
			t = d;
			intersec.normal = normalize( ((r.origin + r.direction * t) - ellipsoids[i].position) / (ellipsoids[i].radii * ellipsoids[i].radii) );
			intersec.emission = ellipsoids[i].emission;
			intersec.color = ellipsoids[i].color;
			intersec.type = ellipsoids[i].type;
		}
	}

	d = DiskIntersect( disks[0].radius, disks[0].pos, disks[0].normal, r );
	if (d < t)
	{
		t = d;
		intersec.normal = normalize(disks[0].normal);
		intersec.emission = disks[0].emission;
		intersec.color = disks[0].color;
		intersec.type = disks[0].type;
	}
	
	d = ParaboloidIntersect( paraboloids[0].rad, paraboloids[0].height, paraboloids[0].pos, r, n );
	if (d < t)
	{
		t = d;
		intersec.normal = normalize(n);
		intersec.emission = paraboloids[0].emission;
		intersec.color = paraboloids[0].color;
		intersec.type = paraboloids[0].type;
	}
	
	d = HyperbolicParaboloidIntersect( hyperbolicParaboloids[0].rad, hyperbolicParaboloids[0].height, hyperbolicParaboloids[0].pos, r, n );
	if (d < t)
	{
		t = d;
		intersec.normal = normalize(n);
		intersec.emission = hyperbolicParaboloids[0].emission;
		intersec.color = hyperbolicParaboloids[0].color;
		intersec.type = hyperbolicParaboloids[0].type;
	}
	
	d = HyperboloidIntersect( hyperboloids[0].rad, hyperboloids[0].height, hyperboloids[0].pos, r, n );
	if (d < t)
	{
		t = d;
		intersec.normal = normalize(n);
		intersec.emission = hyperboloids[0].emission;
		intersec.color = hyperboloids[0].color;
		intersec.type = hyperboloids[0].type;
	}
	
	
	d = OpenCylinderIntersect( openCylinders[0].position, openCylinders[0].position + vec3(0,30,30), openCylinders[0].radius, r, n );
	if (d < t)
	{
		t = d;
		intersec.normal = normalize(n);
		intersec.emission = openCylinders[0].emission;
		intersec.color = openCylinders[0].color;
		intersec.type = openCylinders[0].type;
	}
	
	d = CappedCylinderIntersect( cappedCylinders[0].cap1pos, cappedCylinders[0].cap2pos, cappedCylinders[0].radius, r, n);
	if (d < t)
	{
		t = d;
		intersec.normal = normalize(n);
		intersec.emission = cappedCylinders[0].emission;
		intersec.color = cappedCylinders[0].color;
		intersec.type = cappedCylinders[0].type;
	}
	
	d = ConeIntersect( cones[0].pos0, cones[0].radius0, cones[0].pos1, cones[0].radius1, r, n );
	if (d < t)
	{
		t = d;
		intersec.normal = normalize(n);
		intersec.emission = cones[0].emission;
		intersec.color = cones[0].color;
		intersec.type = cones[0].type;
	}
	
	d = CapsuleIntersect( capsules[0].pos0, capsules[0].radius0, capsules[0].pos1, capsules[0].radius1, r, n );
	if (d < t)
	{
		t = d;
		intersec.normal = normalize(n);
		intersec.emission = capsules[0].emission;
		intersec.color = capsules[0].color;
		intersec.type = capsules[0].type;
	}
	
	Ray rObj;
	// transform ray into Torus's object space
	rObj.origin = vec3( uTorusInvMatrix * vec4(r.origin, 1.0) );
	rObj.direction = vec3( uTorusInvMatrix * vec4(r.direction, 0.0) );
		
	d = TorusIntersect( torii[0].radius0, torii[0].radius1, rObj );
	if (d < t)
	{
		t = d;
		vec3 hit = rObj.origin + rObj.direction * t;
		intersec.normal = calcNormal_Torus(hit);
		// transfom normal back into world space
		intersec.normal = vec3(uTorusNormalMatrix * intersec.normal);
		intersec.emission = torii[0].emission;
		intersec.color = torii[0].color;
		intersec.type = torii[0].type;
	}
        
	
	return t;
	
} // end float SceneIntersect( Ray r, inout Intersection intersec )


//-----------------------------------------------------------------------
vec3 CalculateRadiance( Ray r, inout uvec2 seed )
//-----------------------------------------------------------------------
{
	Intersection intersec;
	Sphere lightChoice;
	Ray firstRay;

	vec3 accumCol = vec3(0);
        vec3 mask = vec3(1);
	vec3 firstMask = vec3(1);
	vec3 checkCol0 = vec3(1);
	vec3 checkCol1 = vec3(0.5);
	vec3 dirToLight;
	vec3 tdir;
	vec3 x, n, nl;
        
	float t;
	float nc, nt, Re, Tr;
	float weight;
	float randChoose;
	float diffuseColorBleeding = 0.3; // range: 0.0 - 0.5, amount of color bleeding between surfaces

	bool bounceIsSpecular = true;
	bool sampleLight = false;
	bool firstTypeWasREFR = false;
	bool reflectionTime = false;
	bool firstTypeWasDIFF = false;
	bool shadowTime = false;
	bool firstTypeWasCOAT = false;
	bool specularTime = false;

	
	for (int bounces = 0; bounces < 6; bounces++)
	{
		t = SceneIntersect(r, intersec);
		
		/*
		//not used in this scene because we are inside a huge sphere - no rays can escape
		if (t == INFINITY)
		{
                        break;
		}
		*/
		
		
		if (intersec.type == LIGHT)
		{	
			if (firstTypeWasREFR)
			{
				if (!reflectionTime) 
				{
					if (bounceIsSpecular || sampleLight)
						accumCol = mask * intersec.emission;
					
					// start back at the refractive surface, but this time follow reflective branch
					r = firstRay;
					mask = firstMask;
					// set/reset variables
					reflectionTime = true;
					bounceIsSpecular = true;
					sampleLight = false;
					// continue with the reflection ray
					continue;
				}
				
				accumCol += mask * intersec.emission; // add reflective result to the refractive result (if any)
				break;	
			}

			if (firstTypeWasDIFF)
			{
				if (!shadowTime) 
				{
					if (bounceIsSpecular|| sampleLight)
						accumCol = mask * intersec.emission * 0.5;
					
					// start back at the diffuse surface, but this time follow shadow ray branch
					r = firstRay;
					mask = firstMask;
					// set/reset variables
					shadowTime = true;
					bounceIsSpecular = false;
					sampleLight = true;
					// continue with the shadow ray
					continue;
				}
				
				accumCol += mask * intersec.emission * 0.5; // add shadow ray result to the colorbleed result (if any)
				break;		
			}

			if (firstTypeWasCOAT)
			{
				if (!specularTime) 
				{
					if (sampleLight)
						accumCol = mask * intersec.emission;
					
					// start back at the coated surface, but this time follow reflective branch
					r = firstRay;
					mask = firstMask;
					// set/reset variables
					specularTime = true;
					bounceIsSpecular = true;
					sampleLight = false;
					// continue with the reflection ray
					continue;
				}
				
				accumCol += mask * intersec.emission; // add reflective result to the refractive result (if any)
				break;	
			}

			if (bounceIsSpecular || sampleLight)
				accumCol = mask * intersec.emission; // looking directly at light or through a reflection
			
			// reached a light, so we can exit
			break;
		} // end if (intersec.type == LIGHT)


		// if we get here and sampleLight is still true, shadow ray failed to find a light source
		if (sampleLight) 
		{
			if (firstTypeWasREFR && !reflectionTime) 
			{
				// start back at the refractive surface, but this time follow reflective branch
				r = firstRay;
				mask = firstMask;
				// set/reset variables
				reflectionTime = true;
				bounceIsSpecular = true;
				sampleLight = false;
				// continue with the reflection ray
				continue;
			}

			if (firstTypeWasDIFF && !shadowTime) 
			{
				// start back at the diffuse surface, but this time follow shadow ray branch
				r = firstRay;
				mask = firstMask;
				// set/reset variables
				shadowTime = true;
				bounceIsSpecular = false;
				sampleLight = true;
				// continue with the shadow ray
				continue;
			}

			if (firstTypeWasCOAT && !specularTime) 
			{
				// start back at the coated surface, but this time follow reflective branch
				r = firstRay;
				mask = firstMask;
				// set/reset variables
				specularTime = true;
				bounceIsSpecular = true;
				sampleLight = false;
				// continue with the reflection ray
				continue;
			}

			// nothing left to calculate, so exit	
			break;
		}


		// useful data 
		n = normalize(intersec.normal);
                nl = dot(n, r.direction) < 0.0 ? normalize(n) : normalize(-n);
		x = r.origin + r.direction * t;

		randChoose = rand(seed) * 3.0; // 3 lights to choose from
		lightChoice = spheres[int(randChoose)];

		    
                if (intersec.type == DIFF || intersec.type == CHECK) // Ideal DIFFUSE reflection
		{

			if( intersec.type == CHECK )
			{
				float q = clamp( mod( dot( floor(x.xz * 0.04), vec2(1.0) ), 2.0 ) , 0.0, 1.0 );
				intersec.color = checkCol0 * q + checkCol1 * (1.0 - q);	
			}

			mask *= intersec.color;
			bounceIsSpecular = false;

			if (bounces < 2 && !firstTypeWasDIFF && !firstTypeWasREFR && !firstTypeWasCOAT)
			{	
				// save intersection data for future shadowray trace
				firstTypeWasDIFF = true;
				weight = sampleSphereLight(x, nl, dirToLight, lightChoice, seed);
				firstMask = mask * weight;
                                firstRay = Ray( x, dirToLight ); // create shadow ray pointed towards light
				firstRay.origin += nl * uEPS_intersect;

				// choose random Diffuse sample vector
				r = Ray( x, randomCosWeightedDirectionInHemisphere(nl, seed) );
				r.origin += nl * uEPS_intersect;
				continue;
			}
                        else
                        {
				weight = sampleSphereLight(x, nl, dirToLight, lightChoice, seed);
				mask *= clamp(weight, 0.0, 1.0);

                                r = Ray( x, dirToLight );
				r.origin += nl * uEPS_intersect;
				r.direction = normalize(r.direction);
				sampleLight = true;
				continue;
                        }
		} // end if (intersec.type == DIFF)
		
		if (intersec.type == SPEC)  // Ideal SPECULAR reflection
		{
			mask *= intersec.color;

			r = Ray( x, reflect(r.direction, nl) );
			r.origin += nl * uEPS_intersect;

			//bounceIsSpecular = true; // turn on mirror caustics
			continue;
		}
		
		if (intersec.type == REFR)  // Ideal dielectric REFRACTION
		{
			nc = 1.0; // IOR of Air
			nt = 1.5; // IOR of common Glass
			Re = calcFresnelReflectance(n, nl, r.direction, nc, nt, tdir);
			Tr = 1.0 - Re;

			if (bounces < 2 && !firstTypeWasREFR && !firstTypeWasDIFF && !firstTypeWasCOAT)
			{	
				// save intersection data for future reflection trace
				firstTypeWasREFR = true;
				firstMask = mask * Re;
				firstRay = Ray( x, reflect(r.direction, nl) ); // create reflection ray from surface
				firstRay.origin += nl * uEPS_intersect;
				mask *= Tr;
			}
			else if (rand(seed) < Re)
			{
				r = Ray( x, reflect(r.direction, nl) ); // reflect ray from surface
				r.origin += nl * uEPS_intersect;
				continue;
			}

			// transmit ray through surface
			mask *= intersec.color;
			
			r = Ray(x, tdir);
			r.origin -= nl * uEPS_intersect;

			bounceIsSpecular = true; // turn on refracting caustics
			continue;
			
		} // end if (intersec.type == REFR)
		
		if (intersec.type == COAT)  // Diffuse object underneath with ClearCoat on top
		{
			nc = 1.0; // IOR of Air
			nt = 1.4; // IOR of Clear Coat
			Re = calcFresnelReflectance(n, nl, r.direction, nc, nt, tdir);
			Tr = 1.0 - Re;

			if (bounces < 2 && !firstTypeWasCOAT && !firstTypeWasDIFF && !firstTypeWasREFR)
			{	
				// save intersection data for future reflection trace
				firstTypeWasCOAT = true;
				firstMask = mask * Re;
				firstRay = Ray( x, reflect(r.direction, nl) ); // create reflection ray from surface
				firstRay.origin += nl * uEPS_intersect;
				mask *= Tr;
			}
			else if (rand(seed) < Re)
			{
				r = Ray( x, reflect(r.direction, nl) ); // reflect ray from surface
				r.origin += nl * uEPS_intersect;
				continue;
			}

			mask *= intersec.color;
			
			bounceIsSpecular = false;

			if (bounces < 2 && firstTypeWasCOAT && rand(seed) < diffuseColorBleeding)
                        {
                                // choose random Diffuse sample vector
				r = Ray( x, randomCosWeightedDirectionInHemisphere(nl, seed) );
				r.origin += nl * uEPS_intersect;
				continue;
                        }
                        else
                        {
				if (intersec.color.r == 1.0 && rand(seed) < 0.9)
					lightChoice = spheres[0]; // this makes capsule more white
				weight = sampleSphereLight(x, nl, dirToLight, lightChoice, seed);
				mask *= clamp(weight, 0.0, 1.0);
				
                                r = Ray( x, dirToLight );
				r.origin += nl * uEPS_intersect;

				sampleLight = true;
				continue;
                        }
			
		} //end if (intersec.type == COAT)
		
	} // end for (int bounces = 0; bounces < 6; bounces++)
	
	return accumCol;      
} // end vec3 CalculateRadiance( Ray r, inout uvec2 seed )



//-----------------------------------------------------------------------
void SetupScene(void)
//-----------------------------------------------------------------------
{
	vec3 z  = vec3(0.0);          
	vec3 L1 = vec3(1.0, 1.0, 1.0) * 18.0;// White light
	vec3 L2 = vec3(1.0, 0.8, 0.2) * 15.0;// Yellow light
	vec3 L3 = vec3(0.1, 0.7, 1.0) * 10.0;// Blue light
		
        spheres[0] = Sphere(150.0, vec3(-400, 900, 200), L1, z, LIGHT);//spherical white Light1 
	spheres[1] = Sphere(100.0, vec3(300, 400, -300), L2, z, LIGHT);//spherical yellow Light2
	spheres[2] = Sphere( 50.0, vec3(500, 250, -100), L3, z, LIGHT);//spherical blue Light3
	
	spheres[3] = Sphere(1000.0, vec3(  0, 1000,  0), z, vec3(1.0, 1.0, 1.0), CHECK);//Checkered Floor Huge Sphere       
        spheres[4] = Sphere(  15.0, vec3( 32,   16, 30), z, vec3(1.0, 1.0, 1.0),  REFR);//Glass sphere
	
	disks[0] = Disk( 15.0, vec3(-100, 18,-10), vec3( 1.0,-1.0,0.0 ), z, vec3(0.01,0.3,0.7), DIFF);//BlueDisk Left

	ellipsoids[0] = Ellipsoid( vec3(30, 40, 16), vec3(90, 5, -30),  z, vec3(1.0, 0.765557, 0.336057), SPEC);//metallic gold ellipsoid
	ellipsoids[1] = Ellipsoid( vec3(5, 16, 28), vec3(-25, 16.5, 5), z, vec3(0.9, 0.9, 0.9), SPEC);//Mirror ellipsoid
	
	paraboloids[0] = Paraboloid( 20.0, 15.0, vec3(20, 2.5, -50), z, vec3(1.0, 0.2, 0.7), REFR);//paraboloid
	
	hyperbolicParaboloids[0] = HyperbolicParaboloid( 40.0, 40.0, vec3(20, 70, -50), z, vec3(1.0, 1.0, 1.0), CHECK);//hyperbolic paraboloid
	
	hyperboloids[0] = Hyperboloid( 4.0, 15.0, vec3(-15, 22, -100), z, vec3(0.3, 0.7, 0.5), REFR);//hyperboloid
	
	openCylinders[0] = OpenCylinder( 15.0, 30.0, vec3(-70, 7, -80), z, vec3(0.9, 0.01, 0.01), REFR);//red glass open Cylinder
	cappedCylinders[0] = CappedCylinder( 14.0, vec3(-60, 0, 20), vec3(-60, 14, 20), z, vec3(0.04, 0.04, 0.04), COAT);//dark gray capped Cylinder
	
	cones[0] = Cone( vec3(1, 20, -12), 15.0, vec3(1, 0, -12), 0.0, z, vec3(0.01, 0.1, 0.5), REFR);//blue Cone
	
	capsules[0] = Capsule( vec3(80, 13, 15), 10.0, vec3(110, 15.8, 15), 10.0, z, vec3(1.0,1.0,1.0), COAT);//white Capsule
	
	torii[0] = Torus( 10.0, 1.5, z, vec3(0.955008, 0.637427, 0.538163), SPEC);//copper Torus
		
}


#include <pathtracing_main>
