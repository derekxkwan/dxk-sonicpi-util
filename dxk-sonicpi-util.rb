require "~/rubystuff/morse_gem/lib/morse.rb"
require "~/rubystuff/dxk-ruby-ext/dxk-array_ext.rb"


load_synthdefs "~/spistuff/dxk-spisynths/compiled"

define :beat_transport do |enable = true, bpm = 120, beats_per_meas = 4, meas_per_phrase = 4, meas_per_sub = -1, debug = true|
  if enable == true
    puts "start transport"
    cur_beats = beats_per_meas.kind_of?(Array) ? beats_per_meas : [beats_per_meas]
    cur_phrase = cur_beats.length <= 1 ? cur_beats * meas_per_phrase : cur_beats
    if meas_per_sub <= 0
      meas_per_sub = (cur_beats.length / 2).to_i
    end
    cur_sub = meas_per_sub.kind_of?(Array) ? meas_per_sub : [meas_per_sub]
    cur_subidx = cur_sub.inject([0]){|r, i| r << r.last.to_i + i}
    live_loop :tp_master do
      use_bpm bpm
      cur_phrase.each_with_index do |num_beats, m|
        set :tp_m, m
        cue :phrase if m == 0
        cue :meas
        cue :half if cur_subidx.include?(m)
        num_beats.times do |i|
          set :tp_b, i
          cue :beat
          puts [m,i] if debug == true
          cue :odd if (i + 1) % 2 == 0
          cue :even if (i % 2) == 0
          sleep 1
        end
      end
    end
  else
    puts "stop transport"
    live_loop :phrase do
      stop
    end
  end
end

define :ramp_var do |to_ramp, to_val = 0, ramp_time = 1, grain = 0.125|
  if to_ramp.is_a? Symbol
    thread_sym = (to_ramp.to_s + "_rampthread").to_sym
    cur_val = get[to_ramp]
    cur_diff = to_val - cur_val
    num_steps = (ramp_time.to_f/grain.to_f).round
    act_grain = ramp_time.to_f/num_steps.to_f
    step_size = cur_diff.to_f/num_steps.to_f
    in_thread(name: thread_sym) do stop end
    if cur_diff != 0
      in_thread(name: thread_sym) do
        print "ramping " + to_ramp.to_s + " to " + to_val.to_s + " in " +  ramp_time.to_s + " seconds" 
        num_steps.times do |i|
          new_val = cur_val + (i * step_size)
          set to_ramp, new_val
          sleep act_grain
        end
        set to_ramp, to_val
        print "finished ramping " + to_ramp.to_s
        end
      end
    end
  end
      
 define :midicps do |midinote|
   440 * 2 ** ((midinote-69)/12.0)
 end

define :cpsmidi do |cps|
  12 * Math.log2(cps/440.0) + 60
end


set :sndfld, "/home/dxk/sounds/"
