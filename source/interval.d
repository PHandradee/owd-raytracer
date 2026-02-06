module interval;


struct Interval {
    double min;
    double max;

    this(double min, double max) {
        this.min = min;
        this.max = max;
    }

    double size() const {
        return max - min;
    }

    bool contains(double x) const {
        return min <= x && x <= max;
    }

    bool surrounds(double x) const {
        return min < x && x < max;
    }

    double clamp(double x) const {
        if (x < min) return min;
        if (x > max) return max;
        return x;
    }
    
    static immutable empty = Interval(double.infinity, -double.infinity);
    static immutable universe = Interval(-double.infinity, double.infinity);
}
