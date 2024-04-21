--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Function to get current monotonic time.

pragma Restrictions (No_Elaboration_Code);

function A0B.Time.Clock return A0B.Time.Monotonic_Time
  with Preelaborate, Inline_Always;