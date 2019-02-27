# THREE.js-PathTracing-Renderer
Real-time PathTracing with global illumination and progressive rendering, all on top of the Three.js WebGL framework.

<h2>LIVE DEMOS</h2>

* [Geometry Showcase Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Geometry_Showcase.html) demonstrating some primitive shapes for ray tracing.

* [Animated BVH Model Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/BVH_Animated_Model.html) not only loads and renders a 15,000+ triangle GLTF model with correct PBR materials (albedo, emmisive, metallicRoughness, and normal maps), but it also translates and rotates the entire model and its BVH structure in real time at 60 fps!  Loading animations for rigged models is W.I.P. still under investigation, but getting the models to move, rotate, and scale arbitrarily was a huge step forward for the path tracing engine!

* [Ocean and Sky Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Ocean_And_Sky_Rendering.html) which models an enormous calm ocean underneath a realistic physical sky. Now has more photo-realistic procedural clouds!

* [Billiard Table Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Billiard_Table.html) shows support for image textures (i.e. .jpg .png) being loaded and used for materials (the billiard table cloth and two types of wood texture images are demonstrated).

* [Cornell Box Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Cornell_Box.html) This demo renders the famous Cornell Box in real-time!

For comparison, here is a real photograph of the original Cornell Box vs. a rendering with the three.js PathTracer:

![](readme-Images/measured.jpg) ![](readme-Images/CornellBox-Render0.png)

<br>

* [Volumetric Rendering Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Volumetric_Rendering.html) renders objects inside a volume of dust/fog/etc..  Notice the cool volumetric caustics from the glass sphere on the left, rendered almost instantly!

* [Terrain Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Terrain_Rendering.html) combines traditional raytracing with raymarching to render stunning outdoor environments in real time!  Land is procedurally generated, can be altered with simple parameters. Total number of triangles processed for these worlds: 2! (for screen size quad) :-)

* [Planet Demo (W.I.P.)](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Planet_Rendering.html) takes raymarching and raytracing to the extreme and renders an entire Earth-like planet with physically-based atmosphere!  Still a work in progress, the terrain is procedurely generated.  Although the mountains/lakes are too repetitious (W.I.P.), this simulation demonstrates the power of path tracing: you can hover above the planet at high orbit (5000 Km altitude), then drop all the way down and land your camera right on top of a single rock or single lake water wave (1 meter). All planet/atmosphere measurements are to scale.  The level of detail possible with raytracing is extraordinary! (note: demo is for Desktop only - Mobile lacks the precision to explore the terrain correctly)

* [Water Rendering Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Water_Rendering.html) Renders photo-realistic water and simulates waves at 60 FPS. No triangle meshes are needed, as opposed to other traditional engines/renderers. In fact, not a single triangle was harmed during the making of this water volume! It is done through object/ray warping. Total cost: 1 ray-box intersection test!

* [Quadric Geometry Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Quadric_Geometry_Showcase.html) showing different quadric (mathematical) shapes (Warning: this may take 7-10 seconds to load/compile!)

* [BVH Point Light Source Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/BVH_Point_Light_Source.html) Demonstrates use of a point light to illuminate the famous Stanford Bunny (30,000+ triangles!).  Normally a dark scene like this with a very bright small light would be super-noisy, but thanks to randomized direct light targeting, the image converges almost instantly!

* [BVH Spot Light Source Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/BVH_Spot_Light_Source.html) A similar scene but this time a bright spotlight in the air is aimed at the Stanford Bunny, making him the star of the scene!  The spotlight is made out of dark metal on the outside and a reflective metal on the inside.  Notice the light falloff on the checkered floor.

* [BVH Visualizer Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/BVH_Visualizer.html) Lets you peek under the hood of the BVH acceleration structure and see how the various axis-aligned bounding boxes are built all the way from the large surrounding root node box (level 0), to the small leaf node boxes (level 14+), to the individual triangles of the model that are contained within those leaf node boxes.  This demo loads the famous Stanford Dragon, weighing in at 100,000 triangles!<br>

<h3>Constructive Solid Geometry(CSG) Museum Demos</h3>

