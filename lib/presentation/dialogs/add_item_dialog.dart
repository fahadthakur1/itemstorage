import 'package:flutter/material.dart';
import 'package:itemstorage/models/item_model.dart';

class AddItemDialog extends StatefulWidget {
  final Item? item;
  const AddItemDialog({super.key, this.item});

  @override
  AddItemDialogState createState() => AddItemDialogState();
}

class AddItemDialogState extends State<AddItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController itemNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      itemNameController.text = widget.item!.itemName;
    }
  }

  @override
  dispose() {
    itemNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.centerRight,
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      scrollable: true,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.38,
        height:
            MediaQuery.of(context).size.height -
            MediaQuery.of(context).viewInsets.bottom,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 24.0,
                      left: 24.0,
                      top: 16.0,
                      bottom: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Color(0xffD7D4CC), thickness: 0.8),
                ],
              ),

              // Form Fields
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.item != null ? 'Update Item' : 'Add Item',
                            style: TextStyle(
                              color: const Color(0xFF1A1609),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: itemNameController,
                        decoration: InputDecoration(
                          labelText: 'Item Name',
                          labelStyle: TextStyle(
                            color: const Color(0xFF4F3B00),
                            fontSize: 14.22,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: const Color(0xFF4F3B00),
                              width: 1.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an item name';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Divider(color: Color(0xffD7D4CC), thickness: 0.8),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Color(0xFF4F3B00),
                            textStyle: TextStyle(
                              color: Color(0xFF4F3B00),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32.0,
                              vertical: 12.0,
                            ),
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
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
