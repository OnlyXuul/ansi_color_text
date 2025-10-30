ANSI Color library that supports 3bit, 4bit, 8bit, and 24bit (TrueColor) printing to terminal.

Use either overloaded procedures or their respective procedures.

 Overloads:
* printfc
* printflnc

Respective procedures:
* printf_c3, printf_c4, printf_c8, printf_c24
* printfln_c3, printfln_c4, printfln_c8, printfln_c24

Hyperlinks not implimented since most terminals are late to adopt
or have it disabled by default. In those terminals, URL detection is supported,
so support for OSC 8 is really moot. Here's an example though:

fmt.printfln("%s%s%s%s%s", OSC + HYPERLINK + ";;", "https://forum.odin-lang.org/", ST, "Click Me", OSC + HYPERLINK + ";;" + ST)
