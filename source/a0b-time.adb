--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

with Ada.Unchecked_Conversion;

package body A0B.Time is

   use type A0B.Types.Integer_64;
   use type A0B.Types.Unsigned_64;

   Nanosecond_Ticks  : constant := 1;
   Microsecond_Ticks : constant := 1_000;
   Millisecond_Ticks : constant := 1_000_000;
   Second_Ticks      : constant := 1_000_000_000;
   Minute_Ticks      : constant := 60_000_000_000;
   Hour_Ticks        : constant := 3_600_000_000_000;

   ---------
   -- "+" --
   ---------

   function "+"
     (Left : Monotonic_Time; Right : Time_Span) return Monotonic_Time is
   begin
      return
        Monotonic_Time
          (A0B.Types.Integer_64 (Left) + A0B.Types.Integer_64 (Right));
   end "+";

   ---------
   -- "+" --
   ---------

   function "+"
     (Left : Time_Span; Right : Monotonic_Time) return Monotonic_Time is
   begin
      return
        Monotonic_Time
          (A0B.Types.Integer_64 (Left) + A0B.Types.Integer_64 (Right));
   end "+";

   ---------
   -- "-" --
   ---------

   function "-"
     (Left : Monotonic_Time; Right : Time_Span) return Monotonic_Time is
   begin
      return
        Monotonic_Time
          (A0B.Types.Integer_64 (Left) - A0B.Types.Integer_64 (Right));
   end "-";

   ---------
   -- "-" --
   ---------

   function "-"
     (Left : Monotonic_Time; Right : Monotonic_Time) return Time_Span is
   begin
      return
        Time_Span
          (A0B.Types.Integer_64 (Left) - A0B.Types.Integer_64 (Right));
   end "-";

   ---------
   -- "<" --
   ---------

   overriding function "<" (Left, Right : Monotonic_Time) return Boolean is
   begin
      return A0B.Types.Unsigned_64 (Left) < A0B.Types.Unsigned_64 (Right);
   end "<";

   ----------
   -- "<=" --
   ----------

   overriding function "<=" (Left, Right : Monotonic_Time) return Boolean is
   begin
      return A0B.Types.Unsigned_64 (Left) <= A0B.Types.Unsigned_64 (Right);
   end "<=";

   ---------
   -- ">" --
   ---------

   overriding function ">" (Left, Right : Monotonic_Time) return Boolean is
   begin
      return A0B.Types.Unsigned_64 (Left) > A0B.Types.Unsigned_64 (Right);
   end ">";

   ----------
   -- ">=" --
   ----------

   overriding function ">=" (Left, Right : Monotonic_Time) return Boolean is
   begin
      return A0B.Types.Unsigned_64 (Left) >= A0B.Types.Unsigned_64 (Right);
   end ">=";

   -----------
   -- Hours --
   -----------

   function Hours (H : Integer) return Time_Span is
   begin
      return Time_Span (A0B.Types.Unsigned_64 (H) * Hour_Ticks);
   end Hours;

   ------------------
   -- Microseconds --
   ------------------

   function Microseconds (US : Integer) return Time_Span is
   begin
      return Time_Span (A0B.Types.Unsigned_64 (US) * Microsecond_Ticks);
   end Microseconds;

   ------------------
   -- Milliseconds --
   ------------------

   function Milliseconds (MS : Integer) return Time_Span is
   begin
      return Time_Span (A0B.Types.Unsigned_64 (MS) * Millisecond_Ticks);
   end Milliseconds;

   function Minutes (M : Integer) return Time_Span is
   begin
      return Time_Span (A0B.Types.Unsigned_64 (M) * Minute_Ticks);
   end Minutes;

   -----------------
   -- Nanoseconds --
   -----------------

   function Nanoseconds (NS : Integer) return Time_Span is
   begin
      return Time_Span (A0B.Types.Unsigned_64 (NS) * Nanosecond_Ticks);
   end Nanoseconds;

   -------------
   -- Seconds --
   -------------

   function Seconds (S : Integer) return Time_Span is
   begin
      return Time_Span (A0B.Types.Unsigned_64 (S) * Second_Ticks);
   end Seconds;

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

   function To_Nanoseconds (T : Monotonic_Time) return A0B.Types.Integer_64 is
   begin
      return A0B.Types.Integer_64 (T);
   end To_Nanoseconds;

   --------------------
   -- To_Nanoseconds --
   --------------------

   function To_Nanoseconds (T : Time_Span) return A0B.Types.Integer_64 is
   begin
      return A0B.Types.Integer_64 (T);
   end To_Nanoseconds;

   ------------------
   -- To_Time_Span --
   ------------------

   function To_Time_Span (D : Duration) return Time_Span is
      function Convert is
        new Ada.Unchecked_Conversion (Duration, Time_Span);

   begin
      return Convert (D);
   end To_Time_Span;

   ------------------
   -- To_Time_Span --
   ------------------

   function To_Time_Span (NS : A0B.Types.Integer_64) return Time_Span is
   begin
      return Time_Span (NS);
   end To_Time_Span;

end A0B.Time;
