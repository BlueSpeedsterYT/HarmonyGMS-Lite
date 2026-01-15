/// @description Setup
// Inherit the parent event
event_inherited();

left = false;
top = false;
right = false;
bottom = false;

switch (image_angle)
{
    case 0:
    {
        left = true;
        right = true;
        break;
    }
    case 90:
    {
        top = true;
        bottom = true;
        break;
    }
    case 180:
    {
        left = true;
        right = true;
        break;
    }
    case 270:
    {
        top = true;
        bottom = true;
        break;
    }
}