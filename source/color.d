module color;
import vec3;
import std.conv;
import std.stdio;

alias Color = Vec3;


void write_color(ref const Color pixel_color) {
    immutable auto r = pixel_color.x;
    immutable auto g = pixel_color.y;
    immutable auto b = pixel_color.z;

    immutable auto rbyte = to!int(255.999 * r);
    immutable auto gbyte = to!int(255.999 * g);
    immutable auto bbyte = to!int(255.999 * b);

    writeln(rbyte, ' ', gbyte, ' ', bbyte);
}