datatype tree = Empty | Node of int * tree  * tree;


fun calc(x,1) = (x)
      | calc ([],_) = []
      | calc (x,counter) = if (hd x = 0)  then calc(tl x,counter+1) else calc(tl x,counter-1);
      
fun build [] = Empty
  | build (x::xs) =  if (x = 0) then Empty else Node(x,build (xs),build (calc(xs,0)));

fun inorder Empty = ()
| inorder (Node(v,left,right)) = (inorder(left); print(Int.toString v ^ " "); inorder(right)); 

fun identify_smaller (Node(num,left,right),0) = identify_smaller(Node(num,left,right),num)
|identify_smaller (Empty,res) = res
|identify_smaller (Node(num,left,right),res) = 
let
val numberleft = if num<res then identify_smaller(left,num) else identify_smaller(left,res)
val numberright = if num<res then identify_smaller(right,num) else identify_smaller(right,res)
in
if numberleft<numberright then numberleft else numberright 
end; 

fun rearrange Empty = Empty
| rearrange (Node(number,left,right)) = 
let 
val right_smallest_number = identify_smaller(right,0); 
val left_smallest_number = identify_smaller(left,0); 
in
if (left=Empty andalso right = Empty) then Node(number,left,right)
else if(left = Empty) then (if(number>right_smallest_number) then (  Node(number,rearrange right,Empty)) else ( Node (number,Empty,rearrange right)))
else if(right = Empty) then (if(number<left_smallest_number) then ( Node(number,Empty, rearrange left)) else (   Node(number,rearrange left,right)))
else if(right_smallest_number<left_smallest_number) then (Node (number,rearrange right,rearrange left))
else (Node(number,rearrange left,rearrange right))

end;


fun arrange (file_name:string) = 
let
val opf = TextIO.openIn file_name 
val content = TextIO.inputAll  opf
val tokens = String.tokens (fn c => not (Char.isDigit c)) content 
fun stringsToInts (strings : string list) =
    map (fn str =>
        case Int.fromString str of
            NONE => raise Fail ("Invalid integer: " ^ str)
          | SOME n => n) strings;
in
inorder(rearrange(build(tl (stringsToInts(tokens)))));
print "\n" 
end; 
