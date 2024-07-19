fun minbases [] = []
| minbases (head::tail) = 
let
	open LargeInt

fun divisors1(n:LargeInt.int, list, d:LargeInt.int)=
	if d>LargeInt.fromInt(Real.floor(Math.sqrt(Real.fromLargeInt(n)))) then list
	else if n mod d = 0 then divisors1(n, (d::list), d+2)
	     else divisors1(n, list, d+2)

fun divisors2(n:LargeInt.int, list, d:LargeInt.int)=
	if d>LargeInt.fromInt(Real.floor(Math.sqrt(Real.fromLargeInt(n)))) then list
	else if n mod d = 0 then divisors2(n, (d::list), d+1)
	     else divisors2(n, list, d+1)

fun divisors(n:LargeInt.int)=
	if n mod 2 = 0 then divisors2(n, (2::[]), 3)
	else divisors1(n, [], 3) 


fun mymin(x:LargeInt.int, y:LargeInt.int)=
	if x<y then x
	else y


fun mypow(base, exp)=
   let
        fun pow_aux (b, e, acc) =
            if e = 0 then acc
            else if e mod 2 = 0 then pow_aux (b * b, e div 2, acc)
            else pow_aux (b * b, e div 2, acc * b)
    in
        pow_aux (base, exp, 1)
    end;



fun sumpow(base, 0)= 1
| sumpow(base, k)= mypow(base,k)+sumpow(base, k-1)



fun checkBases(_, _, [], min)= min
| checkBases(number, d, (base::T), min)= 
	let
		val len = LargeInt.fromInt(Real.floor(Math.ln(Real.fromLargeInt(number))/Math.ln(Real.fromLargeInt(base))))+1
		val a = (mypow(base, len)-1) div (base-1)
		val num = d*a
	in
		if number = num then checkBases(number, d, T, mymin(min, base))
		else checkBases(number, d, T, min)
	end


fun minbaseHelp(_, [], min)= min
| minbaseHelp(number:LargeInt.int, (d::T), min)=
	let
		val x = number div d -1
		val listDiv = (x::divisors(x))
		val minValid = checkBases(number, d, listDiv, min)
	in
		minbaseHelp(number, T, minValid)
	end
		


fun minbase (number:LargeInt.int) = 
	let
		val lDiv=(1::divisors(number))

	in
		minbaseHelp(number, lDiv, number-1)
	end  




in
minbase(head:LargeInt.int)::minbases tail
end;