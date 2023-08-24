import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/dummy_items.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];
  void _additem() async {
    final newitem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: ((context) => const NewItem()),
      ),
    );

    if (newitem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newitem);
    });
  }

  void _removeitem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No items added yet'),
    );
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: ((context, index) => Dismissible(
              onDismissed: (direction) {
                _removeitem(_groceryItems[index]);
              },
              key: ValueKey(groceryItems[index].id),
              child: ListTile(
                title: Text(groceryItems[index].name),
                leading: Container(
                  width: 24,
                  height: 24,
                  color: _groceryItems[index].category.color,
                ),
                trailing: Text(_groceryItems[index].quantity.toString()),
              ),
            )),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Groceries'),
          actions: [
            IconButton(onPressed: _additem, icon: const Icon(Icons.add))
          ],
        ),
        body: content);
  }
}
