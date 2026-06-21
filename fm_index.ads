-- FM_Index Specification
-- Version: 0.03
-- Date: 2024-06-21
-- Description: FM-Index data structures and types for SPARK verification

package FM_Index with SPARK_Mode is

   -- Bounded text size for static SPARK verification
   Max_Text_Size : constant := 10_000;
   type Index_Range is new Natural range 0 .. Max_Text_Size;
   
   -- Simplified alphabet encompassing lowercase letters and a terminal symbol
   type Text_Character is ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 
                           'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 
                           'u', 'v', 'w', 'x', 'y', 'z', '#');
   
   -- C[c] stores the total number of text characters strictly smaller than c
   type C_Array is array (Text_Character) of Index_Range;
   
   -- Occ[c, pos] stores occurrences of character c in the BWT up to pos
   type Occ_Array is array (Text_Character, Index_Range) of Index_Range;
   
   type Pattern_String is array (Positive range <>) of Text_Character;
   
   type Search_Result is record
      Found : Boolean;
      First : Index_Range;
      Last  : Index_Range;
   end record;

   -- Executes the backward search (get_rows) to find the suffix array interval
   function Get_Rows (Pattern : Pattern_String;
                      C       : C_Array;
                      Occ     : Occ_Array) return Search_Result
     with Pre => Pattern'Length > 0 and then Pattern'First = 1
           and then (for all Ch in Text_Character => C(Ch) <= Max_Text_Size)
           and then (for all Ch in Text_Character => 
                      (for all Pos in Index_Range => Occ(Ch, Pos) <= Max_Text_Size - C(Ch)));

end FM_Index;
