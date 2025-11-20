package ansi_color

import "core:strings"
import "core:strconv"

/****************************************
 * Helper procedures
*****************************************/

// return u8 color 0-255 from string
parse_color :: proc(s: string) -> (color: u8, ok: bool) {
	if c, c_ok := strconv.parse_u64(s); c_ok && c >= 0 && c <= 255{
		return u8(c), true
	}
	return 0, false
}

// return RGB color based on string name of color
parse_theme_color :: proc(s: string, theme: Color_Theme) -> (rgb: RGB, ok: bool) {
	color := strings.to_lower(s)
	defer delete(color)
	if s != "" do switch color {
		case "red":           return theme.red,           true
		case "green":         return theme.green,         true
		case "yellow":        return theme.yellow,        true
		case "blue":          return theme.blue,          true
		case "magenta":       return theme.magenta,       true
		case "cyan":          return theme.cyan,          true
		case "white":         return theme.white,         true
		case "black":         return theme.black,         true
		case "light.red":     return theme.light.red,     true
		case "light.green":   return theme.light.green,   true
		case "light.yellow":  return theme.light.yellow,  true
		case "light.blue":    return theme.light.blue,    true
		case "light.magenta": return theme.light.magenta, true
		case "light.cyan":    return theme.light.cyan,    true
		case "light.white":   return theme.light.white,   true
		case "light.black":   return theme.light.black,   true
		case "dark.red":      return theme.dark.red,      true
		case "dark.green":    return theme.dark.green,    true
		case "dark.yellow":   return theme.dark.yellow,   true
		case "dark.blue":     return theme.dark.blue,     true
		case "dark.magenta":  return theme.dark.magenta,  true
		case "dark.cyan":     return theme.dark.cyan,     true
		case "dark.white":    return theme.dark.white,    true
		case "dark.black":    return theme.dark.black,    true
	}
	return {}, false
}

// return Attribute based on string
parse_atribute :: proc(s: string) -> (att: Attribute, ok: bool) {
	attribute := strings.to_upper(s)
	defer delete(attribute)
	if s != "" do switch attribute {
	case "BOLD":                    return .BOLD                    , true
	case "FAINT":                   return .FAINT                   , true
	case "ITALIC":                  return .ITALIC                  , true
	case "UNDERLINE":               return .UNDERLINE               , true
	case "BLINK_SLOW":              return .BLINK_SLOW              , true
	case "BLINK_RAPID":             return .BLINK_RAPID             , true
	case "INVERT":                  return .INVERT                  , true
	case "HIDE":                    return .HIDE                    , true
	case "STRIKE":                  return .STRIKE                  , true
	case "FONT_PRIMARY":            return .FONT_PRIMARY            , true
	case "FONT_ALT1":               return .FONT_ALT1               , true
	case "FONT_ALT2":               return .FONT_ALT2               , true
	case "FONT_ALT3":               return .FONT_ALT3               , true
	case "FONT_ALT4":               return .FONT_ALT4               , true
	case "FONT_ALT5":               return .FONT_ALT5               , true
	case "FONT_ALT6":               return .FONT_ALT6               , true
	case "FONT_ALT7":               return .FONT_ALT7               , true
	case "FONT_ALT8":               return .FONT_ALT8               , true
	case "FONT_ALT9":               return .FONT_ALT9               , true
	case "FONT_FRAKTUR":            return .FONT_FRAKTUR            , true
	case "UNDERLINE_DOUBLE":        return .UNDERLINE_DOUBLE        , true
	case "NO_BOLD_FAINT":           return .NO_BOLD_FAINT           , true
	case "NO_ITALIC_BLACKLETTER":   return .NO_ITALIC_BLACKLETTER   , true
	case "NO_UNDERLINE":            return .NO_UNDERLINE            , true
	case "NO_BLINK":                return .NO_BLINK                , true
	case "PROPORTIONAL_SPACING":    return .PROPORTIONAL_SPACING    , true
	case "NO_REVERSE":              return .NO_REVERSE              , true
	case "NO_HIDE":                 return .NO_HIDE                 , true
	case "NO_STRIKE":               return .NO_STRIKE               , true
	case "NO_PROPORTIONAL_SPACING": return .NO_PROPORTIONAL_SPACING , true
	case "FRAMED":                  return .FRAMED                  , true
	case "ENCIRCLED":               return .ENCIRCLED               , true
	case "OVERLINED":               return .OVERLINED               , true
	case "NO_FRAME_ENCIRCLE":       return .NO_FRAME_ENCIRCLE       , true
	case "NO_OVERLINE":             return .NO_OVERLINE             , true
	}
	return {}, false
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
