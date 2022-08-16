/// @description Core player logic

// Player inputs
isMovingLeft = keyboard_check(vk_left);
isMovingRight = keyboard_check(vk_right);
isJumping = keyboard_check_pressed(vk_space);

// Movement calculations
var _movingDirection = isMovingRight - isMovingLeft;

horizontalSpeed = _movingDirection * walkingSpeed;
verticalSpeed += cGravity;

if (place_meeting(x, y + 1, oInvisibleWall)) && (isJumping) {
	verticalSpeed = -jumpSpeed;
}

// Horizontal collision
if (place_meeting(x + horizontalSpeed, y, oInvisibleWall)) {
	while (!place_meeting(x + sign(horizontalSpeed), y, oInvisibleWall)) {
		x += sign(horizontalSpeed);
	}

	horizontalSpeed = 0;
}

x += horizontalSpeed;

// Vertical collision
if (place_meeting(x, y + verticalSpeed, oInvisibleWall)) {
	while (!place_meeting(x, y + sign(verticalSpeed), oInvisibleWall)) {
		y += sign(verticalSpeed);
	}

	verticalSpeed = 0;
}

y += verticalSpeed;

// Animation
if (!place_meeting(x, y + 1, oInvisibleWall)) {
	sprite_index = sPlayerAir;
	image_speed = 0;
	
	if (verticalSpeed > 0) {
		image_index = 1;
	} else {
		image_index = 0;
	}
} else {
	image_speed = 1;
	
	if (horizontalSpeed == 0) {
		sprite_index = sPlayer;
	} else {
		sprite_index = sPlayerRun;
	}
}

if (horizontalSpeed != 0) {
	image_xscale = sign(horizontalSpeed);	
}