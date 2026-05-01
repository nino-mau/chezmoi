#!/usr/bin/env bash

location_input=${*:-Grenoble France}
display_location=${location_input//+/ }
query_location=${display_location// /+}
normalized_location=$(printf '%s' "$display_location" | tr '[:upper:]' '[:lower:]' | tr ',' ' ' | tr -s '[:space:]' ' ')

json_escape() {
  local value=$1
  value=${value//\\/\\\\}
  value=${value//\"/\\\"}
  value=${value//$'\n'/\\n}
  value=${value//$'\r'/}
  printf '%s' "$value"
}

emit_weather_json() {
  printf '{"text":"%s","alt":"%s","tooltip":"%s"}\n' \
    "$(json_escape "$1")" \
    "$(json_escape "$2")" \
    "$(json_escape "$3")"
}

icon_from_condition() {
  case "$1" in
  *thunder*)
    printf ''
    ;;
  *sleet* | *freezing\ drizzle* | *freezing\ rain* | *ice\ pellets*)
    printf ''
    ;;
  *blizzard* | *heavy\ snow* | *moderate\ snow*)
    printf ''
    ;;
  *snow*)
    printf ''
    ;;
  *torrential* | *heavy\ rain* | *moderate\ rain*)
    printf ''
    ;;
  *rain* | *drizzle* | *shower*)
    printf ''
    ;;
  *mist* | *fog* | *haze*)
    printf ''
    ;;
  *overcast*)
    printf ''
    ;;
  *partly\ cloudy*)
    printf ''
    ;;
  *cloud*)
    printf ''
    ;;
  *clear* | *sunny*)
    printf ''
    ;;
  *)
    printf ''
    ;;
  esac
}

emit_meteofrance_weather() {
  local latitude=$1
  local longitude=$2
  local weather_json temperature apparent_temperature weather_code is_day wind_speed
  local icon condition text_temperature detail_temperature detail_apparent detail_wind

  command -v jq >/dev/null 2>&1 || return 1

  weather_json=$(curl -fsS --retry 2 --retry-delay 1 --retry-all-errors --max-time 10 "https://api.open-meteo.com/v1/meteofrance?latitude=${latitude}&longitude=${longitude}&current=temperature_2m,apparent_temperature,weather_code,is_day,wind_speed_10m&models=meteofrance_seamless" 2>/dev/null) || return 1

  temperature=$(jq -er '.current.temperature_2m' <<<"$weather_json") || return 1
  apparent_temperature=$(jq -er '.current.apparent_temperature' <<<"$weather_json") || return 1
  weather_code=$(jq -er '.current.weather_code' <<<"$weather_json") || return 1
  is_day=$(jq -er '.current.is_day' <<<"$weather_json") || return 1
  wind_speed=$(jq -er '.current.wind_speed_10m' <<<"$weather_json") || return 1

  case "$weather_code" in
  0)
    condition="Clear sky"
    icon=""
    ;;
  1)
    condition="Mainly clear"
    icon=""
    ;;
  2)
    condition="Partly cloudy"
    icon=""
    ;;
  3)
    condition="Overcast"
    icon=""
    ;;
  45 | 48)
    condition="Fog"
    icon=""
    ;;
  51 | 53 | 55)
    condition="Drizzle"
    icon=""
    ;;
  56 | 57)
    condition="Freezing drizzle"
    icon=""
    ;;
  61 | 63 | 65)
    condition="Rain"
    icon=""
    ;;
  66 | 67)
    condition="Freezing rain"
    icon=""
    ;;
  71 | 73 | 75 | 77)
    condition="Snow"
    icon=""
    ;;
  80 | 81 | 82)
    condition="Rain showers"
    icon=""
    ;;
  85 | 86)
    condition="Snow showers"
    icon=""
    ;;
  95 | 96 | 99)
    condition="Thunderstorm"
    icon=""
    ;;
  *)
    condition="Unknown"
    icon=""
    ;;
  esac

  if [[ "$is_day" -eq 0 && "$weather_code" -eq 0 ]]; then
    icon=""
  fi

  text_temperature=$(LC_NUMERIC=C printf '%.0f°C' "$temperature")
  detail_temperature=$(LC_NUMERIC=C printf '%.1f°C' "$temperature")
  detail_apparent=$(LC_NUMERIC=C printf '%.1f°C' "$apparent_temperature")
  detail_wind=$(LC_NUMERIC=C printf '%.1f km/h' "$wind_speed")

  emit_weather_json \
    "${icon} ${text_temperature}" \
    "meteo-france-${weather_code}" \
    "${display_location}: ${detail_temperature}, feels like ${detail_apparent}, wind ${detail_wind}, ${condition} (Meteo-France via Open-Meteo)"
}

if [[ "$normalized_location" == "grenoble" || "$normalized_location" == "grenoble france" ]]; then
  if emit_meteofrance_weather 45.1885 5.7245; then
    exit 0
  fi
fi

if [[ "$normalized_location" == "meylan" || "$normalized_location" == "meylan france" ]]; then
  if emit_meteofrance_weather 45.20978 5.77762; then
    exit 0
  fi
fi

if ! weather=$(curl -fsS --retry 2 --retry-delay 1 --retry-all-errors --max-time 10 "https://wttr.in/${query_location}?format=%C|%t" 2>/dev/null); then
  printf '{"text":"%s","alt":"%s","tooltip":"%s"}\n' \
    "$(json_escape ' N/A')" \
    "$(json_escape 'unavailable')" \
    "$(json_escape "${display_location}: unavailable")"
  exit 0
fi

condition=${weather%%|*}
temperature=${weather#*|}
temperature=${temperature//$'\r'/}
temperature=${temperature#+}
condition_key=$(printf '%s' "$condition" | tr '[:upper:]' '[:lower:]')
icon=$(icon_from_condition "$condition_key")

emit_weather_json "${icon} ${temperature}" "$condition_key" "${display_location}: ${temperature} ${condition}"
