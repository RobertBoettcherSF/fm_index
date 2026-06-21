-- FM_Index Implementation
-- Version: 0.01
-- Date: 2024-06-21
-- Description: FM-Index backward search algorithm implementation

package body FM_Index with SPARK_Mode is

   function Get_Rows (Pattern : Pattern_String;
                      C       : C_Array;
                      Occ     : Occ_Array) return Search_Result
   is
      I     : Natural;
      Ch    : Text_Character;
      First : Index_Range;
      Last  : Index_Range;
   begin
      I := Pattern'Last;
      Ch := Pattern (I);
      
      -- Step 1: Initialize pointers based on the final pattern character
      First := C (Ch) + 1;
      
      if Ch = Text_Character'Last then
         Last := Max_Text_Size;
      else
         Last := C (Text_Character'Succ (Ch));
      end if;
      
      -- Step 2: Backward traversal loop
      while First <= Last and then I >= 2 loop
         pragma Loop_Invariant (I >= 1 and then I <= Pattern'Last);
         
         -- Step 3: Move to the preceding character
         I := I - 1;
         Ch := Pattern (I);
         
         -- Step 4: Update First pointer using Occ function
         if First > 0 then
            First := C (Ch) + Occ (Ch, First - 1) + 1;
         else
            First := C (Ch) + 1;
         end if;
         
         -- Step 5: Update Last pointer
         Last := C (Ch) + Occ (Ch, Last);
      end loop;
      
      -- Step 7: Check if a valid interval was found
      if Last < First then
         return (Found => False, First => 0, Last => 0);
      else
         return (Found => True, First => First, Last => Last);
      end if;
   end Get_Rows;

end FM_Index;
