// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function scr_personagem_movendo()
{
//Teclas
dir = keyboard_check(vk_right);
esq = keyboard_check(vk_left);
cima = keyboard_check_pressed(vk_up);

velh = (dir - esq) * vel;

	#region //Direção
	if dir
	{
		xscale = 0;
		sprite_index = spr_player_andando;
	}
	else if esq
	{
		xscale = 1;
		sprite_index = spr_player_andando_esq
	
	}
	else 
	{
		if xscale == 0
		{
			sprite_index = spr_player_idle;
		}
		else if xscale == 1
		{
			sprite_index = spr_player_idle_esq;
		}
	}
	#endregion

	#region Gravidade
	if (!place_meeting(x, y + 1, obj_chao))
	{
		velv += grav;
	}
	else
	{
		if cima
		{
			velv = -2.5
		}
	}
	#endregion

	#region Colisão horizontal
	if(place_meeting(x + velh,y,obj_chao))
	{
		while !place_meeting(x + sign(velh), y, obj_chao)
		{
			x += sign(velh);
		}
		velh = 0;
	}

	x += velh;
	#endregion

	#region Colisão vertical
	if(place_meeting(x, y + velv, obj_chao))
	{
		while !place_meeting(x, y + sign(velv), obj_chao)
		{
			y += sign(velv);
		}
		velv = 0;
	}

	y += velv;
	#endregion

	#region Combate
	if keyboard_check_pressed(ord("Z"))
	{
		image_index = 0;
		estado = scr_personagem_atacando;
		//Hitbox
		//direita
		if xscale == 0 
		{
			instance_create_layer(x + 40, y - 30, "Instances", obj_hitbox)
		}
		//esquerda
		else if xscale == 1
		{
			instance_create_layer(x - 4, y - 30, "Instances", obj_hitbox)
		}
	}
	#endregion
}

function scr_personagem_atacando()
{
	if xscale == 0 
	{
		sprite_index = spr_player_attack;
	}
	else if xscale == 1
	{
		sprite_index = spr_player_attack_esq;
	}
	
	if scr_fim_animacao()
	{
		estado = scr_personagem_movendo;
	}
}