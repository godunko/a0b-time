--
--  Copyright (C) 2024-2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

package body A0B.Time is

   ---------
   -- "/" --
   ---------

   function "/" (Left, Right : Time_Span) return Integer is
   begin
      return
        Integer (A0B.Types.Integer_64 (Left) / A0B.Types.Integer_64 (Right));
   end "/";

   -----------
   -- Hours --
   -----------

   function Hours (H : Integer) return Time_Span is
   begin
      return Time_Span (A0B.Types.Integer_64 (H) * Hour_Ticks);
   end Hours;

   -------------
   -- Minutes --
   -------------

   function Minutes (M : Integer) return Time_Span is
   begin
      return Time_Span (A0B.Types.Integer_64 (M) * Minute_Ticks);
   end Minutes;

   -----------------------
   -- To_Monotonic_Time --
   -----------------------

   function To_Monotonic_Time
     (NS : A0B.Types.Unsigned_64) return Monotonic_Time is
   begin
      return Monotonic_Time (NS);
   end To_Monotonic_Time;

   --------------------
   -- To_Nanoseconds --
   --------------------

   function To_Nanoseconds (T : Monotonic_Time) return A0B.Types.Unsigned_64 is
   begin
      return A0B.Types.Unsigned_64 (T);
   end To_Nanoseconds;

end A0B.Time;
