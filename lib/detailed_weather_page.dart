import 'package:flutter/material.dart';

class HourlyWeather {
  final String time;
  final String temperature;
  final IconData icon;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.icon,
  });
}

List<HourlyWeather> hourlyForecast = [
  HourlyWeather(time: '4 am', temperature: '17°', icon: Icons.wb_cloudy),
  HourlyWeather(time: '5 am', temperature: '16°', icon: Icons.wb_cloudy),
  //... Add more entries for each hour or fetch from an API
];

class DetailedWeatherPage extends StatelessWidget {
  final String location;
  final String temperature;
  final String condition;
  final String feelsLike;
  final String dayTemperature;
  final String nightTemperature;

  const DetailedWeatherPage({
    super.key,
    required this.location,
    required this.temperature,
    required this.condition,
    required this.feelsLike,
    required this.dayTemperature,
    required this.nightTemperature,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.deepPurple,
        child: Column(
          children: [
            const Text(
              '21 October, 3:41 am',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              "$dayTemperature • $nightTemperature",
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                temperature,
                style: const TextStyle(color: Colors.white, fontSize: 100),
              ),
            ),
            Text(
              "Feels like $feelsLike",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              condition,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hourlyForecast.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          hourlyForecast[index].time,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                        Icon(
                          hourlyForecast[index].icon,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          hourlyForecast[index].temperature,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Add the hourly forecast, graph, and other details as required
          ],
        ),
      ),
    );
  }
}
