///@function function_name(x,[c_str])
///@description What it does
///@param x {real} what it is

function Input()constructor{
	
	key_left=ord("A");
	key_right=ord("D");
	key_up=ord("W");
	key_down=ord("S");
	
	action={
		move : [ 0, 0 ],
	};
	
	step=function(){
		move[0]=keyboard_check(key_right)-keyboard_check(key_left);
		move[1]=keyboard_check(key_down)-keyboard_check(key_up);
	}
}