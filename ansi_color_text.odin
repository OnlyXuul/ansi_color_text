package ansi_color_text

import "core:fmt"
import "core:terminal"
import ansi "core:terminal/ansi"

/**************************************************************************************************
 * ANSI Color library that supports 3bit, 4bit, 8bit, and 24bit (TrueColor) printing to terminal.
 *
 * Use either overloaded procedures or their respective procedures.
 *
 * Overloads:
 * printfc
 * printflnc
 *
 * Respective procedures:
 * printf_c3, printf_c4, printf_c8, printf_c24
 * printfln_c3, printfln_c4, printfln_c8, printfln_c24
 *
 * Hyperlinks not implimented since most terminals are late to adopt
 * or have it disabled by default. In those terminals, URL detection is supported,
 * so support for OSC 8 is really moot. Here's an example though:
 * fmt.printfln("%s%s%s%s%s", OSC + HYPERLINK + ";;", "https://forum.odin-lang.org/", ST, "Click Me", OSC + HYPERLINK + ";;" + ST)
***************************************************************************************************/

// Used by all color formats.
// No way to test for these except to just try them in your terminal.
Attribute :: enum u8 {
	BOLD                    = 1,
	FAINT                   = 2,
	ITALIC                  = 3, // Not widely supported.
	UNDERLINE               = 4,
	BLINK_SLOW              = 5,
	BLINK_RAPID             = 6, // Not widely supported.
	INVERT                  = 7, // Also known as reverse video.
	HIDE                    = 8, // Not widely supported.
	STRIKE                  = 9,
	UNDERLINE_DOUBLE        = 21, // May be interpreted as "disable bold."
	NO_BOLD_FAINT           = 22,
	NO_ITALIC_BLACKLETTER   = 23,
	NO_UNDERLINE            = 24,
	NO_BLINK                = 25,
	PROPORTIONAL_SPACING    = 26,
	NO_REVERSE              = 27,
	NO_HIDE                 = 28,
	NO_STRIKE               = 29,
	NO_PROPORTIONAL_SPACING = 50,
	FRAMED                  = 51,
	ENCIRCLED               = 52,
	OVERLINED               = 53,
	NO_FRAME_ENCIRCLE       = 54,
	NO_OVERLINE             = 55,
}

/***********************************************************
 * Function overloads
 ***********************************************************/

printfc   :: proc {printf_c3, printf_c4, printf_c8, printf_c24}
printflnc :: proc {printfln_c3, printfln_c4, printfln_c8, printfln_c24}

/***********************************************************
 *	3 Bit Color Printing - 8 colors
 * Colors will be converted if the console is using a theme
 ***********************************************************/

FG_Color_3Bit :: enum u8 {
	NONE       = 0,
	FG_BLACK   = 30,
	FG_RED     = 31,
	FG_GREEN   = 32,
	FG_YELLOW  = 33,
	FG_BLUE    = 34,
	FG_MAGENTA = 35,
	FG_CYAN    = 36,
	FG_WHITE   = 37,
}

BG_Color_3Bit :: enum u8 {
	NONE       = 0,
	BG_BLACK   = 40,
	BG_RED     = 41,
	BG_GREEN   = 42,
	BG_YELLOW  = 43,
	BG_BLUE    = 44,
	BG_MAGENTA = 45,
	BG_CYAN    = 46,
	BG_WHITE   = 47,
}

ANSI_3Bit :: struct {
	fg:  FG_Color_3Bit,
	bg:  BG_Color_3Bit,
	att: bit_set[Attribute],
}

// print colored text
printf_c3 :: proc(ansi_format: ANSI_3Bit, printf_format: string, args: ..any) {
	print_color_3bit(ansi_format, printf_format, ..args, newline = false)
}

printfln_c3 :: proc(ansi_format: ANSI_3Bit, printf_format: string, args: ..any) {
	print_color_3bit(ansi_format, printf_format, ..args, newline = true)
}

