# live_loop organization idea from https://www.youtube.com/watch?v=vuSZQnkOB_Y
use_bpm 130

live_loop :met1 do
  sleep 1
end

define :pattern do |pattern|
  return pattern.ring.tick == "x"
end

live_loop :kick, sync: :met1 do
  # stop
  a = 3
  sample "bd_tek", amp: a if pattern "x-----x---x--x--"
  sleep 0.25
end

live_loop :clap, sync: :met1 do
  # stop
  sleep 1
  sample :perc_snap2
  sleep 1
end

live_loop :hhc, sync: :met1 do
  # stop
  sample :drum_cymbal_closed if pattern "x-x-x-x-xxx-x-x-"
  sleep 0.125
end

live_loop :hh0, sync: :met1 do
  # stop
  sleep 0.5
  sample :glitch_bass_g
  sleep 0.5
end
