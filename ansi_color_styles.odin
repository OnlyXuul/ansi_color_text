package ansi_color

/*********************************************************
 * Pre-defined themes for 24 bit (RGB) color printing
 *********************************************************/

// An attempt to create a uniform color structure for easy theme switching
// Not exactly a 1-to-1 proposition for some themes
Color_Theme :: struct {
	red:     RGB,
	yellow:  RGB,
	orange:  RGB,
	green:   RGB,
	cyan:    RGB,
	blue:    RGB,
	pink:    RGB,
	purple:  RGB,
	brown:   RGB,
	black:   RGB,
	grey:    RGB,
	white:   RGB,
}

// Atom One Dark
// https://www.color-hex.com/color-palette/1017619
// https://www.color-hex.com/color-palette/1017620
// https://www.color-hex.com/color-palette/85269
Atom_One_Dark :: Color_Theme {
	red    = {224, 108, 117},
	yellow = {229, 192, 123},
	orange = {190, 138,  89},
	green  = {152, 195, 121},
	cyan   = {86,  182, 194},
	blue   = {97,  175, 239},
	pink   = {193, 152, 193},
	purple = {198, 120, 221},
	brown  = {193, 154, 107},
	black  = {40,   44,  52},
	grey   = {171, 178, 191},
	white  = {242, 244, 245},
}

// Dracula
// https://en.wikipedia.org/wiki/Dracula_(color_scheme)
Drakula :: Color_Theme {
	red    = {255,  85,  85},
	yellow = {241, 250, 140},
	orange = {255, 184, 108},
	green  = {80,  250, 123},
	cyan   = {139, 233, 253},
	blue   = {98,  114, 164},
	pink   = {255, 121, 198},
	purple = {189, 147, 249},
	brown  = {139,  69,  19},
	black  = {40,   42,  54},
	grey   = {68,   71,  90},
	white  = {248, 248, 242},
}
