#!/usr/bin/env python
import pyowm
import os

API_key = "229c25e22cfd9c434134d5c88a1ae588"
owm = pyowm.OWM(API_key, language='de')

owm.is_API_online()
observation = owm.weather_at_place("Gerbrunn,de")
w = observation.get_weather()

with open("/tmp/weather.txt", "w") as weather_file:
    weather_file.write(
        "{} {}°C; {}%h, Wind: {}m/s, {}°C - {}°C\n".format(
            w.get_detailed_status(),
            w.get_temperature(unit="celsius")["temp"],
            w.get_humidity(),
            w.get_wind()["speed"],
            w.get_temperature(unit="celsius")["temp_min"],
            w.get_temperature(unit="celsius")["temp_max"]))

    weather_file.close()
