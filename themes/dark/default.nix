let
    # Individual colors. 

    # black 0 8
    black1 = "#12151a";
    black2 = "#242b33";

    # red 1 9
    red1 = "#fc6a6a";
    red2 = "#fa8787";

    # green 2 10
    green1 = "#7dff95";
    green2 = "#92fca6";

    # yellow 3 11
    yellow1 = "#fbff82";
    yellow2 = "#fcffab";

    # blue 4 12
    blue1 = "#80b7ff";
    blue2 = "#add1ff";

    # magenta 5 13
    magenta1 = "#ffadf8";
    magenta2 = "#ffd1fb";

    # cyan 6 14
    cyan1 = "#80fffd";
    cyan2 = "#abfffe";

    # white 7 15 
    white1 = "#dddddd";
    white2 = "#ffffff";
in
{
    # by name
    inherit black1 black2;
    inherit red1 red2;
    inherit green1 green2;
    inherit yellow1 yellow2;
    inherit blue1 blue2;
    inherit magenta1 magenta2;
    inherit cyan1 cyan2;
    inherit white1 white2;

    blackAsDec = "18, 21, 26"; # for use in css rgb().

    # by base16
    base16 = {
        color0 = black1;
        color1 = red1;
        color2 = green1;
        color3 = yellow1;
        color4 = blue1;
        color5 = magenta1;
        color6 = cyan1;
        color7 = white1; 
        color8 = black2;
        color9 = red2;
        color10 = green2;
        color11 = yellow2;
        color12 = blue2;
        color13 = magenta2;
        color14 = cyan2;
        color15 = white2;
    };
}
