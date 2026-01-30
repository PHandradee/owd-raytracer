module ray;

import vec3;

struct Ray
{
    this()
    {
    }

    this(ref const Point3 origin, ref const Vec3 direction)
    {
        m_origin = origin;
        m_direction = direction;
    }

    @property origin() const
    {
        return m_origin;
    }

    @property direction() const
    {
        return m_direction;
    }

    Point3 at(double t) const
    {
        return m_origin + t * m_direction;
    }

    private
    {
        Point3 m_origin;
        Vec3 m_direction;
    }
}
