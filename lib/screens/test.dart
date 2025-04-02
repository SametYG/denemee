import 'package:flutter/material.dart';

import 'package:sezin_scp/models/item.dart';
import 'package:sezin_scp/services/api_service.dart';
import 'package:sezin_scp/widgets/item_card.dart';

class FunnyImageScreen extends StatefulWidget {
  @override
  _FunnyImageScreenState createState() => _FunnyImageScreenState();
}

class _FunnyImageScreenState extends State<FunnyImageScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Item>> _items;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  _loadItems() {
    _items = _apiService.fetchItems({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'details': _detailsController.text,
    });
  }

  _onFilterChanged() {
    setState(() {
      _loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Card List with Filters'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              onChanged: (value) => _onFilterChanged(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (value) => _onFilterChanged(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _detailsController,
              decoration: InputDecoration(labelText: 'Details'),
              onChanged: (value) => _onFilterChanged(),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Item>>(
              future: _items,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No items found.'));
                }

                List<Item> items = snapshot.data!;

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ItemCard(item: items[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