// Wrap printf_format string with ANSI and then pass to printf.
// Use either printf_c3 or printfln_c3 instead of this. It is internal.
print_color_3bit :: proc(ansi_format: ANSI_3Bit, printf_format: string, args: ..any, newline := false) {
	using terminal
	using ansi
	using fmt

	pformat: string

	if (ansi_format.fg != .NONE || ansi_format.bg != .NONE || card(ansi_format.att) != 0) && color_enabled && color_depth >= .Three_Bit {

		pformat = CSI + RESET

		for att in ansi_format.att {
			pformat = tprintf("%s%s%i", pformat, ";", att)
		}

		if ansi_format.fg != .NONE {
			pformat = tprintf("%s%s%i", pformat, ";" + FG_COLOR + ";", ansi_format.fg)
		}

		if ansi_format.bg != .NONE {
			pformat = tprintf("%s%s%i", pformat, ";" + BG_COLOR + ";", ansi_format.bg)
		}

		pformat = tprintf("%s%s%s%s", pformat, SGR, printf_format, CSI + RESET + SGR)
	}
	else {
		pformat = printf_format
	}

	printf(pformat, ..args)
	if newline { println() }
}

/***********************************************************
 * 4 Bit Color Printing - 16 colors
 * Colors will be converted if the console is using a theme
 ***********************************************************/

FG_Color_4Bit :: enum u8 {
	NONE              = 0,
	FG_BLACK          = 30,
	FG_RED            = 31,
	FG_GREEN          = 32,
	FG_YELLOW         = 33,
	FG_BLUE           = 34,
	FG_MAGENTA        = 35,
	FG_CYAN           = 36,
	FG_WHITE          = 37,
	FG_BRIGHT_BLACK   = 90, // Also known as grey.
	FG_BRIGHT_RED     = 91,
	FG_BRIGHT_GREEN   = 92,
	FG_BRIGHT_YELLOW  = 93,
	FG_BRIGHT_BLUE    = 94,
	FG_BRIGHT_MAGENTA = 95,
	FG_BRIGHT_CYAN    = 96,
	FG_BRIGHT_WHITE   = 97,
}

BG_Color_4Bit :: enum u8 {
	NONE              = 0,
	BG_BLACK          = 40,
	BG_RED            = 41,
	BG_GREEN          = 42,
	BG_YELLOW         = 43,
	BG_BLUE           = 44,
	BG_MAGENTA        = 45,
	BG_CYAN           = 46,
	BG_WHITE          = 47,
	BG_BRIGHT_BLACK   = 100, // Also known as grey.
	BG_BRIGHT_RED     = 101,
	BG_BRIGHT_GREEN   = 102,
	BG_BRIGHT_YELLOW  = 103,
	BG_BRIGHT_BLUE    = 104,
	BG_BRIGHT_MAGENTA = 105,
	BG_BRIGHT_CYAN    = 106,
	BG_BRIGHT_WHITE   = 107,
}

ANSI_4Bit :: struct {
	fg:  FG_Color_4Bit,
	bg:  BG_Color_4Bit,
	att: bit_set[Attribute],
}

// print colored text
printf_c4 :: proc(ansi_format: ANSI_4Bit, printf_format: string, args: ..any) {
	print_color_4bit(ansi_format, printf_format, ..args, newline = false)
}

printfln_c4 :: proc(ansi_format: ANSI_4Bit, printf_format: string, args: ..any) {
	print_color_4bit(ansi_format, printf_format, ..args, newline = true)
}

// Wrap printf_format string with ANSI and then pass to printf.
// Use either printf_c4 or printfln_c4 instead of this. It is internal.
print_color_4bit :: proc(ansi_format: ANSI_4Bit, printf_format: string, args: ..any, newline := false) {
	using terminal
	using ansi
	using fmt

	pformat: string

	if (ansi_format.fg != .NONE || ansi_format.bg != .NONE || card(ansi_format.att) != 0) && color_enabled && color_depth >= .Four_Bit {

		pformat = CSI + RESET

		for att in ansi_format.att {
			pformat = tprintf("%s%s%i", pformat, ";", att)
		}

		if ansi_format.fg != .NONE {
			pformat = tprintf("%s%s%i", pformat, ";" + FG_COLOR + ";", ansi_format.fg)
		}

		if ansi_format.bg != .NONE {
			pformat = tprintf("%s%s%i", pformat, ";" + BG_COLOR + ";", ansi_format.bg)
		}

		pformat = tprintf("%s%s%s%s", pformat, SGR, printf_format, CSI + RESET + SGR)
	}
	else {
		pformat = printf_format
	}

	printf(pformat, ..args)
	if newline { println() }
}

