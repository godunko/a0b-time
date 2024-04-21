--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

with A0B.Time.Clock;

package body Ada.Real_Time is

   use type A0B.Time.Monotonic_Time;

   ---------
   -- "+" --
   ---------

   function "+" (Left : Time; Right : Time_Span) return Time is
   begin
      return
        Time (A0B.Time.Monotonic_Time (Left) + A0B.Time.Time_Span (Right));
   end "+";

   ---------
   -- "+" --
   ---------

   function "+" (Left : Time_Span; Right : Time) return Time is
   begin
      return
        Time (A0B.Time.Time_Span (Left) + A0B.Time.Monotonic_Time (Right));
   end "+";

   ---------
   -- "-" --
   ---------

   function "-" (Left : Time; Right : Time_Span) return Time is
   begin
      return
        Time (A0B.Time.Monotonic_Time (Left) - A0B.Time.Time_Span (Right));
   end "-";

   ---------
   -- "-" --
   ---------

   function "-" (Left : Time; Right : Time) return Time_Span is
   begin
      return
        Time_Span
          (A0B.Time.Time_Span'
             (A0B.Time.Monotonic_Time (Left)
                - A0B.Time.Monotonic_Time (Right)));
   end "-";

   -----------
   -- Clock --
   -----------

   function Clock return Time is
   begin
      return Ada.Real_Time.Time (A0B.Time.Clock);
   end Clock;

   ------------------
   -- Microseconds --
   ------------------

   function Microseconds (US : Integer) return Time_Span is
   begin
      return Time_Span (A0B.Time.Microseconds (US));
   end Microseconds;

   ------------------
   -- Milliseconds --
   ------------------

   function Milliseconds (MS : Integer) return Time_Span is
   begin
      return Time_Span (A0B.Time.Milliseconds (MS));
   end Milliseconds;

   -------------
   -- Minutes --
   -------------

   function Minutes (M : Integer) return Time_Span is
   begin
      return Time_Span (A0B.Time.Minutes (M));
   end Minutes;

   -----------------
   -- Nanoseconds --
   -----------------

   function Nanoseconds (NS : Integer) return Time_Span is
   begin
      return Time_Span (A0B.Time.Nanoseconds (NS));
   end Nanoseconds;

   -------------
   -- Seconds --
   -------------

   function Seconds (S : Integer) return Time_Span is
   begin
      return Time_Span (A0B.Time.Seconds (S));
   end Seconds;

   ------------------
   -- To_Time_Span --
   ------------------

   function To_Time_Span (D : Duration) return Time_Span is
      pragma Unreferenced (D);
   begin
      return Time_Span (A0B.Time.Constants.Time_Span_Zero);
   end To_Time_Span;

end Ada.Real_Time;
