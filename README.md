# Ray Tracing in One Weekend – D Language Implementation

This project is a **from-scratch implementation** of the book **[Ray Tracing in One Weekend](https://raytracing.github.io/books/RayTracingInOneWeekend.html)**, written in the **D programming language**.

The main goals of this project are to learn and explore:

* Ray tracing fundamentals
* The math behind rendering (vectors, rays, intersections)
* How a simple renderer is structured
* Practical usage of the **D language** in a graphics-oriented project

The project follows the book chapter by chapter, adapting the original C++ examples into a more idiomatic D style where possible.

---

## 📸 Output

The renderer generates images in the **PPM** format, exactly as presented in the book. This simple format makes it easier to understand the rendering pipeline without external dependencies.

---

## ⚙️ Requirements

* **DMD**, **LDC**, or **GDC**
* **Dub** (D package manager)

Check that Dub is installed:

```bash
dub --version
```

---

## ▶️ Build and Run

### Debug build

```bash
dub run
```

### Release build

```bash
dub run --build=release
```

The executable will be generated in:

```
bin/<debug|release>/
```

The program writes the rendered image to standard output. You can redirect it to a file:

```bash
dub run  > image.ppm
```

Then view the image using any PPM-compatible viewer or web versions like [PPMViewer](https://www.cs.rhodes.edu/welshc/COMP141_F16/ppmReader.html)

## 📚 Reference

* **Book:** Ray Tracing in One Weekend

  * [https://raytracing.github.io/books/RayTracingInOneWeekend.html](https://raytracing.github.io/books/RayTracingInOneWeekend.html)

All algorithmic concepts are credited to **Peter Shirley**. This project is an educational implementation.

---

## 🧠 Project Status

* [ ] Vectors and colors
* [ ] Rays
* [ ] Spheres
* [ ] Multiple objects
* [ ] Antialiasing
* [ ] Diffuse materials
* [ ] Metal and dielectric materials
* [ ] Camera and depth of field

> Items will be checked as chapters are completed.

---

## 📄 License

This project is licensed under the **MIT License**.

---

## ✍️ Author

**Pedro Henrique Andrade**
D language implementation based on *Ray Tracing in One Weekend*.

---
Readme file created using AI
