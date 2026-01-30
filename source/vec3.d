module vec3;

import std.math : sqrt;
import std.format : formatValue;
import std.traits : isFloatingPoint;

struct Vec3
{
    double[3] e = 0;

    this(double x, double y, double z)
    {
        e[0] = x;
        e[1] = y;
        e[2] = z;
    }

    @property double x() const
    {
        return e[0];
    }

    @property double y() const
    {
        return e[1];
    }

    @property double z() const
    {
        return e[2];
    }

    Vec3 opUnary(string op)() const if (op == "-")
    {
        return Vec3(-e[0], -e[1], -e[2]);
    }

    ref double opIndex(size_t i)
    {
        return e[i];
    }

    double opIndex(size_t i) const
    {
        return e[i];
    }

    void opIndexAssign(T)(T value, size_t i)
    {
        e[i] = value;
    }

    Vec3 opBinary(string op)(Vec3 rhs) const
    {
        static if (op == "+")
            return Vec3(e[0] + rhs.e[0], e[1] + rhs.e[1], e[2] + rhs.e[2]);
        else static if (op == "-")
            return Vec3(e[0] - rhs.e[0], e[1] - rhs.e[1], e[2] - rhs.e[2]);
        else static if (op == "*")
            return Vec3(e[0] * rhs.e[0], e[1] * rhs.e[1], e[2] * rhs.e[2]);
        else
            static assert(0, "Operator " ~ op ~ " not supported for Vec3");
    }

    Vec3 opBinaryRight(string op, T)(T s) const
    if (op == "*" && isFloatingPoint!T)
    {
        return Vec3(s * e[0], s * e[1], s * e[2]);
    }

    Vec3 opBinary(string op, T)(T s) const
    if (op == "*" && isFloatingPoint!T)
    {
        return Vec3(e[0] * s, e[1] * s, e[2] * s);
    }

    Vec3 opBinary(string op, T)(T s) const
    if (op == "/" && isFloatingPoint!T)
    {
        return (1.0 / s) * this;
    }

    Vec3 opOpAssign(string op)(Vec3 rhs) if (op == "+")
    {
        e[] += rhs.e[];
        return this;
    }

    Vec3 opOpAssign(string op, T)(T t) if (op == "*" && isFloatingPoint!T)
    {
        e[] *= t;
        return this;
    }

    Vec3 opOpAssign(string op, T)(T t) if (op == "/" && isFloatingPoint!T)
    {
        return opOpAssign!"*"(1.0 / t);
    }

    @property double length() const
    {
        return sqrt(lengthSquared);
    }

    @property double lengthSquared() const
    {
        return e[0] * e[0] + e[1] * e[1] + e[2] * e[2];
    }
}

alias Point3 = Vec3;

double dot(Vec3 a, Vec3 b)
{
    return a.e[0] * b.e[0] + a.e[1] * b.e[1] + a.e[2] * b.e[2];
}

Vec3 cross(Vec3 a, Vec3 b)
{
    return Vec3(
        a.e[1] * b.e[2] - a.e[2] * b.e[1],
        a.e[2] * b.e[0] - a.e[0] * b.e[2],
        a.e[0] * b.e[1] - a.e[1] * b.e[0]
    );
}

Vec3 unitVector(Vec3 v)
{
    return v / v.length;
}

void formatValue(Writer)(ref Writer w, Vec3 v, ref const FormatSpec!char f)
{
    import std.format : formattedWrite;

    formattedWrite(w, f, "%g %g %g", v.e[0], v.e[1], v.e[2]);
}
