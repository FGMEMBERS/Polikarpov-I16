## Pilot jump out ##
JumpOut = func
{
  # current view is parachutist view
  setprop("/sim/current-view/view-number", 5);
  setprop("/sim/current-view/x-offset-m",  0.150);
  setprop("/sim/current-view/y-offset-m", -4.00);
  setprop("/sim/current-view/z-offset-m",  6.00);
  setprop("/controls/engines/engine[0]/magnetos", 0);
  setprop("/controls/electric/battery-switch", 0);

  setprop("/sim/multiplay/generic/int[7]",1);
  setprop("/para/jump-signal",1);

  # if autopilot is on
  setprop("/autopilot/locks/altitude", "");
  setprop("/autopilot/locks/heading", "");
  setprop("/autopilot/locks/passive-mode", "");
  setprop("/autopilot/locks/speed", "");
  setprop("/controls/flight/elevator", 0.2);

  # confirm other aircraft whats happend over multiplayer chat
  var paraLong = getprop("/position/longitude-string");
  var paraLati = getprop("/position/latitude-string");
  setprop("/sim/multiplay/chat", "MADAY MAYDAY MAYDAY - jumped out - "~paraLati~" "~paraLong);
}
