# dxk-sonicpi-util
some utility functions for use with sonic-pi

## CAN IGNORE
- ignore/comment out the top line if you wish as it is for importing my [Ruby array extensions](https://github.com/derekxkwan/dxk_ruby_ext)
- also ignore/comment out the `load_synthdefs` line if you want as it is for loading my [custom synthdefs](https://github.com/derekxkwan/dxk-spisynths)
- there's also a [Morse utility class](https://github.com/derekxkwan/morse_gem) you can also prob ignore if you want

## FILES
### dxk-sonicpi-util
#### FUNCTIONS
- **beat_transport**: a psuedo-transport-type-thing for syncs and cues
    - args: enable = true, bpm = 120, beats_per_meas = 4, meas_per_phrase = 4, meas_per_half = 2
- **ramp_var**: ramps sonic-pi variables
    - args: to_ramp, to_val = 0, ramp_time = 1, grain = 0.125
- **dur_subdiv**: divides an array of values into requested subdivisions
  - args: input array, main duration = 0.5, subdivision = 0.25
  - example: [1.5, 1] with main duration of 0.5 and subdivision of 0.25 = [[0.5, 0.25, 0.25, 0.25, 0.25], [0.5, 0.25, 0.25]]
### dxk-sonicpi-methods
essentially pseudo-macros for use with `beat_transport` and a defined bpm  (set :bpm, heresmybpm) to reduce typing
#### FUNCTIONS
- **tp_syncloop**: wraps around live_loop, sync: and use_bpm
  - args: loopname, sync symbol
- **tp_loop**: wraps around live_loop and use_bpm
  - args: loopname
- **tp_thread**: wraps around in_thread and use_bpm
- **tp_syncthread**: wraps around in_thread, sync and use_bpm
  - args: sync symbol


