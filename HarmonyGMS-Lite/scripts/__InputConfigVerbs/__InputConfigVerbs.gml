function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        // Add your own verbs here!
        UP,
        DOWN,
        LEFT,
        RIGHT,
        JUMP,
        ATTACK,
        TRICK,
        START,
        SELECT,
        CONFIRM,
        CANCEL
    }
    
    enum INPUT_CLUSTER
    {
        // Add your own clusters here!
        // Clusters are used for two-dimensional checkers (InputDirection() etc.)
        NAVIGATION,
    }
    
    InputDefineVerb(INPUT_VERB.UP,      "up",          vk_up,       [-gp_axislv, gp_padu]);
    InputDefineVerb(INPUT_VERB.DOWN,    "down",        vk_down,     [ gp_axislv, gp_padd]);
    InputDefineVerb(INPUT_VERB.LEFT,    "left",        vk_left,     [-gp_axislh, gp_padl]);
    InputDefineVerb(INPUT_VERB.RIGHT,   "right",       vk_right,    [ gp_axislh, gp_padr]);
    InputDefineVerb(INPUT_VERB.TRICK,   "trick",       "D",           gp_shoulderr);
    InputDefineVerb(INPUT_VERB.START,   "start",       vk_enter,      gp_start);
    InputDefineVerb(INPUT_VERB.SELECT,  "select",      vk_rshift,     gp_select);
    
    // Blue's Note: This matches up with Advance 2 btw
    if (INPUT_ON_SWITCH)
    {
        InputDefineVerb(INPUT_VERB.JUMP,    "jump",    undefined,   gp_face2);
        InputDefineVerb(INPUT_VERB.ATTACK,  "attack",  undefined,   gp_face1);
        InputDefineVerb(INPUT_VERB.CONFIRM, "confirm", undefined,   gp_face2);
        InputDefineVerb(INPUT_VERB.CANCEL,  "cancel",  undefined,   gp_face1);
    }
    else
    {
        InputDefineVerb(INPUT_VERB.JUMP,    "jump",          "A",   gp_face1);
        InputDefineVerb(INPUT_VERB.ATTACK,  "attack",        "S",   gp_face2);
        InputDefineVerb(INPUT_VERB.CONFIRM, "confirm",       "A",   gp_face1);
        InputDefineVerb(INPUT_VERB.CANCEL,  "cancel",        "S",   gp_face2);
    }
    
    // Define a cluster of verbs for moving around
    InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
}