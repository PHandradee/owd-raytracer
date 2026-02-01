import std.stdio;
import std.conv;
import std.logger;

import vec3;
import color;
import ray;

void main() {
	//image 

	auto aspect_ratio = 16.0 / 9.0;
	int image_width = 400;

	int image_height = to!int(image_width / aspect_ratio);
	image_height = (image_height < 1) ? 1 : image_height;

	//Camera
	auto focal_length = 1.0;
	auto viewport_height = 2.0;
	auto viewport_width = viewport_height * (to!double(image_width) / image_height);
	auto camera_center = Point3.init;

	// Calculate the vectors across the horizontal and down the vertical viewport edges.
	auto viewport_u = Vec3(viewport_width, 0, 0);
	auto viewport_v = Vec3(0, -viewport_height, 0);

	// Calculate the horizontal and vertical delta vectors from pixel to pixel.
	auto pixel_delta_u = viewport_u / image_width;
	auto pixel_delta_v = viewport_v / image_height;

	// Calculate the location of the upper left pixel.
	auto viewport_upper_left = camera_center - Vec3(0, 0, focal_length) - viewport_u / 2 - viewport_v / 2;
	auto pixel00_loc = viewport_upper_left + 0.5 * (pixel_delta_u + pixel_delta_v);

	//render

	stdout.writeln("P3");
	stdout.writeln(image_width, ' ', image_height, "\n255");

	for (int j = 0; j < image_height; j++) {
		trace(true, "Scanlines remaining: ", (image_height - j));
		for (int i = 0; i < image_width; i++) {
			auto pixel_center = pixel00_loc + (i * pixel_delta_u) + (j * pixel_delta_v);
			auto ray_direction = pixel_center - camera_center;
			Ray r = Ray(camera_center, ray_direction);

			immutable Color pixel_color = ray_color(r);
			write_color(pixel_color);

		}
	}
	trace(true, "Done!");
}

Color ray_color(ref const Ray r) {
	Point3 sphere_center = Point3(0,0,-1);
	if (hit_sphere(sphere_center, 0.5, r)) {
		return Color(1, 0, 0);
	}

	Vec3 unit_direction = unitVector(r.direction);
	auto a = 0.5 * (unit_direction.y + 1.0);
	return (1.0 - a) * Color(1, 1, 1) + a * Color(0.5, 0.7, 1.0);
}

bool hit_sphere(const ref Point3 center, double radius, const ref Ray r) {
	Vec3 oc = center - r.origin;
	immutable auto a = dot(r.direction, r.direction);
	immutable auto b = -2.0 * dot(r.direction, oc);
	immutable auto c = dot(oc, oc) - radius * radius;
	immutable discriminant = b * b - 4 * a * c;
	return (discriminant >= 0);
}
