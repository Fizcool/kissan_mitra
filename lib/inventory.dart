import 'package:flutter/material.dart';

class InventoryItem {
  String name;
  double quantity;

  InventoryItem({required this.name, required this.quantity});
}

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<InventoryItem> inventory = [];

  void _addInventory() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController nameController = TextEditingController();
          TextEditingController quantityController = TextEditingController();

          return AlertDialog(
            title: const Text('Add Inventory Item'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Item Name'),
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    inventory.add(InventoryItem(
                        name: nameController.text,
                        quantity:
                            double.tryParse(quantityController.text) ?? 0.0));
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              )
            ],
          );
        });
  }

  void _subtractInventory(InventoryItem item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController quantityController = TextEditingController();

          return AlertDialog(
            title: const Text('Remove Quantity'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Item: ${item.name}'),
                TextField(
                  controller: quantityController,
                  decoration:
                      const InputDecoration(labelText: 'Quantity to remove'),
                  keyboardType: TextInputType.number,
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    item.quantity -=
                        double.tryParse(quantityController.text) ?? 0.0;
                    if (item.quantity <= 0) {
                      inventory.remove(item);
                    }
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Remove'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: inventory.isEmpty
                  ? const Center(child: Text('No items in inventory'))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => _subtractInventory(inventory[index]),
                          child: InventoryItemWidget(
                            item: inventory[index],
                          ),
                        );
                      },
                      itemCount: inventory.length,
                    ),
            ),
            ElevatedButton(
              onPressed: _addInventory,
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: const Text('Add Inventory'),
            ),
          ],
        ),
      ),
    );
  }
}

class InventoryItemWidget extends StatelessWidget {
  final InventoryItem item;

  const InventoryItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(item.name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Text('${item.quantity.toStringAsFixed(2)}KGs'),
        ],
      ),
    );
  }
}
