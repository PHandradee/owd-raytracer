import std.stdio;
import std.conv;
import std.logger;

import vec3;
import color;

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
			immutable Color pixel_color = Color(to!double(i)/(image_width-1)
									,to!double(j)/(image_heigth-1),0);
			write_color(pixel_color);

		}
	}
	trace(true,"Done!");
}
