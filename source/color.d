module color;
import vec3;
import std.conv;
import std.stdio;
import interval;

alias Color = Vec3;

void write_color(ref const Color pixel_color) {
    immutable auto r = pixel_color.x;
    immutable auto g = pixel_color.y;
    immutable auto b = pixel_color.z;

    static immutable Interval intensity = Interval(0.000,0.999);
    immutable auto rbyte = to!int(256 * intensity.clamp(r));
    immutable auto gbyte = to!int(256 * intensity.clamp(g));
    immutable auto bbyte = to!int(256 * intensity.clamp(b));

    writeln(rbyte, ' ', gbyte, ' ', bbyte);
}
