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
        double pixel_samples_scale;

        void initialize() {
            image_height = to!int(image_width / aspect_ratio);
            image_height = (image_height < 1) ? 1 : image_height;

            pixel_samples_scale = 1.0 / samples_per_pixel;

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

        Ray get_ray(int i, int j) const {
            immutable auto offset = sample_square();
            immutable auto pixel_sample = pixel00_loc
                + (
                    (i + offset.x()) * pixel_delta_u)
                + ((j + offset.y()) * pixel_delta_v);

            immutable auto ray_origin = center;
            immutable auto ray_direction = pixel_sample - ray_origin;

            return Ray(ray_origin, ray_direction);
        }

        Vec3 sample_square() const {
            return Vec3(random_double() - 0.5, random_double() - 0.5, 0);
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
    int samples_per_pixel = 10;

    void render(const ref HittableList world) {
        initialize();
        stdout.writeln("P3");
        stdout.writeln(image_width, ' ', image_height, "\n255");

        for (int j = 0; j < image_height; j++) {
            trace(true, "Scanlines remaining: ", (image_height - j));
            for (int i = 0; i < image_width; i++) {
                Color pixel_color = Color(0, 0, 0);
                for (int sample = 0; sample < samples_per_pixel; sample++) {
                    Ray r = get_ray(i, j);
                    pixel_color += ray_color(r, world);
                }
                Color c = Color(pixel_color * pixel_samples_scale);
                write_color(c);

            }
        }
        trace(true, "Done!");
    }
}
