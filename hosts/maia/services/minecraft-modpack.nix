{ lib, pkgs, config, ... }:
let
  java = "${pkgs.openjdk}/bin/java";
  ram = "2760M";
  jar = "server.jar";
in
{
  systemd.services.minecraft-modpack = {
    description = "Modpack minecraft server";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      ExecStart = ''
        ${java} -Xmx${ram} -Xms${ram} -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Daikars.new.flags=true -Dusing.aikars.flags=https://mcflags.emc.gs -jar "${jar}" --nogui
      '';
      Restart = "always";
      User = "minecraft-modpack";
      WorkingDirectory = config.users.users.minecraft-modpack.home;
    };
  };

  users = {
    users.minecraft-modpack = {
      description = "Minecraft modpack service user";
      home = "/var/lib/minecraft-modpack";
      createHome = true;
      isSystemUser = true;
      group = "minecraft-modpack";
    };
    groups.minecraft-modpack = { };
  };

  # Proxy for squaremap
  /*
  services.nginx.virtualHosts."mc.m7.rs" = {
    forceSSL = true;
    enableACME = true;
    locations."/".proxyPass = "http://localhost:8123";
  };
  */

  # Open ports
  networking.firewall = {
    # Minecraft
    allowedTCPPorts = [ 25565 24454 ];
    # Query and Voice chat
    allowedUDPPorts = [ 25565 24454 ];
  };

  environment.persistence = {
    "/persist".directories = [ "/var/lib/minecraft-modpack" ];
  };
}
