#!/usr/bin/env python
 
import os
import xively
import subprocess
import time
import datetime
import requests
 

# extract feed_id and api_key from environment variables
#FEED_ID = os.environ["FEED_ID"]
#API_KEY = os.environ["API_KEY"]
#DEBUG = os.environ["DEBUG"] or false 
 
FEED_ID = '1371410789'
API_KEY = '6dMcYoRe0qvvB9CFiVeovGCdyJFhWmnGgCjtvdp6uVdpOwNo'
DEBUG = 'true'
 
# initialize api client
api = xively.XivelyAPIClient(API_KEY)
 
# function to read 1 minute load average from system uptime command
def read_loadavg():
  if DEBUG:
    print "Reading load average"
  #return subprocess.check_output(["awk '{print $1}' /proc/loadavg"], shell=True)
  fichero = open('/var/www/sensores/temperatura_actual.log', 'rb')
  for line in fichero:
    return line

# function to return a datastream object. This either creates a new datastream,
# or returns an existing one
def get_datastream(feed):
  try:
    datastream = feed.datastreams.get("Temperatura_salon")
    if DEBUG:
      print "Found existing datastream"
    return datastream
  except:
    if DEBUG:
      print "Creating new datastream"
    datastream = feed.datastreams.create("Temperatura_salon", tags="load_01")
    return datastream
 
# main program entry point - runs continuously updating our datastream with the
# current 1 minute load average
def run():
  #print "Starting Xively tutorial script"
 
  feed = api.feeds.get(FEED_ID)
 
  datastream = get_datastream(feed)
  datastream.max_value = None
  datastream.min_value = None
 
  load_avg = read_loadavg()
 
  if DEBUG:
    print "Updating Xively feed with value: %s" % load_avg
 
  datastream.current_value = load_avg
  datastream.at = datetime.datetime.utcnow()
  try:
    datastream.update()
  except requests.HTTPError as e:
    print "HTTPError({0}): {1}".format(e.errno, e.strerror)
 
  time.sleep(10)
 
run()
