///Player initialisation

// Inherit oParEntity variables
event_inherited();


// Movement ///////////////////////////////////////////////////////////////////

// Multiplier
m = 1.0;

groundAccel = 1.0  * m;
groundFric  = 1.9  * m;
airAccel    = 0.75 * m;
airFric     = 0.1  * m;
vxMax       = 6.5  * m;
vyMax       = 10.0 * m;
jumpHeight  = 8.0  * m;
gravNorm    = 0.5  * m;
gravSlide   = 0.25 * m; 

clingTime   = 4.0 * m;

// Misc ///////////////////////////////////////////////////////////////////////

// Relative collision checks
cLeft  = place_meeting(x - 1, y, oParSolid);
cRight = place_meeting(x + 1, y, oParSolid);

// Common calculation
sqrt2 = sqrt(2);