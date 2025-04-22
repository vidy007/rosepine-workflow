/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int instant = 0;                     /* -n  option; if 1, select single entry automatically */
static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 1;                    /* -c option; centers dmenu on screen */
static int min_width = 200;                 /* minimum width when centered */
static int fuzzy  = 1;                      /* -F  option; if 0, dmenu doesn't use fuzzy matching */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const int user_bh = 9;

static const char *fonts[] = {
	"IBM Plex Mono:size=10"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
		          /*      fg         bg       */
	[SchemeNorm] =   	{ "#908caa", "#1f1d2e" },
	[SchemeSel] =    	{ "#ebbcba", "#1f1d2e" },
	[SchemeSelHighlight] =  { "#f6c177", "#1f1d2e" },
	[SchemeNormHighlight] = { "#f6c177", "#1f1d2e" },
	[SchemeOut] =    	{ "#908caa", "#1f1d2e" },
	[SchemeBorder] = 	{ "#403d52", NULL },
	[SchemeHp]  = 		{ "#f6c177", "#1f1d2e" }
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 10;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
/* Size of the window border */
static unsigned int border_width = 1;
