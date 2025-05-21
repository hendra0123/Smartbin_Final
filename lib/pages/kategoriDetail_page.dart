import 'package:flutter/material.dart';
import 'kategori_items.dart';

class KategoriDetailPage extends StatelessWidget {
  final String kategori;

  const KategoriDetailPage({super.key, required this.kategori});

  List<KategoriItem> _getItems() {
    switch (kategori) {
      case "Recycle":
        return recycleItems;
      case "Non-Recycle":
        return nonRecycleItems;
      case "B3":
        return b3Items;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _getItems();

    return Scaffold(
      appBar: AppBar(
        title: Text(kategori),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(item.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Text(item.description),
                      ],
                    ),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(item.imageAsset, height: 60),
                  const SizedBox(height: 8),
                  Text(item.name, textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
