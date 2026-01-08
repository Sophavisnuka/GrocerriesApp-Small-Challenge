import 'package:flutter/material.dart';
import 'package:grocceries/ui/groceries/grocery_form.dart';
import '/models/grocery.dart';
import '../../data/mock_grocery_repository.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {

  void onCreate() async {
    // TODO-4 - Navigate to the form screen using the Navigator push
    final newGroceryItem = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => NewItem(),
      )
    );
    setState(() {
      dummyGroceryItems.add(newGroceryItem);
    });
  }
  void onEdit(int index) async {
    final updatedGrocery = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewItem(editGrocery: dummyGroceryItems[index]),
      ),
    );

    if (updatedGrocery != null) {
      setState(() {
        dummyGroceryItems[index] = updatedGrocery;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Text('No items added yet.'));
    if (dummyGroceryItems.isNotEmpty) {
       // TODO-1 - Display groceries with an Item builder and  LIst Tile
      content = ListView.builder(
        itemCount: dummyGroceryItems.length,
        itemBuilder: (context, index) {
          return GroceryTile(
            grocery: dummyGroceryItems[index],
            onTap: () => onEdit(index),
          );
        }
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: onCreate,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery, required this.onTap});
  
  final Grocery grocery;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
      // TODO-2 - Display groceries with an Item builder and  LIst Tile
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: Container(
            width: 25,
            height: 25,
            color: grocery.category.color
          ),
          title: Text(grocery.name),
          trailing: Text('Quantity: ${grocery.quantity}', style: TextStyle(fontSize: 15)),
        ),
      )
    );
  }
}
