#!/usr/bin/env python
#-*- coding: UTF-8 -*-

# autor: Carlos Rueda
# fecha: 2015-01-14
# mail: carlos.rueda@deimos-space.com

import tweetpony
import time
import datetime

hora_actual = time.strftime("20%y/%m/%d - %H:%M:%S", time.localtime())

fichero_temp = open('/var/www/sensores/temperatura_actual.log', 'rb')
for line in fichero_temp:
	temp_actual = line

fichero_hum = open('/var/www/sensores/humedad_actual.log', 'rb')
for line in fichero_hum:
	hum_actual = line

api = tweetpony.API(consumer_key = "6EaicoNVcrFuSWdXtSQ", consumer_secret = "3393Vi6IItFioRmfmvNIuB0r0zYHQjZVxd78Yk", access_token = "469243869-zxAMSEsLYFKorOhpn81t14qPPEmGMb3aigR7OeB2", access_token_secret = "WXTKgp85Ed7jK6bHxpzXp8ZAn8l0Tldpc3OeRG6zZ7Tam")
user = api.user

tuit = hora_actual + ": Temperatura->" + temp_actual + " - Humedad->" + hum_actual 

fichero_temp.close
fichero_hum.close

try:
    api.update_status(status = tuit)
except tweetpony.APIError as err:
    print "Oops, something went wrong! Twitter returned error #%i and said: %s" % (err.code, err.description)
else:
    print "Yay! Your tweet has been sent!"
