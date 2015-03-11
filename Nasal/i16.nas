# If the HUD is selected, show it only in Pilots View
setlistener("/sim/current-view/internal", func(n){
	if(!n.getValue() and getprop("/sim/hud/visibility[1]")) {
		setprop("/sim/hud/visibility[1]", 0);
	}
});


# Payload and fuel after init
setlistener("/sim/signals/fdm-initialized", func {
	interpolate("/fdm/jsbsim/inertia/pointmass-weight-lbs", 100, 2); # the pilot weight
	interpolate("/consumables/fuel/tank[0]/level-lbs", 400, 4);			 # engine oil
});


# flaps was set by landing gear
setlistener("/controls/gear/gear-down", func(f) {
	if(f.getBoolValue()) {
		setprop("/controls/flight/flaps", 0.4);
	}else{
		setprop("/controls/flight/flaps", 0);
	}
});

# If trim wheels are not on 0 and you click the center of this wheel
var trimBackTime = 1.0;
var applyTrimWheels = func(v, which = 0) {
    if (which == 0) { interpolate("/controls/flight/elevator-trim", v, trimBackTime); }
    if (which == 1) { interpolate("/controls/flight/rudder-trim", v, trimBackTime); }
    if (which == 2) { interpolate("/controls/flight/aileron-trim", v, trimBackTime); }
}

# smoke for engines
setlistener("/engines/engine[0]/cranking", func(cr) {
	var fd = getprop("/sim/signals/fdm-initialized") or 0;
	var cr = cr.getBoolValue() or 0;	
	if(fd and cr){
		 setprop("/sim/multiplay/generic/int[8]", 1);
		 setprop("/controls/engines/engine/mixture", 0.75);  #to dangerous:: so never start engine with full mixture on
	}else{
		 setprop("/sim/multiplay/generic/int[8]", 0);
	}  
}, 0, 1);

# the mixture lever in the cockpit
setlistener("/controls/switches/mixture", func(m) {
	var m = m.getBoolValue();	
	if(m){
		 setprop("/controls/engines/engine/mixture", 0.75);  #to dangerous:: so never start engine with full mixture on
	}else{
		 setprop("/controls/engines/engine/mixture", 1);
	}  
}, 0, 1);


# there was a ground contact
setlistener("/fdm/jsbsim/systems/crash-detect/crash-on-ground", func(c) {

		if(c.getBoolValue()) setprop("/fdm/jsbsim/systems/crash-detect/crash-save", 1);
    
}, 1, 1);

# fire up engines, if crashed
setlistener("/fdm/jsbsim/systems/crash-detect/crash-save", func(r) {
    var r = r.getBoolValue() or 0;
    # left hand side
    if (r){        
    	setprop("/sim/multiplay/generic/int[9]", 1);  
    	setprop("/controls/engines/engine[0]/mixture", 0);
    	setprop("/controls/engines/engine[0]/magnetos", 0);
    }
    
}, 0, 1);



