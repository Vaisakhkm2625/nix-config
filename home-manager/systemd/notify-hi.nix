
# TODO unitested, test it
{ config, pkgs, ... }:

{
  systemd.user.services.myscript-job = {
    Unit = {
      Description = "Run myscript.sh periodically";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /home/vaisakh/dotfiles/scripts/schedules/notify-hi.sh";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers.myscript-job = {
    Unit = {
      Description = "Timer for myscript.sh";
    };
    Timer = {
      #OnCalendar = "hourly";  # You can use daily, weekly, or custom times here
      OnCalendar = "minute";  # You can use daily, weekly, or custom times here
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
