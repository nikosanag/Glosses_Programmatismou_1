open IntInf


fun minbases [] = []
|minbases (x::xs) = 
let  

 fun test_base (number, base) = 
    let
    fun convert(first,second,critical) = 
    if second<>critical then 0 
    else
    if first = 0 then 1
    else
    convert(first div base,first mod base,critical)


    fun gate (x,y) = 
    let 
    val a = x mod y
    in
    if a=0 then 0 else if x mod a = 0 then convert(number div base,number mod base,a) else 0
    end 

    in 
    if gate(number,base) = 1 then base
    else test_base(number,base+1)
    end


in
 
    (test_base(x,2)) :: minbases xs

end;