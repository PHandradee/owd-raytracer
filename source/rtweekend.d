module rtweekend;

import std.random;

enum double PI = 3.1415926535897932385;
enum double INFINITY = double.infinity;


double degrees_to_radians(double degrees) {
    return degrees * PI / 180.0;
}

double random_double() {
    return uniform(0.0,1.0);
}

double random_double(double min, double max) {
    return min + (max-min) * random_double();
}
