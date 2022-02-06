{ pkgs, persistence, lib, ... }: {
  home.packages = with pkgs; [ runelite ];

  home.persistence = lib.mkIf persistence {
    "/persist/games/misterio".directories = [ "Jagex" ];
  };

  # Override .desktop for changing OSRS cache dir
  xdg.desktopEntries = {
    RuneLite = {
      categories = [ "Game" ];
      comment = "Open source Old School RuneScape client";
      exec =
        "env _JAVA_OPTIONS=-Duser.home=/home/misterio/Jagex/ gamemoderun runelite";
      genericName = "Oldschool RuneScape";
      icon = "runescape";
      name = "RuneLite";
      terminal = false;
      type = "Application";
    };
  };
}