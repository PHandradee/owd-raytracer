module hittable;

import ray;
import vec3;
import interval;

struct HitRecord {
    Point3 p;
    Vec3 normal;
    double t;
    bool front_face;

    void set_face_normal(const ref Ray r, const ref Vec3 outward_normal) {
        front_face = dot(r.direction(),outward_normal) < 0;
        normal = front_face ? outward_normal : -outward_normal;
    }
    
}

interface Hittable {
    bool hit(const ref Ray ray, Interval ray_t, ref HitRecord rec) const;
}
