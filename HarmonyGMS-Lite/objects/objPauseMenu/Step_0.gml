/// @description Behave
// Close
if (InputPressed(INPUT_VERB.START) or InputPressed(INPUT_VERB.CANCEL))
{
	audio_resume_all();
	menu_close();
}
    
// Update
var input_axis_y = InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN);
cursor = clamp(cursor, 0, 1);
if ((input_axis_y == -1 and cursor != 0) or (input_axis_y == 1 and cursor == 0))
{
	cursor += input_axis_y;
	sound_play(sfxMenuCursor);
}
if (InputPressed(INPUT_VERB.CONFIRM))
{
	switch (cursor)
	{
	    // Quit
	    case 1:
	    {
			break;
		}
		    
		// Continue
		default:
		{
			audio_resume_all();
			menu_close();
		}
	}
}