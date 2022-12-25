# 221207 2321 First snow (big reverb and piano)
# Saved 221207 2321
# Backup
# Created by https://linktr.ee/relaxnow
# YT performance https://youtu.be/oYaj2SwMYCo
# https://in-thread.sonic-pi.net/t/first-snow-big-reverb-and-piano/7327

with_fx :reverb, room: 0.99,damp: 0.99 do
  live_loop :asdas do
    tick
    
    use_synth :piano
    
    # orignal
    p1 = [:c3, :ds4, :g5]
    p2 = [:c3, :ds4, :f5]
    p3 = [:c3, :ds4, :ds5]
    
    a = 4
    pia = knit(p1,a,p2,a,p3,a*2).look
    play pia if bools(1,0,0,0,0).look
    
    
    use_synth :sine
    amp = range(0.25,1,step: 0.05).reflect.look
    play :c2, amp: amp+0.1 if bools(0,1,0,0,0).look
    use_synth :tri#:dsaw #:pulse
    
    
    #solo note
    play :c5, amp: amp-0.2, release: rrand(0.07,0.2), pan: rdist(0.5) if bools(0,0,0,1,1).look
    # play :g6, amp: amp-0.2, release: rrand(0.07,0.08), pan: rdist(0.5) if bools(0,0,0,1,1).look
    
    sample :elec_tick if spread(2,4).look
    sample :drum_cymbal_pedal, rate: [1,2,4].choose if bools(0,0,0,0,0,0,1).look
    sleep 1
  end
  
  live_loop :arp do
    use_synth :beep
    use_synth_defaults release: 0.2, amp: 0.5
    tick
    
    #works
    play [:c4,:ds4,:g5].look if bools(1,1,1,0,0,0,0,1,1,1,0,0,0,0,0).look
    #    play [:c4,:ds4,:f5].look if bools(1,1,1,0,0,0,0,1,1,1,0,0,0,0,0).look
    #    play [:c4,:ds4,:ds5].look if bools(1,1,1,0,0,0,0,1,1,1,0,0,0,0,0).look
    sleep 0.25
  end
  
end



live_loop :kick do
  tick
  
  / kick 1/
  ###  #sample :bd_fat, amp: 2 if spread(1,7).look # original 14 beats  sleep 0.5
  sample :bd_fat, amp: 2 if bools(1,0,0,0,0,0,0, 0,0,0,0,0,0,0).look  # 14 beats
  
  / kick 2 /
  #  sample :bd_fat, amp: 2 if bools(1,0,0,0,0,0,0).look
  # sample :bd_fat, amp: 2 if bools(1,0,0,0,0,0,0, 0,0,0,0,0,0,0,0).look  # 15 beats
  
  sleep 0.25
end