The following demos showcase different techniques in Constructive Solid Geometry - taking one 3D shape and either adding, removing, or overlapping a second shape. (Warning: these demos may take 10 seconds to load/compile!) <br>
All 4 demos feature a large dark glass sculpture in the center of the room, which shows Ellipsoid vs. Sphere CSG. <br>
Along the back wall, a study in Box vs. Sphere CSG: [CSG_Museum Demo #1](https://erichlof.github.io/THREE.js-PathTracing-Renderer/CSG_Museum_1.html) <br>
Along the right wall, a glass-encased monolith, and a study in Sphere vs. Cylinder CSG: [CSG_Museum Demo #2](https://erichlof.github.io/THREE.js-PathTracing-Renderer/CSG_Museum_2.html) <br>
Along the wall behind the camera, a study in Ellipsoid vs. Sphere CSG: [CSG_Museum Demo #3](https://erichlof.github.io/THREE.js-PathTracing-Renderer/CSG_Museum_3.html) <br>
Along the left wall, a study in Box vs. Cone CSG: [CSG_Museum Demo #4](https://erichlof.github.io/THREE.js-PathTracing-Renderer/CSG_Museum_4.html) <br>

Important note! - There is a hidden Easter Egg in one of the 4 Museum demo rooms.  Happy hunting!

<h3>Materials Demo</h3>

The following demo showcases different materials possibilities. The materials that are feautured are: Diffuse (matte wall paint/chalk), Refractive (glass/water), Specular (aluminum/gold), ClearCoat (billiard ball, plastic, porcelain), Car clearCoat (colored metal with clear coat), Translucent (skin/balloons, etc.), and shiny SubSurface scattering (polished Jade/wax/marble, etc.) <br>
* [Switching Materials Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Switching_Materials.html) <br> <br>

* <h3>Classic Scenes</h3>

![](readme-Images/Whitted_1979.jpg)

While working at Bell Labs and writing his now-famous paper [An Improved Illumination Model for Shaded Display](http://artis.imag.fr/Members/David.Roger/whitted.pdf), J. Turner Whitted created an iconic ray traced scene which showcased his novel methods for producing more realistic images with a computer. Beginning work in 1978, he rendered a handful of scenes featuring spheres and planes with various materials and reflectivity, so that these images would be included in his paper (which would be published in June 1980).  Then, for an upcoming SIGGRAPH conference submission, Whitted decided to create an animated sequence of individual rendered images.  Thus the first ever ray traced animation was born!  This style of putting together single frames of pre-rendered images would continue through a lineage of movies such as Tron, Toy Story, Cars, all the way to current animated feature films.     

[Vintage 1979 Video: 'The Compleat Angler' by J. Turner Whitted](https://youtu.be/0KrCh5qD9Ho)

Although this movie appears as a smooth animation, it took around 45 minutes to render each individual frame back in 1979!  Fast forward to today and using WebGL 2.0 and the parallel processing power of GPUs, here is the same iconic scene rendered at 60 times a second in your browser! : <br>
* [The Compleat Angler demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Classic_Scene_Whitted_TheCompleatAngler.html) <br>

Thank you J. Turner Whitted for your pioneering computer graphics work and for helping start the rendered animation industry!  <br> 
<br>

In 1986 James T. Kajiya published his famous paper The Rendering Equation, in which he presented an elegant unifying integral equation that generalizes a variety of previously known rendering algorithms.  Since the equation is infinitely recursive and hopelessly multidimensional, he suggests using Monte Carlo integration (sampling and averaging) to converge on a solution.  Thus Monte Carlo path tracing was born, which this repo follows fairly closely.  At the end of his paper he included an image that demonstrates global illumination through path tracing:

![](readme-Images/kajiya.jpg)

And here is the same scene from 1986, rendered in real-time at 60 fps: <br>
* [The Rendering Equation Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Classic_Scene_Kajiya_TheRenderingEquation.html) <br>
<br>

* <h4>Bi-Directional Path Tracing</h4> Nearly 20 years ago (Dec 1997), Eric Veach wrote a seminal PhD thesis paper on methods for light transport http://graphics.stanford.edu/papers/veach_thesis/  In Chapter 10, entitled Bi-Directional Path Tracing, Veach outlines a novel way to deal with difficult path tracing scenarios with hidden light sources (i.e. cove lighting, recessed lighting, spotlights, window lighting on a cloudy day, etc.).  Instead of just shooting rays from the camera like we normally do, we also shoot rays from the light sources, and then join the camera paths to the light paths.  Although his full method is difficult to implement on GPUs because of memory storage requirements, I took the basic idea and applied it to real-time path tracing of his classic test scene with hidden light sources.  For reference, here is a rendering made by Veach for his 1997 paper:

![](readme-Images/Veach-BiDirectional.jpg)

And here is the same room rendered in real-time by the three.js path tracer: <br>
* [Bi-Directional PathTracing Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Bi-Directional_PathTracing.html) <br>

The following classic scene rendering comes from later in the same paper by Veach.  This scene is intentionally difficult to converge because there is no direct light, only indirect light hitting the walls and ceiling from a crack in the doorway.  Further complicating things is the fact that caustics must be captured by the glass object on the coffee table, without being able to directly connect with the light source.

![](readme-Images/Veach-DifficultLighting.jpg)

And here is that scene rendered in real-time by the three.js path tracer: Try pressing 'E' and 'R' to open and close the door! <br>
* [Difficult Lighting Classic Test Scene Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Bi-Directional_Difficult_Lighting.html) <br>

I had the above images only to go on - there are no scene dimensions specifications that I am aware of.  Since I'm experimenting with the BVH acceleration structure and multiple models, I simplified the sculptures on the coffee table from Utah teapots to ellipsoids.  However, I feel that I have captured the essence and purpose of his test scene rooms.  I think Veach would be interested to know that his scenes, which probably took several minutes if not hours to render back in the 1990's, are now rendering real-time near 60 FPS on a web browser! :-D

For more intuition and a direct comparison between regular path tracing and bi-directional path tracing, here is the old Cornell Box scene but this time there is a blocker panel that blocks most of the light source in the ceiling.  The naive approach is just to hope that the camera rays will be lucky enough to find a light source:
* [Naive Approach to Blocked Light Source](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Compare_Uni-Directional_Approach.html) As we can painfully see, we will have to wait a long time to get a decent image!
Enter Bi-Directional path tracing to the rescue!:
* [Bi-Directional Approach to Blocked Light Source](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Compare_Bi-Directional_Approach.html) Like magic, the difficult scene comes into focus - in real-time! <br> <br> <br>

![](readme-Images/threejsPathTracing.png)


<h2>FEATURES</h2>

* Real-time interactive Path Tracing in your browser - even on your smartphone! ( What?! )
* First-Person camera navigation through the 3D scene.
* When camera is still, switches to progressive rendering mode and converges on a photo-realistic result!
* The accumulated render image will converge at around 500-3,000 samples (lower for simple scenes, higher for complex scenes).
* Randomized Direct Light sampling now makes images render/converge almost instantly!
* Both Uni-Directional (normal) and Bi-Directional path tracing approaches available for different lighting situations.
* Support for: Spheres, Planes, Discs, Quads, Triangles, and quadrics such as Cylinders, Cones, Ellipsoids, Paraboloids, Hyperboloids, Capsules, and Rings/Torii. Parametric/procedural surfaces (i.e. terrain, clouds, waves, etc.) are handled through Raymarching.
* Constructive Solid Geometry(CSG) allows you to combine 2 shapes using operations like addition, subtraction, and overlap.
* Support for loading models in .gltf and .glb formats
* BVH (Bounding Volume Hierarchy) greatly speeds up rendering of triangle models in gltf/glb format (tested up to 500,000 triangles!)
* Current material options: Metallic (mirrors, gold, etc.), Refractive (glass, water, etc.), Diffuse(matte, chalk, etc), ClearCoat(cars, plastic, billiard balls, etc.), Translucent (skin, leaves, cloth, etc.), Subsurface w/ shiny coat (jelly beans, cherries, teeth, polished Jade, etc.)
* Support for PBR materials on models in gltf format (albedo diffuse, emissive, metallicRoughness, and normal maps)        
* Diffuse/Matte objects use Monte Carlo integration (a random process, hence the visual noise) to sample the unit-hemisphere oriented around the normal of the ray-object hitpoint and collects any light that is being received.  This is the key-difference between path tracing and simple old-fashioned ray tracing.  This is what produces realistic global illumination effects such as color bleeding/sharing between diffuse objects and refractive caustics from specular/glass/water objects.
* Camera has Depth of Field with real-time adjustable Focal Distance and Aperture Size settings for a still-photography or cinematic look.
* SuperSampling gives beautiful, clean Anti-Aliasing (no jagged edges!)
* Users will be able to use easy, familiar commands from the Three.js library, but under-the-hood the Three.js Renderer will use this path tracing engine to render the final output to the screen.

<h3>Experimental Works in Progress (W.I.P.)</h3>

The following demos show what I have been experimenting with most recently.  They might not work 100% and might have small visual artifacts that I am trying to fix.  I just wanted to share some more possible areas in the world of path tracing! :-) <br>

Some pretty interesting shapes can be obtained by deforming objects and/or warping the ray space (position and direction).  This demo applies a twist warp to the spheres and mirror box and randomizes the object space of the top purple sphere, creating an acceptable representation of a cloud (for free - no extra processing time for volumetrics!) <br>

* [Ray/Object Warping Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Ray_Warping.html)<br>

I had the code to the following demo lying around in my code editor for months.  It's a work in progress (W.I.P.) real-time rendering of an Arctic Circle environment.  I was experimenting with my ray marching engine and what types of environments I could get out of it by just altering some parameters.  I'm still trying to figure out how to render the blueish color deep inside polar ice, but I've been working on other things for this repo like the BVH demos instead. So far it's pretty cool though - when the scene first opens, it's almost like you're transported to the far north! As path tracing gets faster in the future, this is how we will travel!  ;-) <br>

* [Arctic Circle Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/Arctic_Circle.html)<br>

Before I got into this world of path tracing, I was a 3D game programmer (and still am, although path tracing is consuming most of my coding time!).  My first game was way back in 1998, using OpenGL 1 and the C language, back when these new things called graphics cards were all the rage! [my old Binary Brotherz page](https://web.archive.org/web/20010405004141/http://www.binarybrotherz.com/games.html)  Although using OpenGL back then, and WebGL today was/is cool, I always wanted more in terms of lighting, shadows, reflections, diffuse color sharing, etc., in my game engine that I just couldn't get from rasterizing graphics APIs.  Well, fast forward to 2019 and NVidia is releasing graphics cards dedicated to real-time ray tracing!  I couldn't have imagined this back in the 90's! However, at the time I'm writing this, NVidia is only doing specular ray tracing as a bonus feature on top of the old rasterization technique. I wanted to see if I could 'overclock' my full path tracer's convergence so that you could see the beautiful light effects in real time, being able to possibly move a game character or 1st-person camera through a Path traced game environment at 60 fps.  Recently, I have been experimenting with different amounts of diffuse color bleeding vs. direct light shadows and, if you're willing to sacrafice some ultimate physical reality (like full color sharing, or perfect converged refracted caustics), then you can have this!: <br>

* [Future Game Engine PathTracer Demo](https://erichlof.github.io/THREE.js-PathTracing-Renderer/GameEngine_PathTracer.html)<br>
To my knowledge, this is just about as fast as I can push the path tracing engine and WebGL in general, and still retain good lighting, accurate reflections, and almost instant convergence of noise.  As computers get faster, this will be the future game engine - a simple path tracer that is just around 500 to 1000 lines of code, which is easy to maintain and debug, and that gives photo-realistic real-time results! I already have some ideas for some simple 3d games that can use this technology.  I'll keep you posted! 


<h2>Updates</h2>

* February 1st, 2019: Refactor of entire codebase in progress!  One by one, I am updating each demo to be more streamlined in terms of code size.  Previously I had a lot of duplicated code from .html file to .html file.  Now I separated concerns by having a commonFunctions.js file that all the demos can pull from.  Also, I put the shader code (the heart of the path tracer) for each demo in its own .glsl file, which can now be correctly syntax highlighted by most code editors.  Lastly I pulled out the style tags and made a shared default.css file that the demos can pull from.  Now the .html files are bare-bones, and pull in their .js files for functionality, as recommended by most web developers.  It is a big change, I'm only 1/4 done as of Feb. 1st, but in the long run this will make the entire repo less error-prone, as I only have to update the shared files if I want something different across the engine/demos.  And it will cut down on the code size by a factor of at least 10.  The end user should not notice any difference in functionality, this is a pure refactor.  But if you look at the code files for Geometry_Showcase (the first demo I updated so far), you'll see that it has a much cleaner layout!

* December 28th, 2018: Global lighting algorithm changes across the entire codebase.  Lately I have been trying to implement different light types (point light, spot light, etc.) to the scenes containing a large triangle model with its BVH. Applying the same direct lighting algo to this scenario didn't quite work as well as I had hoped, due to the doubling of geometry searches each frame in order to make the direct lighting work.  The frame rate suffered and sometimes the browser WebGL rendering context would be lost all together.  While reading for enjoyment one day I happened to come upon a single sentence from Peter Shirley's relatively recent series entitled Ray Tracing in One Weekend (a great read) where he mentions that there are 2 camps: the first of which I and most path tracing coders out there belonged to is one where you sample the light directly on each diffuse bounce (direct lighting / or the shadow ray technique). The other camp in the minority (of which Peter Shirley is a member, and now me too) is one where you statistically just send the diffuse reflected rays more toward the light source (no matter how small it is), and down-weight the contributions according to probability theory.  I tried this 'new' approach on my old Cornell Box demo, replacing the heavy direct lighting with the new lightweight stochastic light sampling and it worked so well that I changed all the demos on this repo to use the second camp's approach!  It increased the frame rate (especially on mobile, not having to search the geometry twice on each diffuse bounce) and noise converging is as-fast or nearly-as-fast depending on the lighting complexity.  Often I can't visually tell which one is being used, which is a good thing!  But the important thing is that when I add small light sources to the BVH scenes in the near future, hopefully this new technique will scale much better and avoid the framerate hit and the browser crashing.  Stay tuned!
* November 1st, 2018: New Iterative BVH Builder!  Unlike the previous recursive builder (which crashed if you even looked at it the wrong way, ha) this new iterative version actually works!  It is very robust, handling low poly up to 500,000 triangles (that's how much I tested so far, maybe it will handle millions).  Now the models can be rotated and scaled to any dimensions upon loading, and the BVH builder will just do its job. Depending on how close you are to the model, rendering stays at a rock-solid 60 fps on my humble laptop with integrated graphics.  Of course if you try flying the camera inside of a dense model, the framerate will tank (due to the BVH being called multiple times and camera ray divergence), but aside from that, it works great!  The only major issue is that it won't compile on my cell phone, so this may be a desktop-only feature of the renderer (I am investigating possible solutions for mobile).  Next on the TODO list is to add support for diffuse texture mapping of models (as specified in their respective .obj and .mtl files).  I figured out how to apply 1 texture to the entire model, but I'm still looking into ways of handling multiple textures for the same model. Then it will be time to try loading multiple objects (different .obj files) into the same scene.  But for now, I'm really happy with how my builder is shaping up; it's amazing that in 2018 we can load anywhere from 50 to 500,000 triangles and path-trace them in real time inside a browser! :-)   
* October 2nd, 2018: I successfully made the migration to WebGL 2.0.  All the demos now use the WebGL2 rendering context.  WebGL 2.0 allows dynamic array indexing and as a result, the BVH for triangle models is working nicely.  It is the first working version, and there is a lot of work and improving to do.  But initial results are promising.  Also WebGL 2.0 allows bit shifting/ manipulations inside the fragment shader, so I have updated the RNG (random number generator) to use a more traditional integer hashing routine (courtesy of iq on ShaderToy) that produces higher-quality, better random numbers each time it is called.  The old one used fract(sin(large number)) that you typically see around the internet for GPU RNGs, but it had slight visual flaws.  The new RNG produces sharper, cleaner images that converge even faster now that the Monte Carlo path tracing algo (which requires a high quality RNG for sampling) can better do its job. 



<h2>TODO</h2>

* Add support for multiple BVH models in the same scene, which will require a BVH for the BVH's! ;-)
* Instead of scene description hard-coded in the path tracing shader, let the scene be defined using the Three.js library
* Dynamic Scene description/BVH rigged model animation streamed real-time to the GPU path tracer<br>

<h2>ABOUT</h2>

* This began as a port of Kevin Beason's brilliant 'smallPT' ("small PathTracer") over to the Three.js WebGL framework.  http://www.kevinbeason.com/smallpt/  Kevin's original 'smallPT' only supports spheres of various sizes and is meant to render offline, saving the image to a PPM text file (not real-time). I have so far added features such as real-time progressive rendering on any device with a Chrome browser, FirstPerson Camera controls with Depth of Field, more Ray-Primitive object intersection support (such as planes, triangles, and quadrics), and support for more materials like ClearCoat and SubSurface. <br>

This project is in the alpha stage.  More examples, features, and content to come...
