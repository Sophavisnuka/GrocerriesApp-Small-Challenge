import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../models/grocery.dart';

const uuid = Uuid();

final formKey = GlobalKey<FormState>();
class NewItem extends StatefulWidget {
  
  final Grocery? editGrocery;
  // final bool isEdit;
  const NewItem({super.key, this.editGrocery,});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {

  // Default settings
  static const defautName = "New grocery";
  static const defaultQuantity = 1;
  static const defaultCategory = GroceryCategory.fruit;

  // Inputs
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  GroceryCategory _selectedCategory = defaultCategory;

  @override
  void initState() {
    super.initState();
    // Initialize intputs with default settings
    _nameController.text = defautName;
    _quantityController.text = defaultQuantity.toString();

    if (widget.editGrocery != null) {
      _nameController.text = widget.editGrocery!.name;
      _quantityController.text = widget.editGrocery!.quantity.toString();
      _selectedCategory = widget.editGrocery!.category;
    }
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose the controlers
    _nameController.dispose();
    _quantityController.dispose();
  }

  void onReset() {
    // Will be implemented later - Reset all fields to the initial values
    formKey.currentState!.reset();
  }

  void onAdd() {
    if (formKey.currentState!.validate()) {
      Grocery newGrocery = Grocery(
        id: uuid.v4(), 
        name: _nameController.text, 
        quantity: int.parse(_quantityController.text), 
        category: _selectedCategory
      );
      Navigator.of(context).pop(newGrocery);
    }
  }
  String? validateCategory(GroceryCategory? value) {
    if (value == null) {
      return "please select category";
    }
    if (!value.isEdible) {
      return "please select the edible one";
    }
    return null;
  }
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Input something";
    }
    if (value.length > 50) {
      return "Enter the name between 1 and 50";
    }
    return null;
  }
  String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return "input sth";
    }
    final quantity = int.tryParse(value);
    if (quantity == null || quantity <= 0) {
      return "ts can't be negative";
    }
    if (quantity < 1 || quantity > 10) {
      return "Quantity can't be bigger than 10 and empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new item')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                validator: validateName, 
                controller: _nameController,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Name')),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: validateQuantity,
                      controller: _quantityController,
                      decoration: const InputDecoration(label: Text('Quantity')),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<GroceryCategory>(
                      validator: validateCategory,
                      initialValue: _selectedCategory,
                      decoration:  InputDecoration(label: Text('Category')),
                      items: [
                        for(var category in GroceryCategory.values)
                          DropdownMenuItem(
                            value: category,
                            child: Row(
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  color: category.color,
                                ),
                                SizedBox(width: 7),
                                Text(category.name),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: onReset, child: const Text('Reset')),
                  ElevatedButton(
                    onPressed: onAdd,
                    child: Text(widget.editGrocery != null ? 'Edit Item' : 'Add Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
