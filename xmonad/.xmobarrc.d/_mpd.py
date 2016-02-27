#!/usr/bin/env python2

import mpd

def mpdConnect(client, con_id):
	try:
		client.connect(**con_id)
	except SocketError:
		return False
	return True

client = mpd.MPDClient()
if mpdConnect(client, {'host':'localhost', 'port':'6600'}):
	# Grab data
	status = client.status()
	currentsong = client.currentsong()
	state = status['state']

	# Print message
	if state == 'pause':
		artist = currentsong['artist']
		if len(artist) > 20:
			artist = artist[:17] + "..."
		title = currentsong['title']
		if len(title) > 30:
			title = title[:27] + "..."
		print(artist + "<fc=#7f7f7f>:</fc> " + title + " <fc=#00ff00>PAUSED</fc>")
	elif state == 'play':
		artist = currentsong['artist']
		if len(artist) > 20:
			artist = artist[:17] + "..."
		title = currentsong['title']
		if len(title) > 30:
			title = title[:27] + "..."
		time = status['time']
		start = int(time.split(':')[0])
		end = int(time.split(':')[1])
		position = str(start/60) + ':'
		if start%60 < 10:
			position += '0'
		position += str(start%60) + '/' + str(end/60) + ':'
		if end%60 < 10:
			position += '0'
		position += str(end%60)
		print(artist + "<fc=#7f7f7f>:</fc> " + title + " <fc=#00ff00>" + position + "</fc>")
	else:
		print('<fc=#7f7f7f>-MPD-</fc>')
else:
	print('<fc=#7f7f7f>-MPD-</fc>')


"""
#!/usr/bin/env python
import re
import subprocess

mpc_info = subprocess.Popen(['mpc', '-f', '%artist%\n%title%'], stdout=subprocess.PIPE).communicate()[0].split('\n')

if len(mpc_info) == 5:
	artist = mpc_info[0]
	track = mpc_info[1]
	if len(artist) > 20:
		artist = artist[:17] + "..."
	if len(track) > 30:
		track = track[:27] + "..."
	position = re.search(r"[0-9]+:[0-9]+/[0-9]+:[0-9]+", mpc_info[2]).group(0)
	paused = re.search(r"\[(.*?)\]", mpc_info[2]).group(1)
	if paused == "paused":
		print(artist + "<fc=#7f7f7f>:</fc> " + track + " <fc=#00ff00>PAUSED</fc>")
	else:
		print(artist + "<fc=#7f7f7f>:</fc> " + track + " <fc=#00ff00>" + position + "</fc>")
else:
	print("<fc=#7f7f7f>-MPD-</fc>")
"""
