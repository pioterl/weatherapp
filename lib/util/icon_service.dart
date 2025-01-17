import 'package:weatherapp/model/weather.dart';

class IconService {
  static String getIconHourly(Weather weather, int index) {
    final Map<String, String> iconMap = mapIcon();

    return iconMap[weather.timeseries[index].icon_1h] ??
        "assets/weather_symbols/na.png";
  }

  static String getIconDaily(String icon) {
    final Map<String, String> iconMap = mapIcon();
    return iconMap[icon] ?? "assets/weather_symbols/na.png";
  }

  static Map<String, String> mapIcon() {
    return {
      "clearsky_day": "assets/weather_symbols/01d.png",
      "clearsky_night": "assets/weather_symbols/01n.png",
      "clearsky_polartwilight": "assets/weather_symbols/01m.png",
      "fair_day": "assets/weather_symbols/02d.png",
      "fair_night": "assets/weather_symbols/02n.png",
      "fair_polartwilight": "assets/weather_symbols/02m.png",
      "partlycloudy_day": "assets/weather_symbols/03d.png",
      "partlycloudy_night": "assets/weather_symbols/03n.png",
      "partlycloudy_polartwilight": "assets/weather_symbols/03m.png",
      "cloudy": "assets/weather_symbols/04.png",
      "rainshowers_day": "assets/weather_symbols/05d.png",
      "rainshowers_night": "assets/weather_symbols/05n.png",
      "rainshowers_polartwilight": "assets/weather_symbols/05m.png",
      "rainshowersandthunder_day": "assets/weather_symbols/06d.png",
      "rainshowersandthunder_night": "assets/weather_symbols/06n.png",
      "rainshowersandthunder_polartwilight": "assets/weather_symbols/06m.png",
      "sleetshowers_day": "assets/weather_symbols/07d.png",
      "sleetshowers_night": "assets/weather_symbols/07n.png",
      "sleetshowers_polartwilight": "assets/weather_symbols/07m.png",
      "snowshowers_day": "assets/weather_symbols/08d.png",
      "snowshowers_night": "assets/weather_symbols/08n.png",
      "snowshowers_polartwilight": "assets/weather_symbols/08m.png",
      "rain": "assets/weather_symbols/09.png",
      "heavyrain": "assets/weather_symbols/10.png",
      "heavyrainandthunder": "assets/weather_symbols/11.png",
      "sleet": "assets/weather_symbols/12.png",
      "snow": "assets/weather_symbols/13.png",
      "snowandthunder": "assets/weather_symbols/14.png",
      "fog": "assets/weather_symbols/15.png",
      "sleetshowersandthunder_day": "assets/weather_symbols/20d.png",
      "sleetshowersandthunder_night": "assets/weather_symbols/20n.png",
      "sleetshowersandthunder_polartwilight": "assets/weather_symbols/20m.png",
      "snowshowersandthunder_day": "assets/weather_symbols/21d.png",
      "snowshowersandthunder_night": "assets/weather_symbols/21n.png",
      "snowshowersandthunder_polartwilight": "assets/weather_symbols/21m.png",
      "rainandthunder": "assets/weather_symbols/22.png",
      "sleetandthunder": "assets/weather_symbols/23.png",
      "lightrainshowersandthunder_day": "assets/weather_symbols/24d.png",
      "lightrainshowersandthunder_night": "assets/weather_symbols/24n.png",
      "lightrainshowersandthunder_polartwilight":
          "assets/weather_symbols/24m.png",
      "heavyrainshowersandthunder_day": "assets/weather_symbols/25d.png",
      "heavyrainshowersandthunder_night": "assets/weather_symbols/25n.png",
      "heavyrainshowersandthunder_polartwilight":
          "assets/weather_symbols/25m.png",
      "lightssleetshowersandthunder_day": "assets/weather_symbols/26d.png",
      "lightssleetshowersandthunder_night": "assets/weather_symbols/26n.png",
      "lightssleetshowersandthunder_polartwilight":
          "assets/weather_symbols/26m.png",
      "heavysleetshowersandthunder_day": "assets/weather_symbols/27d.png",
      "heavysleetshowersandthunder_night":
          "assetlightssnowshowersandthunder_nights/weather_symbols/27n.png",
      "heavysleetshowersandthunder_polartwilight":
          "assets/weather_symbols/27m.png",
      "lightssnowshowersandthunder_day": "assets/weather_symbols/28d.png",
      "lightssnowshowersandthunder_night": "assets/weather_symbols/28n.png",
      "lightssnowshowersandthunder_polartwilight":
          "assets/weather_symbols/28m.png",
      "heavysnowshowersandthunder_day": "assets/weather_symbols/29d.png",
      "heavysnowshowersandthunder_night": "assets/weather_symbols/29n.png",
      "heavysnowshowersandthunder_polartwilight":
          "assets/weather_symbols/29m.png",
      "lightrain": "assets/weather_symbols/46.png",
      "lightsnowshowers_night": "assets/weather_symbols/44n.png",
      "lightsleet": "assets/weather_symbols/47.png",
      "heavysleet": "assets/weather_symbols/48.png",
      "lightsnow": "assets/weather_symbols/49.png",
      "heavysnow": "assets/weather_symbols/50.png",
      "heavysnowshowers_day": "assets/weather_symbols/45d.png",
      "heavysnowshowers_night": "assets/weather_symbols/45n.png",
      "heavysnowshowers_polartwilight": "assets/weather_symbols/45m.png",
      "lightsnowshowers_day": "assets/weather_symbols/44d.png",
      "lightsnowshowers_polartwilight": "assets/weather_symbols/44m.png",
      "heavysleetshowers_day": "assets/weather_symbols/43d.png",
      "heavysleetshowers_night": "assets/weather_symbols/43n.png",
      "heavysleetshowers_polartwilight": "assets/weather_symbols/43m.png",
      "lightsleetshowers_day": "assets/weather_symbols/42d.png",
      "lightsleetshowers_night": "assets/weather_symbols/42n.png",
      "lightsleetshowers_polartwilight": "assets/weather_symbols/42m.png",
      "heavyrainshowers_day": "assets/weather_symbols/41d.png",
      "heavyrainshowers_night": "assets/weather_symbols/41n.png",
      "heavyrainshowers_polartwilight": "assets/weather_symbols/41m.png",
      "lightrainshowers_day": "assets/weather_symbols/40d.png",
      "lightrainshowers_night": "assets/weather_symbols/40n.png",
      "lightrainshowers_polartwilight": "assets/weather_symbols/40m.png",
      "heavysnowandthunder": "assets/weather_symbols/34.png",
      "lightsnowandthunder": "assets/weather_symbols/33.png",
      "heavysleetandthunder": "assets/weather_symbols/32.png",
      "lightsleetandthunder": "assets/weather_symbols/31.png",
      "lightrainandthunder": "assets/weather_symbols/30.png",
    };
  }
}
