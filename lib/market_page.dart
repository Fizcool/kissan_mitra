import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: MarketPage(),
      ),
    );
  }
}

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  List<Item> items = [
    Item(name: "Rice 🌾", price: 1443.75),
    Item(name: "Wheat 🌾", price: 1348),
    Item(name: "Maize 🌽", price: 1115),
    Item(
        name: "Cotton 🏭",
        price:
            2193.75), // Using factory emoji as there's no direct cotton emoji
    Item(
        name: "Sugarcane 🎍",
        price:
            1593.75), // Using bamboo emoji as there's no direct sugarcane emoji
    Item(name: "Soybeans 🌱", price: 1856.25),
    Item(name: "Potatoes 🥔", price: 907.81),
    Item(name: "Apples 🍎", price: 1743.75),
    Item(name: "Tomatoes 🍅", price: 1324.22),
    Item(name: "Onions 🧅", price: 817.5),
    Item(name: "Carrots 🥕", price: 664.69),
    Item(name: "Peanuts 🥜", price: 1518.75),
    Item(name: "Oranges 🍊", price: 1103.13),
    Item(name: "Bananas 🍌", price: 917.19),
    Item(name: "Grapes 🍇", price: 1743.75),
    Item(name: "Cucumbers 🥒", price: 806.25),
    Item(
        name: "Spinach 🍃",
        price: 600.31), // Using leaf emoji as there's no direct spinach emoji
    Item(name: "Broccoli 🥦", price: 1060.63),
    Item(name: "Peppers 🌶️", price: 1169.06),
    Item(name: "Strawberries 🍓", price: 2343.75),
    Item(
        name: "Blueberries 🔵🍇",
        price:
            2793.75), // Using a combination of blue circle and grapes emoji as there's no direct blueberries emoji
    Item(
        name: "Raspberries 🔴🍇",
        price:
            3304.69), // Using a combination of red circle and grapes emoji as there's no direct raspberries emoji
    Item(name: "Lemons 🍋", price: 1365),
    Item(name: "Avocados 🥑", price: 1196.56),
    Item(name: "Straw Hats 👒", price: 296.88),
    Item(
        name: "Corn Flakes 🌽🥣",
        price:
            203.44), // Using a combination of corn and bowl emoji as there's no direct corn flakes emoji
    Item(name: "Milk 🥛", price: 84.38),
    Item(name: "Eggs 🥚", price: 28.13),
    Item(name: "Chicken 🍗", price: 523.13),
    Item(name: "Beef 🥩", price: 726.56),
    Item(
        name: "Pork 🥓",
        price: 585.94), // Using bacon emoji as there's no direct pork emoji
    Item(
        name: "Salmon 🐟",
        price: 984.38), // Using fish emoji as there's no direct salmon emoji
    Item(name: "Shrimp 🍤", price: 1453.13),
    Item(
        name: "Tuna 🐟",
        price: 1232.81), // Using fish emoji as there's no direct tuna emoji
    Item(
        name: "Apples 🍎",
        price: 1743.75), // Duplicate item, consider removing or updating
    Item(name: "Pears 🍐", price: 1443.75),
    Item(
        name: "Oranges 🍊",
        price: 1103.13), // Duplicate item, consider removing or updating
    Item(
        name: "Plums 🍑",
        price: 917.19), // Using peach emoji as there's no direct plum emoji
    Item(name: "Peaches 🍑", price: 1007.66),
    Item(
        name: "Apricots 🍑",
        price: 937.34), // Using peach emoji as there's no direct apricot emoji
    Item(name: "Cherries 🍒", price: 1657.5),
    Item(name: "Watermelons 🍉", price: 507.81),
    Item(name: "Cantaloupes 🍈", price: 664.06),
    Item(
        name: "Honeydews 🍈",
        price: 765.63), // Using melon emoji as there's no direct honeydew emoji
    Item(name: "Pineapples 🍍", price: 539.06),
    Item(name: "Mangoes 🥭", price: 878.91),
    Item(
        name: "Papayas 🍈",
        price: 806.25), // Using melon emoji as there's no direct papaya emoji
    Item(name: "Kiwifruit 🥝", price: 453.13),
    Item(
        name: "Limes 🍋",
        price: 476.56), // Using lemon emoji as there's no direct lime emoji
    Item(
        name: "Lemongrass 🌾",
        price:
            171.88), // Using grass emoji as there's no direct lemongrass emoji
    Item(
        name: "Basil 🍃",
        price: 140.63), // Using leaf emoji as there's no direct basil emoji
  ];

  List<Item> pinnedItems = [];

  void pinItem(Item item) {
    setState(() {
      if (pinnedItems.contains(item)) {
        pinnedItems.remove(item);
      } else {
        pinnedItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch(items));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          bool isPinned = pinnedItems.contains(item);

          return ListTile(
            title: Text(item.name),
            subtitle: Text('Price: ${item.price} INR'),
            trailing: IconButton(
              icon: Icon(
                isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                color: isPinned ? Colors.blue : null,
              ),
              onPressed: () => pinItem(item),
            ),
          );
        },
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final List<Item> items;

  DataSearch(this.items);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = items
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(suggestionList[index].name),
        subtitle: Text('Price: ${suggestionList[index].price} INR'),
        onTap: () {
          // Define action upon tapping on a suggestion
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = items
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(suggestionList[index].name),
        subtitle: Text('Price: ${suggestionList[index].price} INR'),
        onTap: () {
          query = suggestionList[index].name;
          showResults(context);
        },
      ),
    );
  }
}

class Item {
  final String name;
  final double price;

  Item({required this.name, required this.price});
}
