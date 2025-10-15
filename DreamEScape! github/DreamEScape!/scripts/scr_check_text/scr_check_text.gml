/// scr_check_text(target_text)
var target_text = argument0;

if(instance_exists(obj_textbox))
{
var tb = instance_find(obj_textbox, 0);
if (tb != noone)
{
    var current_page = tb.page;
    var current_text = tb.text[current_page];
    var chars_shown = floor(tb.draw_char);
    if (current_text == target_text && chars_shown >= string_length(current_text))
    {
        return true;
    }
}
return false;
}