import 'package:latihan_kuis/detail.dart';
import 'package:latihan_kuis/models/food_item.dart';
import 'package:flutter/material.dart';

// Stateful karena tampilannya harus berubah
// setelah user kembali dari halaman detail
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu Resto',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: FoodItem.sampleData.length,
        itemBuilder: (context, index) {
          final menu = FoodItem.sampleData[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(menuIndex: index),
                ),
              ).then((_) {
                // setelah kembali dari detail, perbarui tampilan beranda
                setState(() {});
              });
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Gambar
                  Image.network(
                    menu.imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        width: 100,
                        height: 100,
                        child: Icon(Icons.image_not_supported),
                      );
                    },
                  ),

                  // Info makanan
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menu.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            menu.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${menu.quantity} porsi',
                                style: const TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Rp ${menu.formattedTotal}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Rp ${menu.formattedPrice} / porsi',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
