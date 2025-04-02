import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sezin_scp/models/item.dart';

class ApiService {
  Future<List<Item>> fetchItems(Map<String, String> filters) async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/items.json');
      List<dynamic> data = json.decode(response);
      List<Item> items = data.map((item) => Item.fromJson(item)).toList();

      // Filtreleme işlemi
      if (filters.isNotEmpty) {
        items = items.where((item) {
          bool matches = true;
          filters.forEach((key, value) {
            if (key == 'title' && !item.title.contains(value)) {
              matches = false;
            }
            if (key == 'description' && !item.description.contains(value)) {
              matches = false;
            }
            if (key == 'details' && !item.details.contains(value)) {
              matches = false;
            }
          });
          return matches;
        }).toList();
      }

      return items;
    } catch (e) {
      print('Error: $e');
      throw Exception('Error loading items from local JSON');
    }
  }
}
