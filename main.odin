package ansi_color

/***********************************************************
 * Constants for testing
 ***********************************************************/

test_heading :: ANSI_3Bit{fg = .FG_BLUE, att = {.OVERLINED}}

nocolor_3bit :: ANSI_3Bit{}
hello_3bit   :: ANSI_3Bit{fg = .FG_GREEN}
world_3bit   :: ANSI_3Bit{fg = .FG_CYAN}
error_3bit   :: ANSI_3Bit{fg = .FG_RED}
warning_3bit :: ANSI_3Bit{fg = .FG_YELLOW}
heading_3bit :: ANSI_3Bit{fg = .FG_BLACK, bg = .BG_GREEN, att = {.UNDERLINE, .ITALIC}}

nocolor_4bit :: ANSI_4Bit{}
hello_4bit   :: ANSI_4Bit{fg = .FG_BRIGHT_GREEN}
world_4bit   :: ANSI_4Bit{fg = .FG_BRIGHT_CYAN}
error_4bit   :: ANSI_4Bit{fg = .FG_BRIGHT_RED}
warning_4bit :: ANSI_4Bit{fg = .FG_BRIGHT_YELLOW}
heading_4bit :: ANSI_4Bit{fg = .FG_BRIGHT_BLACK, bg = .BG_BRIGHT_GREEN, att = {.UNDERLINE, .ITALIC}}

nocolor_8bit :: ANSI_8Bit{}
hello_8bit   :: ANSI_8Bit{fg = 118}
world_8bit   :: ANSI_8Bit{fg = 51}
error_8bit   :: ANSI_8Bit{fg = 196}
warning_8bit :: ANSI_8Bit{fg = 226}
heading_8bit :: ANSI_8Bit{fg = 16, bg = 107, att = {.UNDERLINE, .ITALIC}}

nocolor_24bit :: ANSI_24Bit{}
hello_24bit   :: ANSI_24Bit{fg = {20, 250, 20}}
world_24bit   :: ANSI_24Bit{fg = {20, 250, 250}}
error_24bit   :: ANSI_24Bit{fg = {240, 75, 75}}
warning_24bit :: ANSI_24Bit{fg = {220, 230, 20}}
heading_24bit :: ANSI_24Bit{fg = {0, 0, 0}, bg = {135, 175, 95}, att = {.UNDERLINE, .ITALIC}}

odin :: ANSI_4Bit{fg = .FG_BRIGHT_BLUE, att = {.UNDERLINE}}

main :: proc() {
	printfcln(test_heading, "\n%s",  "Testing 3bit color printing")
	printfcln(test_heading, "%s",    "                           ")
	printfcln(nocolor_3bit, "%s",    "This tests no color. i.e. nil")
	printfc(hello_3bit,     "%-15s", "hellope")
	printfcln(world_3bit,   "%s",    "world!")
	printfcln(error_3bit,   "%s",    "This test what I might use for an error.")
	printfcln(warning_3bit, "%s",    "This tests what I might use for a warning")
	printfcln(heading_3bit, "%s",    "Testing a sudo heading with fg and bg and 2 attributes?")

	printfcln(test_heading, "\n%s",  "Testing 4bit color printing")
	printfcln(test_heading, "%s",    "                           ")
	printfcln(nocolor_4bit, "%s",    "This tests no color. i.e. nil")
	printfc(hello_4bit,     "%-15s", "hellope")
	printfcln(world_4bit,   "%s",    "world!")
	printfcln(error_4bit,   "%s",    "This test what I might use for an error.")
	printfcln(warning_4bit, "%s",    "This tests what I might use for a warning")
	printfcln(heading_4bit, "%s",    "Testing a sudo heading with fg and bg and 2 attributes?")

	printfcln(test_heading, "\n%s",  "Testing 8bit color printing")
	printfcln(test_heading, "%s",    "                           ")
	printfcln(nocolor_8bit, "%s",    "This tests no color. i.e. nil")
	printfc(hello_8bit,     "%-15s", "hellope")
	printfcln(world_8bit,   "%s",    "world!")
	printfcln(error_8bit,   "%s",    "This test what I might use for an error.")
	printfcln(warning_8bit, "%s",    "This tests what I might use for a warning")
	printfcln(heading_8bit, "%s",    "Testing a sudo heading with fg and bg and 2 attributes?")

	printfcln(test_heading,  "\n%s",  "Testing 24bit color printing")
	printfcln(test_heading,  "%s",    "                            ")
	printfcln(nocolor_24bit, "%s",    "This tests no color. i.e. nil")
	printfc(hello_24bit,     "%-15s", "hellope")
	printfcln(world_24bit,   "%s",    "world!")
	printfcln(error_24bit,   "%s",    "This test what I might use for an error.")
	printfcln(warning_24bit, "%s",    "This tests what I might use for a warning")
	printfcln(heading_24bit, "%s",    "Testing a sudo heading with fg and bg and 2 attributes?")

	printfcln(odin, "\n%s\n", "https://forum.odin-lang.org")

	// if running in a loop or executing often in a long running program,
	// periodically clear the context.temp_allocator either at the end of the loop,
	// or when appropriate.
	free_all(context.temp_allocator)
}
