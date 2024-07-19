open LargeInt

fun minbases [] = []
|minbases (x::xs) = 
let  

 fun find_div (n,d) =
        if d>LargeInt.fromInt(Real.floor(Math.sqrt(Real.fromLargeInt(n)))) then if n <= 2 then [] else n div 2::n div 3::[]
        else if n mod d = 0 then d::find_div(n,d+1) else find_div(n,d+1)
   
 fun find_suitable_bases (n,l) = 
        let
        val x = n div (hd l) - 1
        in
        if n = 1 then [2]
        else
        if n = 2 then [3]
        else  
        if (tl l)<>[] then [x] @ find_div(x,1) @ find_suitable_bases(n,tl l) else [x] @ find_div(x,1)
        end
 
 fun test_base (_,[],min) = min
    |test_base (number, list ,min) = 
    let
    val base = hd list; 
       fun convert(first,second,critical) = 
              if second<>critical then 0 
              else
              if first = 0 then base    
              else convert(first div base,first mod base,critical)
     
    
    


       fun gate (x,y) = 
              let 
                     val a = x mod y
              in
                     if x = 2 orelse x = 1 then 1
                     else
                     if a=0 then 0
                     else if x mod a = 0 then convert(number div base,number mod base,a) else 0
              end 
   
   
       val result = gate(number,base)
    
    in 
       if result = 0 then test_base(number,tl list,min)
       else
       if min = 0 then test_base(number,tl list,base) else
       if min>base then test_base(number,tl list,base) else

    test_base(number,tl list,min)
    end
    
in
 
     (test_base(x:LargeInt.int,find_suitable_bases(x,find_div(x,1)),0)) :: minbases xs

end; 