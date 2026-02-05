
import hittable_list;
import sphere;
import camera;
import vec3;

void main() {
	HittableList world = new HittableList();

	world.add(new Sphere(Point3(0, 0, -1), 0.5));
	world.add(new Sphere(Point3(0, -100.5, -1), 100));

	Camera cam;
	cam.aspect_ratio = 16.0/9.0;
	cam.image_width = 400;

	cam.render(world);

}

