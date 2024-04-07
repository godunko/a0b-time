--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Real time and calendar utilities.

pragma Restrictions (No_Elaboration_Code);

private with A0B.Types;

package A0B.Time
  with Preelaborate
is

   type Duration is delta 0.000_000_001 digits 18;

   type Monotonic_Time is private;

   type Time_Span is private;

   function "+"
     (Left : Monotonic_Time; Right : Time_Span) return Monotonic_Time
        with Inline;
   function "+"
     (Left : Time_Span; Right : Monotonic_Time) return Monotonic_Time
        with Inline;
   function "-"
     (Left : Monotonic_Time; Right : Time_Span) return Monotonic_Time
        with Inline;
   function "-"
     (Left : Monotonic_Time; Right : Monotonic_Time) return Time_Span
        with Inline;

   --   function "<" (Left, Right : Time) return Boolean;
   --   function "<="(Left, Right : Time) return Boolean;
   --   function ">" (Left, Right : Time) return Boolean;
   --   function ">="(Left, Right : Time) return Boolean;

   --   function "+" (Left, Right : Time_Span) return Time_Span;
   --   function "-" (Left, Right : Time_Span) return Time_Span;
   --   function "-" (Right : Time_Span) return Time_Span;
   --   function "*" (Left : Time_Span; Right : Integer) return Time_Span;
   --   function "*" (Left : Integer; Right : Time_Span) return Time_Span;
   --   function "/" (Left, Right : Time_Span) return Integer;
   --   function "/" (Left : Time_Span; Right : Integer) return Time_Span;

   --   function "abs"(Right : Time_Span) return Time_Span;

   --   function "<" (Left, Right : Time_Span) return Boolean;
   --   function "<="(Left, Right : Time_Span) return Boolean;
   --   function ">" (Left, Right : Time_Span) return Boolean;
   --   function ">="(Left, Right : Time_Span) return Boolean;

   --   function To_Duration (TS : Time_Span) return Duration;
   --   function To_Time_Span (D : Duration) return Time_Span;

   function Nanoseconds  (NS : Integer) return Time_Span
     with Inline;
   function Microseconds (US : Integer) return Time_Span
     with Inline;
   function Milliseconds (MS : Integer) return Time_Span
     with Inline;
   function Seconds      (S  : Integer) return Time_Span
     with Inline;
   function Minutes      (M  : Integer) return Time_Span
     with Inline;
   function Hours        (H  : Integer) return Time_Span
     with Inline;

   --   type Seconds_Count is range 0 .. 59;

   --   procedure Split(T : in Time; SC : out Seconds_Count;
   --   TS : out Time_Span);
   --   function Time_Of(SC : Seconds_Count; TS : Time_Span) return Time;

private

   type Monotonic_Time is new A0B.Types.Integer_64;

   type Time_Span is new A0B.Types.Integer_64;

end A0B.Time;
