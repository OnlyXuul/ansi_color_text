package ansi_color

/*********************************************************
 * Pre-defined themes for 24 bit (RGB) color printing
 *********************************************************/

// Structure type for all themes to use
Color_Theme :: struct {
	name:    string,   // Theme name (no spaces)
	info:    []string, // Misc. info, credits, etc
	red:     RGB,
	green:   RGB,
	yellow:  RGB,
	blue:    RGB,
	magenta: RGB,
	cyan:    RGB,
	white:   RGB,
	black:   RGB,
	light:   struct {
		red:     RGB,
		green:   RGB,
		yellow:  RGB,
		blue:    RGB,
		magenta: RGB,
		cyan:    RGB,
		white:   RGB,
		black:   RGB,
	},
	dark:    struct {
		red:     RGB,
		green:   RGB,
		yellow:  RGB,
		blue:    RGB,
		magenta: RGB,
		cyan:    RGB,
		white:   RGB,
		black:   RGB,
	},
}

// Prints theme info - or just colors if colors_only = true
print_theme_info :: proc(t: Color_Theme, colors_only := false) {
	print :: proc(rgb: RGB) {
		a := ANSI_24Bit{fg = rgb}
		printfc(a, "%-4s", "█")
	}
	if !colors_only {
		printfcln({}, "%s", t.name)
		for i in t.info do printfcln({}, "%s", i)
			printfcln({}, "")
			printfcln({}, "%-16s%-16s%s", "Base Color Set", "Light Color Set", "Dark Color Set")
	}
	print(t.red);  print(t.green);   print(t.yellow); print(t.blue)
	print(t.magenta); print(t.cyan); print(t.white);  print(t.black)

	print(t.light.red);  print(t.light.green);   print(t.light.yellow); print(t.light.blue)
	print(t.light.magenta); print(t.light.cyan); print(t.light.white);  print(t.light.black)

	print(t.dark.red);  print(t.dark.green);   print(t.dark.yellow); print(t.dark.blue)
	print(t.dark.magenta); print(t.dark.cyan); print(t.dark.white); print(t.dark.black)
	printfcln({}, "")
}

// Theme IDs for indexing
Theme_ID :: enum {
	Atom_One_Dark,
	Dracula,
}

// Theme definitions
Theme :: [Theme_ID]Color_Theme {
	.Atom_One_Dark = {
		name = "Atom_One_Dark",
		info = {
			"https://github.com/atom",
			"https://www.color-hex.com/color-palette/1017619",
			"Light and Dark sets added by xuul",
			"https://github.com/OnlyXuul/",
			"https://gitlab.com/xuul/",
		},
		red     = {224, 108, 117},
		green   = {152, 195, 121},
		yellow  = {229, 192, 123},
		blue    = {97,  175, 239},
		magenta = {198, 120, 221},
		cyan    = {86,  182, 194},
		white   = {242, 244, 245},
		black   = {40,   44,  52},
		light   = {
			red     = {244, 118, 128},
			green   = {169, 215, 133},
			yellow  = {249, 209, 134},
			blue    = {103, 187, 255},
			magenta = {215, 130, 241},
			cyan    = {95,  202, 214},
			white   = {252, 254, 255},
			black   = {55,   61,  72},
		},
		dark    = {
			red     = {204,  98, 107},
			green   = {137, 175, 108},
			yellow  = {209, 175, 112},
			blue    = {88,  160, 219},
			magenta = {179, 109, 201},
			cyan    = {77,  164, 174},
			white   = {222, 224, 225},
			black   = {25,   27,  32},
		},
	},
	.Dracula = {
		name = "Dracula",
		info = {
			"https://en.wikipedia.org/wiki/Dracula_(color_scheme)",
			"Light and Dark sets added by xuul",
			"https://github.com/OnlyXuul/",
			"https://gitlab.com/xuul/",
		},
		red     = {255,  85,  85},
		green   = {80,  250, 123},
		yellow  = {241, 250, 140},
		blue    = {98,  114, 164},
		magenta = {255, 121, 198},
		cyan    = {139, 233, 253},
		white   = {248, 248, 242},
		black   = {40,   42,  54},
		light   = {
			red     = {255, 105, 105},
			green   = {97,  255, 137},
			yellow  = {249, 255, 158},
			blue    = {110, 128, 184},
			magenta = {255, 141, 208},
			cyan    = {158, 239, 255},
			white   = {255, 255, 255},
			black   = {68,   71,  90},
		},
		dark    = {
			red     = {235,  78,  78},
			green   = {74,  230, 113},
			yellow  = {255, 184, 108},
			blue    = {86,  100, 144},
			magenta = {189, 147, 249},
			cyan    = {128, 215, 233},
			white   = {228, 228, 223},
			black   = {25,   27,  34},
		},
	},
}
