module sphere;

import hittable;
import vec3;
import std.math;
import ray;
import interval;

class Sphere : Hittable {
    private {
        Point3 center;
        double radius;
    }

    this(Point3 center, double radius) {
        this.center = center;
        this.radius = std.math.fmax(0, radius);
    }

    override bool hit(const ref Ray r, Interval ray_t, ref HitRecord rec) const{
        immutable Vec3 oc = center - r.origin;
        immutable auto a = r.direction().lengthSquared();
        immutable auto h = dot(r.direction(), oc);
        immutable auto c = oc.lengthSquared() - radius * radius;

        immutable auto discriminant = (h * h) - (a * c);
        if (discriminant < 0) {
            return false;
        }

        immutable auto sqrtd = std.math.sqrt(discriminant);

        double root = (h - sqrtd) / a;
        if (!ray_t.surrounds(root)) {
            root = (h + sqrtd) / a;
            if (!ray_t.surrounds(root)) {
                return false;
            }
        }

        rec.t = root;
        rec.p = r.at(rec.t);
        immutable Vec3 outward_normal = (rec.p - center) /radius;
        rec.set_face_normal(r, outward_normal);

        return true;

    }

}
