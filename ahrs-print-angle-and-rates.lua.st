-- for first our template for final exam?
-- This script displays the vehicle lean angles and rotation rates at 1hz
function update() -- this is the loop which periodically runs
  roll = math.deg(ahrs:get_roll())
  pitch = math.deg(ahrs:get_pitch())
  yaw = math.deg(ahrs:get_yaw())
  rates = ahrs:get_gyro()
  
  if rates then
    roll_rate = math.deg(rates:x())
    pitch_rate = math.deg(rates:y())
    yaw_rate = math.deg(rates:z())
  else
    roll_rate = 0
    pitch_rate = 0
    yaw_rate = 0
  end

  -- 速度設定（うまく行っていない？）
  local target_vel = Vector3f()
  target_vel:x(1)
  target_vel:y(1)
  target_vel:z(1)
  if not (vehicle:set_target_velocity_NED(target_vel)) then
    gcs:send_text(0, "failed to execute velocity command")
  end

    -- モードの取得
  local mode = vehicle:get_mode()
  gcs:send_text(0, string.format("Mode: %s", mode))
  
  --　モード変更
  -- CIRCLE =        7,  // automatic circular flight with automatic throttle
  if not (mode == 7) then
  
    local modeChange = 7
    vehicle:set_mode(modeChange)
      
  end




  gcs:send_text(0, string.format("Ang R:%.1f P:%.1f Y:%.1f Rate R:%.1f P:%.1f Y:%.1f", roll, pitch, yaw, roll_rate, pitch_rate, yaw_rate))
  return update, 1000 -- reschedules the loop
end

return update() -- run immediately before starting to reschedule
