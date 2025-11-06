package ansi_color

/***********************************************************
 * Print testing stuff
 ***********************************************************/

Print_Format :: struct {
	title:      ANSI_Format,
	col_header: ANSI_Format,
	row_header: ANSI_Format,
	data:       ANSI_Format,
	notes:      ANSI_Format,
	error:      ANSI_Format,
	warning:    ANSI_Format,
	highlight:  ANSI_Format,
	inverted:   ANSI_Format,
	no_sgr:     ANSI_Format,
}

print_format_init :: proc($T: typeid, theme := Color_Theme {}) -> (print_format: Print_Format)
where T == ANSI_3Bit || T == ANSI_4Bit || T == ANSI_8Bit || T == ANSI_24Bit || T == ANSI_Format {
	switch typeid_of(T) {
		case ANSI_3Bit:
			print_format = {
				title      = ANSI_3Bit{fg = .FG_BLUE, att = {.BOLD, .OVERLINED}},
				col_header = ANSI_3Bit{fg = .FG_CYAN, att = {.UNDERLINE}},
				row_header = ANSI_3Bit{fg = .FG_GREEN},
				data       = ANSI_3Bit{fg = .FG_BLUE},
				notes      = ANSI_3Bit{fg = .FG_BLUE, att = {.FAINT, .ITALIC}},
				error      = ANSI_3Bit{fg = .FG_RED},
				warning    = ANSI_3Bit{fg = .FG_YELLOW},
				highlight  = ANSI_3Bit{fg = .FG_BLACK, bg = .BG_MAGENTA},
				inverted   = ANSI_3Bit{fg = .FG_BLACK, bg = .BG_MAGENTA, att = {.INVERT}},
			}
		case ANSI_4Bit:
			print_format = {
				title      = ANSI_4Bit{fg = .FG_BRIGHT_BLUE, att = {.BOLD, .OVERLINED}},
				col_header = ANSI_4Bit{fg = .FG_BRIGHT_CYAN, att = {.UNDERLINE}},
				row_header = ANSI_4Bit{fg = .FG_BRIGHT_GREEN},
				data       = ANSI_4Bit{fg = .FG_BRIGHT_BLUE},
				notes      = ANSI_4Bit{fg = .FG_BRIGHT_BLUE, att = {.FAINT, .ITALIC}},
				error      = ANSI_4Bit{fg = .FG_BRIGHT_RED},
				warning    = ANSI_4Bit{fg = .FG_BRIGHT_YELLOW},
				highlight  = ANSI_4Bit{fg = .FG_BRIGHT_BLACK, bg = .BG_BRIGHT_MAGENTA},
				inverted   = ANSI_4Bit{fg = .FG_BRIGHT_BLACK, bg = .BG_BRIGHT_MAGENTA, att = {.INVERT}},
			}
		case ANSI_8Bit:
			print_format = {
				title      = ANSI_8Bit{fg = 33, att = {.BOLD, .OVERLINED}},
				col_header = ANSI_8Bit{fg = 14, att = {.UNDERLINE}},
				row_header = ANSI_8Bit{fg = 118},
				data       = ANSI_8Bit{fg = 33},
				notes      = ANSI_8Bit{fg = 33, att = {.FAINT, .ITALIC}},
				error      = ANSI_8Bit{fg = 196},
				warning    = ANSI_8Bit{fg = 226},
				highlight  = ANSI_8Bit{fg = 234, bg = 141},
				inverted   = ANSI_8Bit{fg = 234, bg = 141, att = {.INVERT}},
			}
		case ANSI_24Bit:
			print_format = {
				title      = ANSI_24Bit{fg = theme.blue, att = {.BOLD, .OVERLINED}},
				col_header = ANSI_24Bit{fg = theme.cyan, att = {.UNDERLINE}},
				row_header = ANSI_24Bit{fg = theme.green},
				data       = ANSI_24Bit{fg = theme.blue},
				notes      = ANSI_24Bit{fg = theme.blue, att = {.FAINT, .ITALIC}},
				error      = ANSI_24Bit{fg = theme.red},
				warning    = ANSI_24Bit{fg = theme.yellow},
				highlight  = ANSI_24Bit{fg = theme.black, bg = theme.magenta},
				inverted   = ANSI_24Bit{fg = theme.black, bg = theme.magenta, att = {.INVERT}},
			}
	}
	return
}

test_print :: proc(info: string, pf: Print_Format) {
	printfcln(pf.no_sgr, "")
	printfcln(pf.title,    "%s%s%s",  "Testing ", info, " ansi printing")
	printfcln(pf.title,    "%*s", 22 + len(info)," ")
	printfc(pf.col_header, "%s", "Test"); printfc(pf.no_sgr, "%-7s", ""); printfcln(pf.col_header, "%s", "Output")
	printfc(pf.row_header, "%-11s", "No SGR:"); printfcln(pf.no_sgr, "No color or attributes set.")
	printfc(pf.row_header, "%-11s", "Error:"); printfcln(pf.error, "Error text.")
	printfc(pf.row_header, "%-11s", "Warning:"); printfcln(pf.warning, "Warning text.")
	printfc(pf.row_header, "%-11s", "Data:"); printfcln(pf.data, "Data text.")
	printfc(pf.row_header, "%-11s", "Notes:"); printfcln(pf.notes, "Notes text.")
	printfc(pf.row_header, "%-11s", "Highlight:"); printfcln(pf.highlight, "Highlighted text.")
	printfc(pf.row_header, "%-11s", "Inverted:"); printfcln(pf.inverted, "Inverted highlighted text.")
}

main :: proc() {
	print_format: Print_Format

	print_format = print_format_init(ANSI_3Bit)
	test_print("3Bit", print_format)

	print_format = print_format_init(ANSI_4Bit)
	test_print("4Bit", print_format)

	print_format = print_format_init(ANSI_8Bit)
	test_print("8Bit", print_format)

	print_format = print_format_init(ANSI_Format)
	test_print("nil ANSI_Format union turns off", print_format)

	print_format = print_format_init(ANSI_24Bit, Theme[.Atom_One_Dark])
	test_print("24Bit - Atom One Dark Theme", print_format)
	printfcln({}, "")
	print_theme_info(Theme[.Atom_One_Dark])

	print_format = print_format_init(ANSI_24Bit, Theme[.Dracula])
	test_print("24Bit - Drakula Theme", print_format)
	printfcln({}, "")
	print_theme_info(Theme[.Dracula])

	printfcln({}, "")

	odin := ANSI_24Bit{fg = Theme[.Dracula].magenta, att = {.UNDERLINE}}
	printfcln(odin, "%s", "https://forum.odin-lang.org")

	xuul := ANSI_24Bit{fg = Theme[.Dracula].magenta, att = {.UNDERLINE}}
	printfcln(xuul, "%s", "https://github.com/OnlyXuul/")
	printfcln(xuul, "%s", "https://gitlab.com/xuul/")

	printfcln({}, "")
	for t, i in Theme {
		printfcln(xuul, "%s", t.name)
	}
	// if running in a loop or executing often in a long running program,
	// periodically clear the context.temp_allocator either at the end of the loop,
	// or when appropriate.
	free_all(context.temp_allocator)
}
