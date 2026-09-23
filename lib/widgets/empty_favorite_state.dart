import 'package:flutter/material.dart';

class EmptyFavoriteState extends StatelessWidget {
  const EmptyFavoriteState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 64, color: Colors.grey.shade300),
          SizedBox(height: 12),
          Text(
            'Belum Ada Bunga Favorit',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          Text(
            'Ketuk icon hati pada bunga untuk menambahkannnya',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
