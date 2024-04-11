--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Constants to use by the Ada.Real_Time package.

pragma Restrictions (No_Elaboration_Code);

package A0B.Time.Constants
  with Pure
is

   Monotonic_Time_First : constant Monotonic_Time;
   Monotonic_Time_Last  : constant Monotonic_Time;
   Time_Span_First      : constant Time_Span;
   Time_Span_Last       : constant Time_Span;
   Time_Span_Zero       : constant Time_Span;
   Time_Span_Unit       : constant Time_Span;
   System_Timer_Tick    : constant Time_Span;

private

   Monotonic_Time_First : constant Monotonic_Time := Monotonic_Time'First;
   Monotonic_Time_Last  : constant Monotonic_Time := Monotonic_Time'Last;
   Time_Span_First      : constant Time_Span := Time_Span'First;
   Time_Span_Last       : constant Time_Span := Time_Span'Last;
   Time_Span_Zero       : constant Time_Span := 0;
   Time_Span_Unit       : constant Time_Span := 1;
   System_Timer_Tick    : constant Time_Span := 1_000;
   --  SystemTimer's tick is fixed to 1 microsecond.

end A0B.Time.Constants;
