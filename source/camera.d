module camera;

import rtweekend;
import std.logger;
import std.stdio;
import interval;
import color;
import ray;
import hittable;
import vec3;
import hittable_list;
import std.conv;

struct Camera {
    private {
        int image_height; 
        Point3 center; 
        Point3 pixel00_loc; 
        Vec3 pixel_delta_u; 
        Vec3 pixel_delta_v; 

        void initialize() {
            image_height = to!int(image_width / aspect_ratio);
            image_height = (image_height < 1) ? 1 : image_height;


            center = Point3.init;
            // Determine viewport dimensions.
            auto focal_length = 1.0;
            auto viewport_height = 2.0;
            auto viewport_width = viewport_height * (to!double(image_width) / image_height);

            // Calculate the vectors across the horizontal and down the vertical viewport edges.
            auto viewport_u = Vec3(viewport_width, 0, 0);
            auto viewport_v = Vec3(0, -viewport_height, 0);

            // Calculate the horizontal and vertical delta vectors from pixel to pixel.
            pixel_delta_u = viewport_u / image_width;
            pixel_delta_v = viewport_v / image_height;

            // Calculate the location of the upper left pixel.
            auto viewport_upper_left = center - Vec3(0, 0, focal_length) - viewport_u / 2 - viewport_v / 2;
            pixel00_loc = viewport_upper_left + 0.5 * (pixel_delta_u + pixel_delta_v);
        }

        Color ray_color(const ref Ray r, const ref HittableList world) const {
            HitRecord rec;
            if (world.hit(r, Interval(0, INFINITY), rec)) {
                return 0.5 * (rec.normal + Color(1, 1, 1));
            }

            Vec3 unit_direction = unitVector(r.direction);
            auto a = 0.5 * (unit_direction.y + 1.0);
            return (1.0 - a) * Color(1, 1, 1) + a * Color(0.5, 0.7, 1.0);
        }
    }

    double aspect_ratio = 1.0; 
    int image_width = 100; 

    void render(const ref HittableList world) {
        initialize();
        stdout.writeln("P3");
        stdout.writeln(image_width, ' ', image_height, "\n255");

        for (int j = 0; j < image_height; j++) {
            trace(true, "Scanlines remaining: ", (image_height - j));
            for (int i = 0; i < image_width; i++) {
                auto pixel_center = pixel00_loc + (i * pixel_delta_u) + (j * pixel_delta_v);
                auto ray_direction = pixel_center - center;
                Ray r = Ray(center, ray_direction);

                immutable Color pixel_color = ray_color(r, world);
                write_color(pixel_color);

            }
        }
        trace(true, "Done!");
    }
}
