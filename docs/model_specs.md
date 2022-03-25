# Model Specs

## Location

| Property      | Type                |
|---------------|---------------------|
| `id`          | `Int`               |
| `name`        | `String`            |
| `region`      | `String` (optional) |
| `country`     | `String` (optional) |
| `lat`	        | `Double`            |
| `lon`	        | `Double`            |

## Payload contract

GET http://api.weatherapi.com/v1/search.json?key=:KEY&q=:QUERY (TBD)

200 RESPONSE

```json
[
    {
        "id": 2801268,
        "name": "London",
        "region": "City of London, Greater London",
        "country": "United Kingdom",
        "lat": 51.52,
        "lon": -0.11,  
    },
    {
        "id": 2796590,
        "name": "Holborn",
        "region": "Camden, Greater London",
        "country": "United Kingdom",
        "lat": 51.52,
        "lon": -0.12,
    }
]
```



## Weather

| Property      | Type                |
|---------------|---------------------|
| `location`    | `Location`          |
| `current`     | `Current`           |
| `forcast`     | `Forcast`           |

## Payload contract

GET http://api.weatherapi.com/v1/forecast.json?key=:KEY&q=:QUERY&days=1&aqi=no&alerts=no (TBD)

200 RESPONSE

```json
{
    "location": {
        "name": "London",
        "region": "City of London, Greater London",
        "country": "United Kingdom",
        "lat": 51.52,
        "lon": -0.11,
        "tz_id": "Europe/London",
        "localtime_epoch": 1648210482,
        "localtime": "2022-03-25 12:14"
    },
    "current": {
        "last_updated_epoch": 1648206000,
        "last_updated": "2022-03-25 11:00",
        "temp_c": 16.0,
        "temp_f": 60.8,
        "is_day": 1,
        "condition": {
            "text": "Sunny",
            "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
            "code": 1000
        },
        "wind_mph": 11.9,
        "wind_kph": 19.1,
        "wind_degree": 80,
        "wind_dir": "E",
        "pressure_mb": 1032.0,
        "pressure_in": 30.47,
        "precip_mm": 0.0,
        "precip_in": 0.0,
        "humidity": 45,
        "cloud": 0,
        "feelslike_c": 16.0,
        "feelslike_f": 60.8,
        "vis_km": 10.0,
        "vis_miles": 6.0,
        "uv": 5.0,
        "gust_mph": 7.8,
        "gust_kph": 12.6
    },
    "forecast": {
        "forecastday": [
            {
                "date": "2022-03-25",
                "date_epoch": 1648166400,
                "day": {
                    "maxtemp_c": 17.8,
                    "maxtemp_f": 64.0,
                    "mintemp_c": 7.5,
                    "mintemp_f": 45.5,
                    "avgtemp_c": 12.1,
                    "avgtemp_f": 53.8,
                    "maxwind_mph": 9.6,
                    "maxwind_kph": 15.5,
                    "totalprecip_mm": 0.0,
                    "totalprecip_in": 0.0,
                    "avgvis_km": 10.0,
                    "avgvis_miles": 6.0,
                    "avghumidity": 54.0,
                    "daily_will_it_rain": 0,
                    "daily_chance_of_rain": 0,
                    "daily_will_it_snow": 0,
                    "daily_chance_of_snow": 0,
                    "condition": {
                        "text": "Sunny",
                        "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                        "code": 1000
                    },
                    "uv": 4.0
                },
                "astro": {
                    "sunrise": "05:52 AM",
                    "sunset": "06:22 PM",
                    "moonrise": "02:41 AM",
                    "moonset": "09:41 AM",
                    "moon_phase": "Last Quarter",
                    "moon_illumination": "42"
                },
                "hour": [
                    {
                        "time_epoch": 1648166400,
                        "time": "2022-03-25 00:00",
                        "temp_c": 9.9,
                        "temp_f": 49.8,
                        "is_day": 0,
                        "condition": {
                            "text": "Clear",
                            "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                            "code": 1000
                        },
                        "wind_mph": 4.0,
                        "wind_kph": 6.5,
                        "wind_degree": 65,
                        "wind_dir": "ENE",
                        "pressure_mb": 1030.0,
                        "pressure_in": 30.43,
                        "precip_mm": 0.0,
                        "precip_in": 0.0,
                        "humidity": 52,
                        "cloud": 9,
                        "feelslike_c": 9.2,
                        "feelslike_f": 48.6,
                        "windchill_c": 9.2,
                        "windchill_f": 48.6,
                        "heatindex_c": 9.9,
                        "heatindex_f": 49.8,
                        "dewpoint_c": 0.6,
                        "dewpoint_f": 33.1,
                        "will_it_rain": 0,
                        "chance_of_rain": 0,
                        "will_it_snow": 0,
                        "chance_of_snow": 0,
                        "vis_km": 10.0,
                        "vis_miles": 6.0,
                        "gust_mph": 7.6,
                        "gust_kph": 12.2,
                        "uv": 1.0
                    },
                    {
                        "time_epoch": 1648170000,
                        "time": "2022-03-25 01:00",
                        "temp_c": 9.5,
                        "temp_f": 49.1,
                        "is_day": 0,
                        "condition": {
                            "text": "Clear",
                            "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                            "code": 1000
                        },
                        "wind_mph": 4.0,
                        "wind_kph": 6.5,
                        "wind_degree": 72,
                        "wind_dir": "ENE",
                        "pressure_mb": 1030.0,
                        "pressure_in": 30.42,
                        "precip_mm": 0.0,
                        "precip_in": 0.0,
                        "humidity": 56,
                        "cloud": 4,
                        "feelslike_c": 8.8,
                        "feelslike_f": 47.8,
                        "windchill_c": 8.8,
                        "windchill_f": 47.8,
                        "heatindex_c": 9.5,
                        "heatindex_f": 49.1,
                        "dewpoint_c": 1.2,
                        "dewpoint_f": 34.2,
                        "will_it_rain": 0,
                        "chance_of_rain": 0,
                        "will_it_snow": 0,
                        "chance_of_snow": 0,
                        "vis_km": 10.0,
                        "vis_miles": 6.0,
                        "gust_mph": 7.6,
                        "gust_kph": 12.2,
                        "uv": 1.0
                    }
                ]
            }
        ]
    }
}
```

### Current

| Property      		| Type          |
|-----------------------|---------------|
| `last_updated_epoch`  | `Int`         |
| `last_updated`    	| `String`      |
| `temp_c`    			| `Int`         |
| `temp_f`    			| `Double`      |
| `is_day`    			| `Bool`        |
| `feelslike_c`    		| `Int`         |
| `feelslike_f`    		| `Double`      |
| `condition`   		| `Condition`   |

### Condition

| Property  | Type      |
|-----------|-----------|
| `text`	| `String`  |
| `icon`    | `String`  |

### Forecast

| Property      | Type                |
|---------------|---------------------|
| `location`    | `Location`          |
| `current`     | `Weather`           |
| `forcast`     | `Forcast`           |

