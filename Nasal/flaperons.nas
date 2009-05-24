###############################################
# Flaperons control thanks to Guillaume CHAUVAT
###############################################

var flaperons_update = func {
  setprop("/controls/flight/flaperons", getprop("/controls/gear/gear-down"));
};

var gear_listener = setlistener("/controls/gear/gear-down", flaperons_update);
