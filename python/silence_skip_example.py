#Kill w ctrl-c

import os
import silence_skip

file_path = os.path.dirname(os.path.realpath(__file__))

import mpv

player = mpv.MPV(loglevel='v')

player.play(file_path + "/sample_w_silence.m4a")

player.skip_silence()
print('done pos: %f' % player.time_pos)
player.wait_for_property('time-pos', lambda a : (not a is None) and (a >= 11))
print('waited')
player.skip_silence()
print('done2')
player.wait_for_playback()
