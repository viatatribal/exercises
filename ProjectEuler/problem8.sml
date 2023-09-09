(*The four adjacents digits in the 1000-digit number
 * that have the greatest product are 9 * 9 * 9 * 8 = 5832.
 *
 * 73167176531330624919225119674426574742355349194934
 * 96983520312774506326239578318016984801869478851843
 * 85861560789112949495459501737958331952853208805511
 * 12540698747158523863050715693290963295227443043557
 * 66896648950445244523161731856403098711121722383113
 * 62229893423380308135336276614282806444486645238749
 * 30358907296290491560440772390713810515859307960866
 * 70172427121883998797908792274921901699720888093776
 * 65727333001053367881220235421809751254540594752243
 * 52584907711670556013604839586446706324415722155397
 * 53697817977846174064955149290862569321978468622482
 * 83972241375657056057490261407972968652414535100474
 * 82166370484403199890008895243450658541227588666881
 * 16427171479924442928230863465674813919123162824586
 * 17866458359124566529476545682848912883142607690042
 * 24219022671055626321111109370544217506941658960408
 * 07198403850962455444362981230987879927244284909188
 * 84580156166097919133875499200524063689912560717606
 * 05886116467109405077541002256983155200055935729725
 * 71636269561882670428252483600823257530420752963450
 *
 * Find the thirteen adjacent digits in the 1000-digit number
 * that have the greatest product. What is the value of this product?
 *)

(* First we remove any 0 from the string because they make
 * the product be equal to 0, so we only care about digits
 * before and after 0s, we also remove the 1s
 * since they don't help we get a bigger number
 * then we filter any substring that has size less than 13 *)

open LargeInt;


val numbers =
    List.filter
        (fn n => Int.toLarge(String.size n) >= 13)
        (String.tokens
             (fn n => n = #"0" orelse n = #"1")
             ("73167176531330624919225119674426574742355349194934"
              ^ "96983520312774506326239578318016984801869478851843"
              ^ "85861560789112949495459501737958331952853208805511"
              ^ "12540698747158523863050715693290963295227443043557"
              ^ "66896648950445244523161731856403098711121722383113"
              ^ "62229893423380308135336276614282806444486645238749"
              ^ "30358907296290491560440772390713810515859307960866"
              ^ "70172427121883998797908792274921901699720888093776"
              ^ "65727333001053367881220235421809751254540594752243"
              ^ "52584907711670556013604839586446706324415722155397"
              ^ "53697817977846174064955149290862569321978468622482"
              ^ "83972241375657056057490261407972968652414535100474"
              ^ "82166370484403199890008895243450658541227588666881"
              ^ "16427171479924442928230863465674813919123162824586"
              ^ "17866458359124566529476545682848912883142607690042"
              ^ "24219022671055626321111109370544217506941658960408"
              ^ "07198403850962455444362981230987879927244284909188"
              ^ "84580156166097919133875499200524063689912560717606"
              ^ "05886116467109405077541002256983155200055935729725"
              ^ "71636269561882670428252483600823257530420752963450"));

local
  (* Get the 13 adjacents numbers from n to m *)
  fun adjacents s n =
      String.substring (s, Int.fromLarge n, Int.fromLarge 13);
  (* Get the numbers out of the string *)
  fun stringToNumbers s =
      List.map
          (fn n => case Int.fromString n of SOME(x) => Int.toLarge x)
          (List.map
               (fn n => Char.toString n)
               (String.explode s));
  (* Get the product of the 13 adjacent numbers *)
  fun product n =
      List.reduce
          op *
          1
          n;
  (* Get the max product of the 13-adjacents digits in a substring *)
  fun subMax st n size max =
      if (n+13) > size
      then max
      else
        let
          val num = (product o stringToNumbers) (adjacents st n)
        in
          if num > max
          then subMax st (n+1) size num
          else subMax st (n+1) size max
        end;
in
  (* We get the max of all substrings *)
  fun getMax st =
      List.map
          (fn n => subMax n 0 (Int.toLarge (String.size n)) 0)
          st
end;

val solution =
    List.reduce
        max
        0
        (getMax numbers);