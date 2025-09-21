/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

void
tagandview(const Arg *arg) {
    if (!selmon->sel)
        return;
    selmon->sel->tags = arg->ui;  // перемещаем окно на нужный тег
    view(arg);                     // переключаемся на этот тег
}

static const char *const autostart[] = {
    "~/.dwm/autostart.sh", NULL
};

static const char *upvol[]   = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%", NULL };
static const char *downvol[] = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%", NULL };
static const char *mutevol[] = { "pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle", NULL };


/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]               = { 
  "JetBrainsMonoNL:size=13:style=Bold", 
  "Font Awesome 7 Free Solid:size=13:style=Solid"
};
static const char dmenufont[]       = "NDOT 47 (inspired by NOTHING):size=12:style=Regular";

static const char col_base0[]  = "#1C211E"; 
static const char col_base1[]  = "#36372C"; 
static const char col_base2[]  = "#544D39"; 
static const char col_accent1[]= "#A591A4"; 
static const char col_light1[] = "#EADFDD"; 
static const char col_grey1[]  = "#565251"; 
static const char col_grey2[]  = "#6C6064"; 
static const char col_accent2[]= "#7F6962"; 
static const char col_light2[] = "#D4C3CA"; 

static const char *colors[][3]      = {
    /*               fg           bg         border   */
    [SchemeNorm]   = { col_light1, col_base0, col_base1 },   // обычные окна
    [SchemeSel]    = { col_light1, col_accent1, col_accent1 }, // выбранное окно
    [SchemeUrgent] = { col_light2, col_accent2, col_accent2 }, // срочные окна
    [SchemeTag]    = { col_light2, col_base0, col_base2 },   // теги
    [SchemeTitle]  = { col_light1, col_base0, col_base0 },   // заголовки
    [SchemeStatus] = { col_light2, col_base0, col_base0 },   // статусбар
};


/* tagging */
static const char *tags[] = { "N", "O", "T", "H", "I", "N", "G", "1", "2" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "firefox",  NULL,       NULL,       1 << 2,       0,           -1 },
        { "vesktop",  NULL,       NULL,       1 << 0,       0,           -1 },
        { "v2rayN",   NULL,       NULL,       1 << 6,       0,           -1 },
        { "Spotify",  NULL,       NULL,       1 << 1,       0,           -1 },
        { "Thunar",   NULL,       NULL,       0,            1,           -1 },
        { "obsidian", NULL,       NULL,       1 << 4,       0,           -1 },
        { "Focuswriter", NULL,    NULL,       1 << 5,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int refreshrate = 165;  /* refresh rate (per second) for client move/resize */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
        { ControlMask,                  KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tagandview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {
    "dmenu_run", "-m", dmenumon, "-fn", dmenufont,
    "-nb", col_base0,    // фон обычного окна
    "-nf", col_light1,   // цвет текста
    "-sb", col_accent1,  // фон выбранного элемента
    "-sf", col_light2,   // цвет текста выбранного элемента
    NULL
};
static const char *termcmd[]  = { "ghostty", NULL };
static const char *flameshot[] = { "sh", "-c", "QT_SCALE_FACTOR=0.75 flameshot gui", NULL };
/* static const char *quitcmd[] = { "/home/ish3nn/restart-dwm.sh", NULL }; */
static const char *poweroffcmd[]  = { "sudo", "systemctl", "poweroff", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ ControlMask,                  XK_space,  spawn,           {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
        { Mod1Mask,                     XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_z,      setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
{ 0, XF86XK_AudioLowerVolume, spawn, {.v = downvol } },
{ 0, XF86XK_AudioRaiseVolume, spawn, {.v = upvol   } },
{ 0, XF86XK_AudioMute,        spawn, {.v = mutevol } },
{ MODKEY|ShiftMask,  XK_s,  spawn,  {.v = flameshot} },
{ MODKEY|ControlMask|ShiftMask, XK_r, quit, {0} },
/* { MODKEY|ControlMask|ShiftMask, XK_r, spawn, {.v = quitcmd } }, */ 
 { MODKEY|Mod1Mask,    XK_p,            spawn,         {.v = poweroffcmd } },
{ MODKEY, XK_space, spawn, {.v = (const char*[]){ "/home/ish3nn/layot.sh", NULL } } },
{ MODKEY|ShiftMask, XK_g, togglegamingmode, {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

