# dxk-sonicpi-util
some utility functions for use with sonic-pi


- (ignore/comment out the top line if you wish as it is for importing my [Ruby array extensions](https://github.com/derekxkwan/dxk_ruby_ext))
- (also ignore/comment out the `load_synthdefs` line if you want as it is for loading my [custom synthdefs](https://github.com/derekxkwan/dxk-spisynths))

## FUNCTIONS
- **beat_transport**: a psuedo-transport-type-thing for syncs and cues
    - args: enable = true, bpm = 120, beats_per_meas = 4, meas_per_phrase = 4, meas_per_half = 2
- **ramp_var**: ramps sonic-pi variables
    - args: to_ramp, to_val = 0, ramp_time = 1, grain = 0.125


