/// @description Render

//draw_set_colour(c_black);
//draw_rectangle(0, 0, CAMERA_WIDTH, CAMERA_HEIGHT, false);
//draw_set_colour(c_white);

// Triangle
if ((counter - 10) > 124)
{
	if (counter >= 150)
	{
		if (counter == 150)
		{
			triangle_pos_x = CAMERA_WIDTH;
			triangle_pos_y = CAMERA_HEIGHT;
		}
		else if (counter >= 190)
		{
			triangle_pos_x += 4;
			triangle_pos_y += 4;
		}
		
		draw_sprite(sprIntroActTriangle, triangle_frame[global.character], triangle_pos_x, triangle_pos_y);
	}
}
// Character Icon
else
{
	var character_icon_x, character_icon_y;
	
	if (counter <= 12) 
	{
        character_icon_x = (CAMERA_WIDTH + 14) - (((counter * 75) << 6) >> 8);
        character_icon_y = ((CAMERA_HEIGHT / 2) + 41) - (((counter * 123) << 3) >> 8);

    } 
	else if (counter <= 100) 
	{
        character_icon_x = (CAMERA_WIDTH + 14) - (((13 * 75) << 6) >> 8) + 13;
        character_icon_y = ((CAMERA_HEIGHT / 2) + 41) - (((13 * 123) << 3) >> 8) + 2;
    } 
	else 
	{
        var innerCount = counter - (100 - 12);
        character_icon_x = (CAMERA_WIDTH + 14) - (((innerCount * 75) << 6) >> 8);
        character_icon_y = ((CAMERA_HEIGHT / 2) + 41) - (((innerCount * 123) << 3) >> 8);
    }
	draw_sprite(sprIntroCharacterIcon, character_icon_frame[global.character], character_icon_x, character_icon_y);
}

// Act Letters
if (ctrlZone.act > 0 and ctrlZone.act < 3)
{
	if ((counter - 151) >= 40)
	{
		
	}
	else
	{
		var act_counter = (counter - 150);
			
		if (act_counter < 14) 
		{
	        for (var i = 0; i < 4; i++)
			{
				var offset_y = act_counter - i * 3;
		        if (offset_y >= 4) offset_y = 4;
				
				offset_y *= 8;

		        act_letters_drawn_x[i] = act_letters_pos_x[i];

		        offset_y = (offset_y - 32);
		        act_letters_drawn_y[i] = offset_y + act_letters_pos_y[i];
			}
	    } 
		else if (act_counter < 18) 
		{
	        act_counter -= 13;

	        offset_y = act_letters_offset_y[act_counter];
				
			for (var i = 0; i < 4; i++)
			{
		        act_letters_drawn_x[i] = act_letters_pos_x[i];
		        act_letters_drawn_y[i] = act_letters_pos_y[i] + offset_y;
			}
	    }
		else 
		{
			for (var i = 0; i < 4; i++)
			{
		        act_letters_drawn_x[i] = act_letters_pos_x[i];
		        act_letters_drawn_y[i] = act_letters_pos_y[i];
			}
	    }
	}
		
	for (var i = 0; i < 4; i++)
	{
		if ((i * 3) < (counter - 150))
		{
			draw_sprite(sprIntroActLetters, act_letters_frames[i], act_letters_drawn_x[i], act_letters_drawn_y[i]);
		}
	}
}