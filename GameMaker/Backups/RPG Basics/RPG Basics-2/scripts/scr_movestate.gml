///scr_movestate
scr_getinput();

if(dash_key){
    var xdir = lengthdir_x(8, face*90);
    var ydir = lengthdir_y(8, face*90);
    var speaker = instance_place(x+xdir, y+ydir, obj_speaker); //Which object we are speaking to
    if(speaker != noone){
        // Talk to it
        with(speaker) {
            if(!instance_exists(dialog)){
                dialog = instance_create(x+xoffset, y+yoffset, obj_dialog);
                dialog.text = text;
            } else{
                dialog.text_page++;
                dialog.text_count = 0;
                if(dialog.text_page > array_length_1d(dialog.text)-1){
                    with(dialog){
                        instance_destroy();
                    }
                }
            }
        }
    }
    else if(object_player_stats.stamina >= DASH_COST){
        state = scr_dash_state;
        alarm[0] = room_speed/8;
        ///show_message("Hit Dash State");
        object_player_stats.stamina -= DASH_COST;
        object_player_stats.alarm[0] = room_speed;
    }
}

if(attack_key){
    image_index = 0;
    state = scr_attack_state;
}

if(spell_key){
    switch(obj_player.currentspell) {

    case "FB":
        if(object_player_stats.stamina >= FB_COST){
            object_player_stats.stamina -= FB_COST;
            object_player_stats.alarm[0] = room_speed;
            var p = instance_create(x,y,obj_fireball);
            var xforce = lengthdir_x(20, face*90);
            var yforce = lengthdir_y(20, face*90);
            p.creator = id;
            //dir = point_direction(0, 0, xaxis, yaxis);
            //var FBdir = point_direction(0, 0, phy_speed_x, phy_speed_y);
            //scr_get_face();
            //FBface = round(dir/90);
            //p.image_angle = FBface * 90;
            with(p) {
                physics_apply_impulse(x,y,xforce/10,yforce/10);
                //direction = creator.direction;
            }
        }
        break;
    case "MINE":
        if(object_player_stats.stamina >= MINE_COST){
            object_player_stats.stamina -= FB_COST;
            object_player_stats.alarm[0] = room_speed;
            var p = instance_create(x,y,obj_mine);
            p.creator = id;
        }
        break;
    }
}

// Get direction
dir = point_direction(0, 0, xaxis, yaxis);

//Get the length
if (xaxis == 0 and yaxis == 0){
    len = 0;
} else {
    len = spd;
    scr_get_face();
}    

hspd = lengthdir_x(len, dir);
vspd = lengthdir_y(len, dir);

//Get hspd and vspd
hspd = xaxis*spd;
vspd = yaxis*spd;
//Move 
phy_position_x += hspd;
phy_position_y += vspd;

//Control the sprite
image_speed = sign(len)*.2;
if(len == 0) image_index = 0;

switch(face) {

    case RIGHT:
        sprite_index = spr_player_right;
        break;
    case UP:
        sprite_index = spr_player_up;
        break;
    case LEFT:
        sprite_index = spr_player_left;
        break;
    case DOWN:
        sprite_index = spr_player_down;
        break;

}




//Vertical sprites
/*if(vspd > 0){
    sprite_index = spr_player_down;
}
else if (vspd < 0){
    sprite_index = spr_player_up;
}
//Horizontal sprites
if(hspd > 0){
    sprite_index = spr_player_right;
}
else if (hspd < 0){
    sprite_index = spr_player_left;
}*/

/* Prev Movment
if (right_key) {
    phy_position_x += spd;
    sprite_index = spr_player_right;
    image_speed = .3;
    ///show_debug_message("Exit not created!");
}
if (left_key) {
    phy_position_x -= spd;
    sprite_index = spr_player_left;
    image_speed = .3;
}
if (down_key) {
    phy_position_y += spd;
    sprite_index = spr_player_down;
    image_speed = .3;
}
if (up_key) {
    phy_position_y -= spd;
    sprite_index = spr_player_up;
    image_speed = .3;
}

///Stop Animating
if (!right_key and !left_key and !up_key and !down_key){
    image_speed = 0;
    image_index = 0;
}*/
