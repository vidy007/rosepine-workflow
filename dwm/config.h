#include "fibonacci.c"
/* appearance */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappih    = 5;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 5;       /* vert inner gap between windows */
static const unsigned int gappoh    = 5;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 5;       /* vert outer gap between windows and screen edge */
static const int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int horizpadbar        = 0;        /* horizontal padding for statusbar */
static const int vertpadbar         = 0;        /* vertical padding for statusbar */
static const int user_bh            = 33;
static const char *fonts[]          = { "IBM Plex Mono Medium:size=10" };
static const char dmenufont[]       = "IBM Plex Mono:size=10";
static const char col_gray1[]       = "#1f1d2e";
static const char col_gray2[]       = "#403d52";
static const char col_gray3[]       = "#524f67";
static const char col_gray4[]       = "#e0def4";
static const char col_cyan[]        = "#ebbcba";
	/*               fg         bg         border   */
static const char *colors[][3]      = {
	[SchemeNorm] = { col_gray4,  col_gray1, col_gray2},
	[SchemeSel]  = { col_cyan,   col_gray1, col_gray3 },
};
static const int vertpad            = 0;
static const int sidepad            = 0;
/*static const char *termcmd2[] = { "xterm", NULL };
static const char *browsercmd[] = {"librewolf", NULL};
static const char *keepassxccmd[] = {"keepassxc", NULL};
static const char *emacscmd[] = {"emacs", NULL};

Autostarttag autostarttaglist[] = {
	{.cmd = browsercmd, .tags = 1 << 0 },
	{.cmd = keepassxccmd, .tags = 1 << 4 },
	{.cmd = emacscmd, .tags = 1 << 7 },
	{.cmd = termcmd2, .tags = 1 << 8 },
	{.cmd = NULL, .tags = 0 },
};*/
/* tagging */
static const char *tags[] = { " 1", "2", "3", "4", "5" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      	instance    title    tags mask   isfloating   CenterThisWindow?     monitor */
 	{ "st",         NULL,       NULL,    0,          0,           0,		    -1 },
 	{ "Gimp",       NULL,       NULL,    0,          1,           0,                    -1 },
 	{ "Firefox",    NULL,       NULL,    1 << 8,     0,           1,                    -1 },
	{ "Steam",      NULL,       NULL,    0,          0,           0,                    -1 },
};

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol        arrange function */
	{ "[]=",          tile },    /* first entry is default */
	{ "><>",          NULL },    /* no layout function means floating behavior */
	{ "[M]",       monocle },
      //{ "[@]",        spiral },
	{ "[\\]",      dwindle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
//static const char *dmenucmd[] = { "rofi", "-show", "drun", "-config", ".config/rofi/launcher.rasi", NULL };
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, NULL };
static const char *termcmd[]  = { "st", "-G", "1910x1037", NULL };
static const char *voldowm[] = { "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "0.05-", NULL};
static const char *volup[] = { "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "0.05+", NULL};
static const char *mute[] = { "wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle", NULL};
static const char *powermenu[] = { "dmenu/powermenu.sh", NULL};
static const char *screenshot[] = { "screenshot", NULL};

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_m,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_p,      togglebar,      {0} },
	{ MODKEY|Mod1Mask,              XK_h,      incrgaps,       {.i = +50 } },
 	{ MODKEY|Mod1Mask,              XK_l,      incrgaps,       {.i = -50 } },
 	{ MODKEY|Mod1Mask,              XK_h,      incrogaps,      {.i = +50 } },
 	{ MODKEY|Mod1Mask,              XK_l,      incrogaps,      {.i = -50 } },
 	{ MODKEY|Mod1Mask,              XK_j,      incrigaps,      {.i = +50 } },
 	{ MODKEY|Mod1Mask,              XK_k,      incrigaps,      {.i = -50 } },
 	{ MODKEY|Mod1Mask,              XK_0,      togglegaps,     {0} },
 	{ MODKEY|Mod1Mask|ControlMask,  XK_0,      defaultgaps,    {0} },
 	{ MODKEY,                       XK_y,      incrihgaps,     {.i = +1 } },
 	{ MODKEY,                       XK_o,      incrihgaps,     {.i = -1 } },
 	{ MODKEY|ControlMask,           XK_y,      incrivgaps,     {.i = +1 } },
 	{ MODKEY|ControlMask,           XK_o,      incrivgaps,     {.i = -1 } },
 	{ MODKEY|Mod1Mask,              XK_y,      incrohgaps,     {.i = +1 } },
 	{ MODKEY|Mod1Mask,              XK_o,      incrohgaps,     {.i = -1 } },
 	{ MODKEY|ShiftMask,             XK_y,      incrovgaps,     {.i = +1 } },
 	{ MODKEY|ShiftMask,             XK_o,      incrovgaps,     {.i = -1 } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_s,      spawn,          {.v = screenshot} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY|ShiftMask,             XK_m,      spawn,          {.v = mute} },
	{ MODKEY,                       XK_r,      spawn,          {.v = powermenu} },
	{ MODKEY|ShiftMask,             XK_r,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_f,      togglefullscr,  {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,  spawn,          {.v = voldowm } },
	{ MODKEY,                       XK_equal,  spawn,          {.v = volup } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_e,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

