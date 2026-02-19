/// @description Pause
if (InputPressed(INPUT_VERB.START) and pause_enabled and not instance_exists(objPauseMenu))
{
    instance_create_layer(0, 0, "Controllers", objPauseMenu);
    InputVerbConsumeAll();
}