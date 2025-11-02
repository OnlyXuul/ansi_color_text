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

test_print :: proc(type: string, tpf: Print_Format) {
	printfcln(tpf.title,    "\n%s%s%s",  "Testing ", type, " color printing")
	printfcln(tpf.title,    "%*s", 23 + len(type)," ")
	printfc(tpf.col_header, "%s", "Test"); printfc(tpf.no_sgr, "%-7s", ""); printfcln(tpf.col_header, "%s", "Output")
	printfc(tpf.row_header, "%-11s", "No SGR:"); printfcln(tpf.no_sgr, "No color or attributes set.")
	printfc(tpf.row_header, "%-11s", "Error:"); printfcln(tpf.error, "Error text.")
	printfc(tpf.row_header, "%-11s", "Warning:"); printfcln(tpf.warning, "Warning text.")
	printfc(tpf.row_header, "%-11s", "Data:"); printfcln(tpf.data, "Data text.")
	printfc(tpf.row_header, "%-11s", "Notes:"); printfcln(tpf.notes, "Notes text.")
	printfc(tpf.row_header, "%-11s", "Highlight:"); printfcln(tpf.highlight, "Highlighted text.")
	printfc(tpf.row_header, "%-11s", "Inverted:"); printfcln(tpf.inverted, "Inverted highlighted text.")
}

// To test switching out 24bit color themes
set_theme :: proc(theme: Color_Theme) -> (test_print_format: Print_Format) {
	test_print_format = {
		title      = ANSI_24Bit{fg = theme.blue, att = {.BOLD, .OVERLINED}},
		col_header = ANSI_24Bit{fg = theme.cyan, att = {.UNDERLINE}},
		row_header = ANSI_24Bit{fg = theme.green},
		data       = ANSI_24Bit{fg = theme.blue},
		notes      = ANSI_24Bit{fg = theme.blue, att = {.FAINT, .ITALIC}},
		error      = ANSI_24Bit{fg = theme.red},
		warning    = ANSI_24Bit{fg = theme.yellow},
		highlight  = ANSI_24Bit{fg = theme.purple, bg = theme.black},
		inverted   = ANSI_24Bit{fg = theme.purple, bg = theme.black, att = {.INVERT}},
	}
	return
}

main :: proc() {
	test_print_format: Print_Format

	test_print_format = {
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

	test_print("3Bit", test_print_format)

	test_print_format = {
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

	test_print("4Bit", test_print_format)

	test_print_format = {
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

	test_print("8Bit", test_print_format)

	test_print_format = set_theme(Atom_One_Dark)
	test_print("24Bit - Atom One Dark Theme", test_print_format)

	test_print_format = set_theme(Drakula)
	test_print("24Bit - Drakula Theme", test_print_format)

	printfcln(test_print_format.no_sgr, "")

	odin := ANSI_24Bit{fg = Drakula.pink, att = {.UNDERLINE}}
	printfcln(odin, "%s", "https://forum.odin-lang.org")

	xuul := ANSI_24Bit{fg = Drakula.pink, att = {.UNDERLINE}}
	printfcln(xuul, "%s", "https://github.com/OnlyXuul/")
	printfcln(xuul, "%s\n", "https://gitlab.com/xuul/")

	// if running in a loop or executing often in a long running program,
	// periodically clear the context.temp_allocator either at the end of the loop,
	// or when appropriate.
	free_all(context.temp_allocator)
}
