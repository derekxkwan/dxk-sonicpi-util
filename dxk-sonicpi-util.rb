require "~/rubystuff/dxk_ruby_ext/dxk_array_ext.rb"


def beat_transport(enable = true, bpm = 120, beats_per_meas = 4, meas_per_phrase = 4, meas_per_half = 2)
  cur_phrasebeats = meas_per_phrase * beats_per_meas
  cur_halfbeats = meas_per_half * beats_per_meas
  puts "start transport"
  if enable
    in_thread(name: :beat_transporter) do
      loop do
        use_bpm bpm
        cur_phrasebeats.times do |i|
          cue :beat
        if i % beats_per_meas == 0
          cue :meas
        end
        if i % cur_halfbeats == 0
          cue :half
        end
        sleep 1
        end
      end
    end
  else
    puts "stop transport"
    in_thread(name: :beat_transporter) do
      stop
    end
  end
end

def ramp_var(to_ramp, to_val = 0, ramp_time = 1, grain = 0.125)
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
      
        
     




