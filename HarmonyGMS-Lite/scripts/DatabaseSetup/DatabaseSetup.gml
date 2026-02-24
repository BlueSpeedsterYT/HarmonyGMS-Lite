// Constants
#macro DATABASE_SAVE global.save_database
#macro DATABASE_CONFIG global.config_database

#macro CONFIG_DEFAULT_LIVES true
#macro CONFIG_DEFAULT_TIME_OVER true

// Save
global.save_database = db_create();
db_write(DATABASE_SAVE, "", "name");
db_write(DATABASE_SAVE, 0, "playtime");

// Config
global.config_database = db_create();
db_write(DATABASE_CONFIG, CONFIG_DEFAULT_LIVES, "lives");
db_write(DATABASE_CONFIG, CONFIG_DEFAULT_TIME_OVER, "time_over");