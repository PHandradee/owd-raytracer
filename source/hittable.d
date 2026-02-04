module hittable;

import ray;
import vec3;

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
    bool hit(const ref Ray ray, double ray_tmin, double ray_tmax, ref HitRecord rec) const;
}
