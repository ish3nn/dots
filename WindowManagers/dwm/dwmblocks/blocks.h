//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
    /*Icon*/        /*Command*/                                              /*Update Interval*/     /*Update Signal*/
    {":: ", "xkblayout-state print '%s' | awk '{print toupper($0)}'", 0, 1},
    {":: ", "date '+%A %d.%m'", 60, 0},
    {":: ", "date '+%H:%M  '", 5, 0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = "  ┇  ";
static unsigned int delimLen = 7;