/***********************************************************
 * 8 Bit Color Printing - 256 colors
 ***********************************************************/

ANSI_8Bit :: struct {
	fg:  Maybe(u8),
	bg:  Maybe(u8),
	att: bit_set[Attribute],
}

// print colored text
printf_c8 :: proc(ansi_format: ANSI_8Bit, printf_format: string, args: ..any) {
	print_color_8bit(ansi_format, printf_format, ..args, newline = false)
}

printfln_c8 :: proc(ansi_format: ANSI_8Bit, printf_format: string, args: ..any) {
	print_color_8bit(ansi_format, printf_format, ..args, newline = true)
}

// Wrap printf_format string with ANSI and then pass to printf.
// Use either printf_c8 or printfln_c8 instead of this. It is internal.
print_color_8bit :: proc(ansi_format: ANSI_8Bit, printf_format: string, args: ..any, newline := false) {
	using terminal
	using ansi
	using fmt

	pformat: string

	if (ansi_format.fg != nil || ansi_format.bg != nil || card(ansi_format.att) != 0) && color_enabled && color_depth >= .Eight_Bit {

		pformat = CSI + RESET

		for att in ansi_format.att {
			pformat = tprintf("%s%s%i", pformat, ";", att)
		}

		if ansi_format.fg != nil {
			pformat = tprintf("%s%s%i", pformat, ";" + FG_COLOR_8_BIT + ";", ansi_format.fg)
		}

		if ansi_format.bg != nil {
			pformat = tprintf("%s%s%i", pformat, ";" + BG_COLOR_8_BIT + ";", ansi_format.bg)
		}

		pformat = tprintf("%s%s%s%s", pformat, SGR, printf_format, CSI + RESET + SGR)
	}
	else {
		pformat = printf_format
	}

	printf(pformat, ..args)
	if newline { println() }
}

/***********************************************************
 * 24 Bit (TrueColor) Color Printing - 16.7 million colors
 ***********************************************************/

ANSI_24Bit :: struct {
	fg:  [3]Maybe(u8),
	bg:  [3]Maybe(u8),
	att: bit_set[Attribute],
}

// print colored text
printf_c24 :: proc(ansi_format: ANSI_24Bit, printf_format: string, args: ..any) {
	print_color_24bit(ansi_format, printf_format, ..args, newline = false)
}

printfln_c24 :: proc(ansi_format: ANSI_24Bit, printf_format: string, args: ..any) {
	print_color_24bit(ansi_format, printf_format, ..args, newline = true)
}

// wrap printf_format string with ANSI and then pass to printf
print_color_24bit :: proc(ansi_format: ANSI_24Bit, printf_format: string, args: ..any, newline := false) {
	using terminal
	using ansi
	using fmt

	pformat: string

	fg_valid := ansi_format.fg.r != nil && ansi_format.fg.g != nil && ansi_format.fg.b != nil
	bg_valid := ansi_format.bg.r != nil && ansi_format.bg.g != nil && ansi_format.bg.b != nil

	if (fg_valid || bg_valid || card(ansi_format.att) != 0) && color_enabled && color_depth >= .True_Color {

		pformat = CSI + RESET

		for att in ansi_format.att {
			pformat = tprintf("%s%s%i", pformat, ";", att)
		}

		if fg_valid {
			pformat = tprintf("%s%s%i%s%i%s%i", pformat, ";" + FG_COLOR_24_BIT + ";", ansi_format.fg.r, ";", ansi_format.fg.g, ";", ansi_format.fg.b)
		}

		if bg_valid {
			pformat = tprintf("%s%s%i%s%i%s%i", pformat, ";" + BG_COLOR_24_BIT + ";", ansi_format.bg.r, ";", ansi_format.bg.g, ";", ansi_format.bg.b)
		}

		pformat = tprintf("%s%s%s%s", pformat, SGR, printf_format, CSI + RESET + SGR)
	}
	else {
		pformat = printf_format
	}

	printf(pformat, ..args)
	if newline { println() }
}
