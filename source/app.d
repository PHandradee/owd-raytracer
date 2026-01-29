import std.stdio;
import std.conv;
import std.logger;

void main()
{
	//image 

	enum int image_width = 256;
	enum int image_heigth = 256;


	//render

	stdout.writeln("P3");
	stdout.writeln(image_width, ' ', image_heigth, "\n255");

	for (int j = 0; j < image_heigth; j++) {
		trace(true,"Scanlines remaining: ", (image_heigth - j));
		for (int i = 0; i < image_width; i++) {
			immutable double r = to!double(i) / (image_width-1);
			immutable double g = to!double(j) / (image_heigth-1);
			immutable double b = 0.0; 

			int ir = to!int(255.999 * r);
			int ig = to!int(255.999 * g);
			int ib = to!int(255.999 * b);

			stdout.writeln(ir, ' ', ig, ' ', ib);
		}
	}
	trace(true,"Done!");
}
