module hittable_list;

import hittable;
import std.range;
import std.algorithm;
import ray;
import interval;

class HittableList : Hittable {
    Hittable[] objects;

    void clear() {
        objects = objects.init;
    }

    void add(Hittable object) {
        objects ~= object;
    }

    bool hit(const ref Ray ray, Interval ray_t, ref HitRecord rec) const{
        HitRecord temp_rec;
        bool hit_anything = false;
        auto closest_so_far = ray_t.max;

        foreach (const Hittable object; objects) {
            if (object.hit(ray, Interval(ray_t.min,closest_so_far), temp_rec)) {
                hit_anything = true;
                closest_so_far = temp_rec.t;
                rec = temp_rec;
            }
        }

        return hit_anything;
    }
}