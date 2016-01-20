#!/usr/bin/env python
#-*- coding: UTF-8 -*-

# autor: Carlos Rueda
# fecha: 2015-01-20
# mail: crueda@gmail.com

import time
import datetime
import os 
import smtplib

SMTP_SERVER = 'smtp.gmail.com'
SMTP_PORT = 587
 
sender = 'cursocfie.raspberry1@gmail.com'
password = 'cursocfie1'
recipient = 'crueda@gmail.com'
subject = 'Alerta de temperatura'
body = 'Temperatura actual: '
 
body = "" + body + ""
 
headers = ["From: " + sender,
           "Subject: " + subject,
           "To: " + recipient,
           "MIME-Version: 1.0",
           "Content-Type: text/html"]
headers = "\r\n".join(headers)

hora_actual = time.strftime("20%y%m%d%H%M%S", time.localtime())

fichero = open('/var/www/sensores/temperatura_actual.log', 'rb')

for line in fichero:
	temp_actual = float(line)

if (temp_actual<18 or temp_actual>24):
	session = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
 
	session.ehlo()
	session.starttls()
	session.ehlo
	session.login(sender, password)
	 
	session.sendmail(sender, recipient, headers + "\r\n\r\n" + hora_actual + " -> " + body + str(temp_actual))
	session.quit()

fichero.close
