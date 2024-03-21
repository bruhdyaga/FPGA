`define MAX(a,b) ((a)>(b)?(a):(b))
`define MIN(a,b) ((a)>(b)?(b):(a))
`define ABS(a)   ((a)>0?(a):(-a))


//функция возвращает целое с округлением в большую сторону
function integer log2;
input integer arg;
integer i;
begin
      log2 = 0;
      for(i = 0; 2**i < arg; i = i + 1)
      	log2 = i + 1;
end
endfunction