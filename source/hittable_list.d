module hittable_list;

import hittable;
import std.range;
import std.algorithm;
import ray;

class HittableList : Hittable {
    Hittable[] objects;

    void clear() {
        objects = objects.init;
    }

    void add(Hittable object) {
        objects ~= object;
    }

    bool hit(const ref Ray ray, double ray_tmin, double ray_tmax, ref HitRecord rec) const {
        HitRecord temp_rec;
        bool hit_anything = false;
        auto closest_so_far = ray_tmax;

        foreach (const Hittable object; objects) {
            if (object.hit(ray, ray_tmin, closest_so_far, temp_rec)) {
                hit_anything = true;
                closest_so_far = temp_rec.t;
                rec = temp_rec;
            }
        }

        return hit_anything;
    }
}