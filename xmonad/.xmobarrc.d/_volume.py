import re
import subprocess

master = str(subprocess.check_output(['amixer', 'get', 'Master']), 'utf-8')
mute = (re.search(r"\[(off|on)\]", master).group(0) == '[off]')
volume = int(re.search(r"\[([0-9]+)%\]", master).group(1))
if mute:
	print('<fc=#ffffff>Volume: MUTE</fc>')
else:
	print('<fc=#ffffff>Volume: ' + str(volume) + '</fc>')
