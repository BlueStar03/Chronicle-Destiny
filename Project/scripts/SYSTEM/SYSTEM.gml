#macro vMAJOR 0
#macro vMINOR 1
#macro vPATCH 0
#macro vCANARY 1
#macro VERSION "v" + string(vMAJOR) + "." + string(vMINOR) + "." + string(vPATCH)+ "." +string(vCANARY)
#macro input global.___input
___input=new Input();
