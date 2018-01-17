/*  The purpose of this code is to generate training data for a point detector.
	This code transforms a cube in the Unity game engine, takes a screenshot,
	and writes the corner point pixel coordinates in the screenshot to a text file.

	The issues I faced were that I had never used Javascript before, and that
	I needed a way to determine whether the corners of the cube were visible
	to the camera.

	To solve this issue, I used a raycast on every corner of the cube. If the first point 
	hit by the raycast is the corner, then that corner is visible. If, however, that isn't 
	true, then the corner must be on the "back side" of the cube. */

#pragma strict

var cam: Camera;
var mesh : Mesh;

function Start() {
	cam = GameObject.Find("MainCamera").GetComponent.<Camera>();
}

function Update () {

	mesh = GetComponent.<MeshFilter>().sharedMesh;
	
	// These transforms have the cube appear in camera view
	transform.localScale = Vector3(Random.value, Random.value , Random.value );
	transform.position = Vector3(Random.value * 1.8 + 1, Random.value + 1.5, Random.value - 1);
	transform.rotation = Random.rotation;
	
	// Generating a unique filename
	Application.CaptureScreenshot("screenshots/Screenshot" + Time.time + ".png");

	// In Unity the mesh.vertices are unit vectors pointing to the cube's corners
	var points: Vector3[] = mesh.vertices;

	for(var i = 0; i < mesh.vertices.length; i++){

		// For debugging purposes, so I can see whether the vertices are correctly transformed
		points[i] = Vector3.Scale((points[i]), transform.lossyScale);
		points[i] = transform.TransformDirection(points[i]);
		Debug.DrawRay(transform.position, points[i], Color.red);
	}

	var corners = new Array();

	for(var j = 0; j < 8; j++){

		// dir is the vector from camera to each vertex
		var dir : Vector3;
		dir = points[j] + transform.position - cam.ViewportToWorldPoint(new Vector3(0.5, 0.5, 0));
		
		if(Physics.Raycast(cam.ViewportToWorldPoint(new Vector3(0.5, 0.5, 0)), dir));
		{
			// Raycasts from camera along vector dir, if hit, then multhits is populated with the raycast vector
			var multhits: RaycastHit[];
			multhits = Physics.RaycastAll(cam.ViewportToWorldPoint(new Vector3(0.5, 0.5, 0)), dir);

			// Drawing the raycast for debugging
			Debug.DrawRay(cam.ViewportToWorldPoint(new Vector3(0.5, 0.5, 0)), multhits[0].point - cam.ViewportToWorldPoint(new Vector3(0.5, 0.5, 0)), Color.green);

			// Raycast hits aren't ordered by distance in Unity, so this step is necessary
			var smallest : RaycastHit;
			var smallestdist : float = 1000000000.0;

			for(var y: int = 0; y < multhits.length; y++) {
				if(multhits[y].distance < smallestdist){
					smallest = multhits[y];
					smallestdist = multhits[y].distance;
				}
			}
			if(smallest.point == transform.TransformPoint(mesh.vertices[j])){
				corners.push(smallest.point);
			}
		}
	}

	var screenPos = new Array();

	// Converting world points to screen points
	for(var k = 0; k < corners.length; k++){
		screenPos[k] = cam.WorldToScreenPoint(corners[k]);
	}
	
	// Writing ground truth corner pixel positions to file
	System.IO.File.WriteAllText("text/Position" + Time.time + ".txt", screenPos.ToString());
}