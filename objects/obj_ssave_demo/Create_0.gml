// See scr_ssave_demo for ConfigFile/SaveFile implementation

show_message_async("Go to \"%localappdata%\\" + game_project_name + "\" to see the files that have been saved!");

instance_create_depth(0, 0, 0, ((SSAVE_USE_MANAGER) ? obj_ssave_demo_manager : obj_ssave_demo_no_manager))