import 'package:latihan_kuis/models/food_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Stateful karena total harga berubah saat jumlah porsi diubah
class DetailPage extends StatefulWidget {
  final int menuIndex;

  const DetailPage({super.key, required this.menuIndex});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late FoodItem menu;
  final TextEditingController _jumlahController = TextEditingController();
  int jumlah = 0;

  @override
  void initState() {
    super.initState();
    menu = FoodItem.sampleData[widget.menuIndex];
    jumlah = menu.quantity;
    _jumlahController.text = jumlah.toString();
  }

  // dipanggil setiap jumlah porsi berubah
  void _ubahJumlah(int nilaiBaru) {
    if (nilaiBaru < 0) nilaiBaru = 0;

    setState(() {
      jumlah = nilaiBaru;
      _jumlahController.text = nilaiBaru.toString();
    });
  }

  void _simpan() {
    menu.quantity = jumlah;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(menu.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                menu.imageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 220,
                    child: Center(
                      child: Icon(Icons.image_not_supported, size: 80),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Detail makanan
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menu.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Rp ${menu.formattedPrice} / porsi',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      menu.description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),

                    const SizedBox(height: 16),

                    // Input jumlah porsi (satu-satunya yang bisa diubah)
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => _ubahJumlah(jumlah - 1),
                          icon: const Icon(Icons.remove_circle),
                          color: Colors.deepOrange,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _jumlahController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              labelText: 'Jumlah (porsi)',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              setState(() {
                                jumlah = int.tryParse(value) ?? 0;
                              });
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () => _ubahJumlah(jumlah + 1),
                          icon: const Icon(Icons.add_circle),
                          color: Colors.deepOrange,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Total harga
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total', style: TextStyle(fontSize: 16)),
                        Text(
                          'Rp ${formatPrice(menu.price * jumlah)}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Tombol simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _simpan,
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Simpan Pemesanan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(100, 48),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
