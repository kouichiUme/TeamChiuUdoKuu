-- example of getting RC input

-- local scripting_rc_1 = rc:find_channel_for_option(300)
-- local scripting_rc_2 = rc:find_channel_for_option(301)
-- local flip_flop = 0

local MoveCount = 0
local LastForward = false
local LastBackword = false


function update()
  pwm1 = rc:get_pwm(1)    -- roll
  pwm2 = rc:get_pwm(2)    -- pitch
  pwm3 = rc:get_pwm(3)    -- throttle
  pwm4 = rc:get_pwm(4)    -- yaw
  ch5  = rc:get_pwm(5)
  ch6  = rc:get_pwm(6)
  ch7  = rc:get_pwm(7)
  ch8  = rc:get_pwm(8)

  OutText = tostring(pwm1) .. " " .. tostring(pwm2) .. " " .. tostring(pwm3) .. " " .. tostring(pwm4)
            .. " " .. tostring(ch5) .." " .. tostring(ch6) .. " " .. tostring(ch7) .. " " .. tostring(ch8)

  if pwm2 >= 1550 then    -- ピッチ > 前(deadzone=50)
    Forward = true
  else
    Forward = false
  end

  if pwm2 <= 1450 then    -- ピッチ < 後ろ(deadzone=50)
    Backword = true
  else
    Backword = false
  end

  if LastForward  then    -- 前回が前進
    if Forward then   -- 今回も前進
      MoveCount = MoveCount + 1
    else    -- 停止
      MoveCount = 0
    end
  end

  if LastBackword then    -- 前回が後進
    if Backword then    -- 今回も後進
      MoveCount = MoveCount - 1
    else  -- 停止
      MoveCount = 0
    end
  end

  LastForward = Forward
  LastBackword = Backword


  if not (MoveCount == 0) then
    gcs:send_text(0, "move " .. tostring( MoveCount ))

  else
    gcs:send_text(0, OutText)
  end

  -- -- read normalized input from designated scripting RCx_OPTION
  -- if scripting_rc_1 then
  --   gcs:send_text(0, "Scripting in 1:" .. tostring(scripting_rc_1:norm_input()))
  -- end

  -- -- read switch input from second designated scripting RCx_OPTION
  -- if scripting_rc_2 then
  --   local sw_pos = scripting_rc_2:get_aux_switch_pos()
  --   if sw_pos == 0 then 
  --     gcs:send_text(0, "Scripting switch is low")
  --   elseif sw_pos == 1 then
  --     gcs:send_text(0, "Scripting switch is middle")
  --   else
  --     gcs:send_text(0, "Scripting switch is high")
  --   end
  -- end

  -- -- we can also call functions that are available to RC switches
  -- -- 28 is Relay one
  -- rc:run_aux_function(28, flip_flop)

  -- if (flip_flop == 0) then
  --   flip_flop = 2 -- switch high
  -- else
  --   flip_flop = 0 -- switch low
  -- end


  return update, 1000 -- reschedules the loop
end

return update()