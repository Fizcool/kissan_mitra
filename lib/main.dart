import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kissan_mitr/detailed_weather_page.dart';
import 'package:kissan_mitr/settings_page.dart';
import 'detailed_news_page.dart';
import 'market_page.dart';
import 'inventory.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kissan Mitr',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  // List of pages to be displayed when respective BottomNavigationBar item is clicked
  final List<Widget> pages = [
    const Column(
      // Home Page content
      children: [
        WeatherWidget(),
        Expanded(child: NewsSection()),
      ],
    ),
    const InventoryPage(), // Your Inventory Page
    const MarketPage(), // This should display your Market Page when the 3rd navbar item is clicked
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kissan Mitri'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to the settings page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: pages[
          currentIndex], // This line is responsible for displaying the current page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Inventory'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Market'),
        ],
        onTap: (index) {
          setState(() {
            currentIndex =
                index; // This line changes the current page being displayed
          });
        },
      ),
    );
  }
}

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  String temperature = 'Fetching...';
  String humidity = '';
  String weatherCondition = 'Fetching...';

  Future<void> fetchWeatherData() async {
    const apiKey =
        'h6nFWTib73IUWy8OeD7ACXMij3Nn34aK'; // Replace with your AccuWeather API key
    const locationKey =
        '260045'; // Replace with the location key for your desired location
    const apiUrl =
        'http://dataservice.accuweather.com/currentconditions/v1/$locationKey?apikey=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List && data.isNotEmpty) {
          final weatherData = data[0];
          setState(() {
            temperature = '${weatherData['Temperature']['Metric']['Value']}°C';
            humidity = 'Humidity: ${weatherData['RelativeHumidity']}%';
            weatherCondition = weatherData['WeatherText'];
          });
        } else {
          // Handle empty or unexpected response
        }
      } else {
        // Handle API error, e.g., display an error message
      }
    } catch (e) {
      // Handle network error, e.g., display an error message
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData(); // Fetch weather data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailedWeatherPage(
              location:
                  'Gharuan, Punjab 140413', // replace with actual location
              temperature: temperature,
              condition: weatherCondition,
              feelsLike:
                  temperature, // replace with "feels like" temperature if available
              dayTemperature: 'Day 29°C',
              nightTemperature: 'Night 17°C',
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(temperature, style: const TextStyle(fontSize: 24)),
                  Text(humidity),
                ],
              ),
            ),
            Text(weatherCondition, style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6, // Number of news articles

      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset(
            'assets/images/image.jpg', // Replace with your image URLs
          ),
          title: const Text('Lorem ipsum'),
          subtitle: const Text('Lorem ipsum dolor sit amet consectetur.'),
          onTap: () {
            String selectedTitle =
                'किसानों के लिए खुशखबरी, रबी फसलों की एमएसपी घोष‍ित, बढ़कर इतना हुआ गेहूं का दाम';
            String selectedContent =
                'एमएसपी में सबसे अधिक वृद्धि मसूर (मसूर) के लिए 425 रुपये प्रति क्विंटल की गई है. इसके बाद सरसों के लिए 200 रुपये प्रति क्विंटल की मंजूरी दी गई है. गेहूं और कुसुम के लिए 150-150 रुपये प्रति क्विंटल की बढ़ोतरी को मंजूरी दी गई है. केंद्र सरकार ने रबी सीजन की फसलों की एमएसपी की घोषणा कर दी है. रबी मार्केट‍िंग सीजन 2024-25 के लिए गेहूं का दाम 2275 रुपये प्रत‍ि क्व‍िंटल होगा. जबक‍ि सरसों का दाम 5650 रुपये प्रत‍ि क्व‍िंटल होगा. प्रधानमंत्री नरेंद्र मोदी की अध्यक्षता में आर्थिक मामलों की कैबिनेट समिति ने रबी फसलों के लिए न्यूनतम समर्थन मूल्य (एमएसपी) में वृद्धि को मंजूरी दी है.';
            // Navigate to the detailed news page with the article content
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailedNewsPage(
                  // Pass data such as news article content here
                  title: selectedTitle,
                  content: selectedContent,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class InventoryItem {
  final String name;
  final double price;
  int quantity;

  InventoryItem({
    required this.name,
    required this.price,
    this.quantity = 0,
  });
}

List<InventoryItem> inventory = [
  InventoryItem(name: 'Item 1', price: 10.0),
  InventoryItem(name: 'Item 2', price: 20.0),
  InventoryItem(name: 'Item 3', price: 15.0),
  // Add more items as needed
];
