--
--  Copyright (C) 2024-2026, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Real time utilities.

pragma Restrictions (No_Elaboration_Code);

with A0B.Types;

package A0B.Time
  with Pure
is

   Time_Unit : constant := 0.000_000_001;

   type Duration is
     delta Time_Unit
     range -(2 ** 63) * Time_Unit .. (2 ** 63 - 1) * Time_Unit
     with Small => Time_Unit, Size => 64;

   type Monotonic_Time is private with Preelaborable_Initialization;

   type Time_Span is private with Preelaborable_Initialization;

   function "+"
     (Left : Monotonic_Time; Right : Time_Span) return Monotonic_Time
        with Inline_Always;
   function "+"
     (Left : Monotonic_Time; Right : Duration) return Monotonic_Time
        with Inline_Always;
   function "+"
     (Left : Time_Span; Right : Monotonic_Time) return Monotonic_Time
        with Inline_Always;
   function "-"
     (Left : Monotonic_Time; Right : Time_Span) return Monotonic_Time
        with Inline_Always;
   function "-"
     (Left : Monotonic_Time; Right : Monotonic_Time) return Time_Span
        with Inline_Always;

   function "<" (Left, Right : Monotonic_Time) return Boolean;
   function "<=" (Left, Right : Monotonic_Time) return Boolean;
   function ">" (Left, Right : Monotonic_Time) return Boolean;
   function ">=" (Left, Right : Monotonic_Time) return Boolean;

   --   function "+" (Left, Right : Time_Span) return Time_Span;
   --   function "-" (Left, Right : Time_Span) return Time_Span;
   --   function "-" (Right : Time_Span) return Time_Span;
   --   function "*" (Left : Time_Span; Right : Integer) return Time_Span;
   --   function "*" (Left : Integer; Right : Time_Span) return Time_Span;
   function "/" (Left, Right : Time_Span) return Integer with Inline_Always;
   --   function "/" (Left : Time_Span; Right : Integer) return Time_Span;

   --   function "abs"(Right : Time_Span) return Time_Span;

   function "<" (Left, Right : Time_Span) return Boolean;
   function "<=" (Left, Right : Time_Span) return Boolean;
   function ">" (Left, Right : Time_Span) return Boolean;
   function ">=" (Left, Right : Time_Span) return Boolean;

   function To_Duration (TS : Time_Span) return Duration;
   function To_Time_Span (D : Duration) return Time_Span;

   function Nanoseconds  (NS : Integer) return Time_Span;
   function Microseconds (US : Integer) return Time_Span;
   function Milliseconds (MS : Integer) return Time_Span;
   function Seconds      (S  : Integer) return Time_Span;
   function Minutes      (M  : Integer) return Time_Span
     with Inline;
   function Hours        (H  : Integer) return Time_Span
     with Inline;

   --   type Seconds_Count is range 0 .. 59;

   --   procedure Split(T : in Time; SC : out Seconds_Count;
   --   TS : out Time_Span);
   --   function Time_Of(SC : Seconds_Count; TS : Time_Span) return Time;

   function To_Nanoseconds (T : Monotonic_Time) return A0B.Types.Unsigned_64
     with Inline_Always;
   function To_Monotonic_Time
     (NS : A0B.Types.Unsigned_64) return Monotonic_Time
        with Inline_Always;

   function To_Nanoseconds (T : Time_Span) return A0B.Types.Integer_64
     with Inline_Always;
   function To_Time_Span (NS : A0B.Types.Integer_64) return Time_Span
     with Inline_Always;

private

   use type A0B.Types.Integer_64;
   use type A0B.Types.Unsigned_64;

   subtype Integer_64 is A0B.Types.Integer_64;

   --  Monotonic_Time and Time_Span is a number of nanoseconds.

   type Monotonic_Time is new A0B.Types.Unsigned_64;

   type Time_Span is new A0B.Types.Integer_64;

   --  Duration and Time_Span use the same signed nanosecond count.
   --  Keep these assumptions checked for the unchecked conversions.

   pragma Compile_Time_Error
     (Duration'Size /= 64
        or else Time_Span'Size /= Duration'Size,
      "Duration and Time_Span must have matching 64-bit representations");

   pragma Compile_Time_Error
     (Duration'Small /= 0.000_000_001,
      "Duration must use nanosecond ticks");

   pragma Compile_Time_Error
     (Duration'First /= Time_Span'Pos (Time_Span'First) * Duration'Small
        or else Duration'Last /= Time_Span'Pos (Time_Span'Last) * Duration'Small,
      "Duration and Time_Span must have matching tick ranges");

   Nanosecond_Ticks  : constant := Integer_64 (0.000_000_001 / Time_Unit);
   Microsecond_Ticks : constant := Integer_64 (0.000_001 / Time_Unit);
   Millisecond_Ticks : constant := Integer_64 (0.001 / Time_Unit);
   Second_Ticks      : constant := Integer_64 (1.0 / Time_Unit);
   Minute_Ticks      : constant := Integer_64 (60.0 / Time_Unit);
   Hour_Ticks        : constant := Integer_64 (3_600.0 / Time_Unit);

   overriding function "<" (Left, Right : Monotonic_Time) return Boolean is
     (A0B.Types.Unsigned_64 (Left) < A0B.Types.Unsigned_64 (Right));

   overriding function "<" (Left, Right : Time_Span) return Boolean is
     (A0B.Types.Integer_64 (Left) < A0B.Types.Integer_64 (Right));

   overriding function "<=" (Left, Right : Monotonic_Time) return Boolean is
     (A0B.Types.Unsigned_64 (Left) <= A0B.Types.Unsigned_64 (Right));

   overriding function "<=" (Left, Right : Time_Span) return Boolean is
     (A0B.Types.Integer_64 (Left) <= A0B.Types.Integer_64 (Right));

   overriding function ">" (Left, Right : Monotonic_Time) return Boolean is
     (A0B.Types.Unsigned_64 (Left) > A0B.Types.Unsigned_64 (Right));

   overriding function ">" (Left, Right : Time_Span) return Boolean is
     (A0B.Types.Integer_64 (Left) > A0B.Types.Integer_64 (Right));

   overriding function ">=" (Left, Right : Monotonic_Time) return Boolean is
     (A0B.Types.Unsigned_64 (Left) >= A0B.Types.Unsigned_64 (Right));

   overriding function ">=" (Left, Right : Time_Span) return Boolean is
     (A0B.Types.Integer_64 (Left) >= A0B.Types.Integer_64 (Right));

   function Microseconds (US : Integer) return Time_Span is
     (Time_Span (A0B.Types.Integer_64 (US) * Microsecond_Ticks));

   function Milliseconds (MS : Integer) return Time_Span is
     (Time_Span (A0B.Types.Integer_64 (MS) * Millisecond_Ticks));

   function Nanoseconds (NS : Integer) return Time_Span is
     (Time_Span (A0B.Types.Integer_64 (NS) * Nanosecond_Ticks));

   function Seconds (S : Integer) return Time_Span is
     (Time_Span (A0B.Types.Integer_64 (S) * Second_Ticks));

end A0B.Time;
