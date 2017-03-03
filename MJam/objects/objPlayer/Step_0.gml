/// Player update

// Input //////////////////////////////////////////////////////////////////////

var kLeft, kRight, kUp, kDown, kJump, kJumpRelease, tempAccel, tempFric;

kLeft        = keyboard_check(vk_left) | keyboard_check(ord(A));
kRight       = keyboard_check(vk_right) | keyboard_check(ord(D));
kUp          = keyboard_check(vk_up) | keyboard_check(ord(W));
kDown        = keyboard_check(vk_down) | keyboard_check(ord(S));

kJump        = keyboard_check_pressed(ord(Z));
kJumpRelease = keyboard_check_released(ord(Z));

// Movement ///////////////////////////////////////////////////////////////////

// Apply the correct form of acceleration and friction
if (onGround) {
    tempAccel = groundAccel;
    tempFric  = groundFric;
} else {
    tempAccel = airAccel;
    tempFric  = airFric;
}

// Reset wall cling
if ((!cRight && !cLeft) || onGround) {
    canStick = true;
    sticking = false;
}   

// Cling to wall
if (((kRight && cLeft) || (kLeft && cRight)) && canStick && !onGround) {
    alarm[0] = clingTime;
    sticking = true; 
    canStick = false;       
}

// Handle gravity
if (!onGround) {
    if ((cLeft || cRight) && vy >= 0) {
        // Wall slide
        vy = Approach(vy, vyMax, gravSlide);
    } else {
        // Fall normally
        vy = Approach(vy, vyMax, gravNorm);
    }
}

// Left 
if (kLeft && !kRight && !sticking) {
    // Apply acceleration left
    if (vx > 0)
        vx = Approach(vx, 0, tempFric);   
    vx = Approach(vx, -vxMax, tempAccel);
}

// Right 
if (kRight && !kLeft && !sticking) {
    // Apply acceleration right
    if (vx < 0)
        vx = Approach(vx, 0, tempFric);   
    vx = Approach(vx, vxMax, tempAccel);
}

// Friction
if (!kRight && !kLeft)
    vx = Approach(vx, 0, tempFric); 
        
// Wall jump
if (kJump && cLeft && !onGround) {
    if (kLeft) {
        vy = -jumpHeight * 1.1;
        vx =  jumpHeight * .75;
    } else {
        vy = -jumpHeight * 1.1;
        vx =  vxMax;
    }  
}

if (kJump && cRight && !onGround) {
    if (kRight) {
        vy = -jumpHeight * 1.1;
        vx = -jumpHeight * .75;
    } else {
        vy = -jumpHeight * 1.1;
        vx = -vxMax;
    }  
}
 
// Jump 
if (kJump) { 
    if (onGround)
        vy = -jumpHeight;
    // Variable jumping
} else if (kJumpRelease) { 
    if (vy < 0)
        vy *= 0.25;
}