#!/usr/bin/env bash

location=${*:-Grenoble France}
location=${location// /+}

if ! weather=$(curl -fsS --max-time 10 "https://wttr.in/${location}?format=%C|%t" 2>/dev/null); then
  printf ' N/A\n'
  exit 0
fi

condition=${weather%%|*}
temperature=${weather#*|}
temperature=${temperature//$'\r'/}
temperature=${temperature#+}
condition_key=$(printf '%s' "$condition" | tr '[:upper:]' '[:lower:]')

case "$condition_key" in
*thunder*)
  icon=""
  ;;
*sleet* | *freezing\ drizzle* | *freezing\ rain* | *ice\ pellets*)
  icon=""
  ;;
*blizzard* | *heavy\ snow* | *moderate\ snow*)
  icon=""
  ;;
*snow*)
  icon=""
  ;;
*torrential* | *heavy\ rain* | *moderate\ rain*)
  icon=""
  ;;
*rain* | *drizzle* | *shower*)
  icon=""
  ;;
*mist* | *fog* | *haze*)
  icon=""
  ;;
*overcast*)
  icon=""
  ;;
*partly\ cloudy*)
  icon=""
  ;;
*cloud*)
  icon=""
  ;;
*clear* | *sunny*)
  icon=""
  ;;
*)
  icon=""
  ;;
esac

printf '%s %s\n' "$icon" "$temperature"
