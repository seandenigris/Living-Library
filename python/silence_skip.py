# Extends python-mpv's MPV class. References: 
#   - project: https://github.com/jaseg/python-mpv
#   - MPV class: https://github.com/jaseg/python-mpv/blob/0cda09c62872542b4b8427aaaa9600b8fd8d7d2f/mpv.py#L793
# Adapted from https://gist.github.com/bitingsock/e8a56446ad9c1ed92d872aeb38edf124 via lots of experimentation
# There is also this interesting approach: https://github.com/idMysteries/mpv-skip-silence/blob/main/autoeditor.js
import mpv

def position_from_silencedetect_message(msgText):
  tokens = msgText.split()

  # Testing not in set adapted from https://stackoverflow.com/a/17902498
  if not tokens[1] == 'silence_end:' or tokens[1] == 'silence_start:':
    raise  Exception("Not a silencedetect message") # Adapted from https://www.w3schools.com/python/ref_keyword_raise.asp
  return float(tokens[2]) #String to number conversion adapted from https://www.geeksforgeeks.org/convert-string-to-integer-in-python/

## Add a method to MPV
## Technique adapted from https://stackoverflow.com/a/2982
# Define method
def skip_silence(self):
  # Event callback adapted from https://github.com/jaseg/python-mpv/blob/0cda09c62872542b4b8427aaaa9600b8fd8d7d2f/mpv.py#L1454
  @self.event_callback('log-message')
  def my_handler(event):
    #print("POS: %f SPEED: %d" % (self.time_pos, self.speed))
    eventText = event['event']['text']
    if not eventText.startswith('silencedetect:'):
      return
    if eventText.find("silence_start") >= 0:
      print("SILENCE START:" + eventText)
    elif eventText.find("silence_end") >= 0:
      my_handler.unregister_mpv_events()
      self.speed = 1
      print("SILENCE END:" + eventText)
      newPos = position_from_silencedetect_message(eventText)
      self.time_pos = newPos
      print("POS: %f SPEED: %d" % (self.time_pos, self.speed))

  self.af = 'lavfi=[silencedetect=n=-20dB:d=1]'
  self.speed = 100 #100 is apparently the max, passing 101+ -> "TypeError: ('Tried to get/set mpv property using wrong format, or passed invalid value'..."
  print("SPEED: %d" % self.speed)
  #self.wait_for_playback()
  self.wait_for_property('speed', lambda a : a == 1)

# Install method
mpv.MPV.skip_silence = skip_silence
