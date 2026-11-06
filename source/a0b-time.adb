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

end A0B.Time;
