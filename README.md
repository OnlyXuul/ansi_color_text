ANSI Color library that supports 3bit, 4bit, 8bit, and 24bit (TrueColor) printing to terminal.

Procedures:
* printfc(ansi_format: ANSI_Format, printf_format: string, args: ..any)
* printfcln(ansi_format: ANSI_Format, printf_format: string, args: ..any)

ANSI_Format union types (pass one of these to print procedures):
* ANSI_3Bit
* ANSI_4Bit
* ANSI_8Bit
* ANSI_24Bit
Think I finally settled on a structure for color themes. Only 2 implimented so far. Could use some help adding more.
