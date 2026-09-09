import 'package:flowee_app/models/flower.dart';
import 'package:flowee_app/theme/app_theme.dart';
import 'package:flowee_app/widgets/detail_header.dart';
import 'package:flowee_app/widgets/detail_total.dart';
import 'package:flowee_app/widgets/product_summary.dart';
import 'package:flowee_app/widgets/quantity_stepper.dart';
import 'package:flowee_app/widgets/sheet_drag_handle.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.flower});

  final Flower flower;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  /**
   * This quantity is alive as long as this widget state here
   * Every time is changed from Set state, flutter will do rebuild so the UI get updated
   */
  int _quantity = 1;

  void _increment() => setState(() => _quantity++);

  void _decrement() => setState(() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  });

  void _addToCart() {
    final flower = widget.flower;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$_quantity x ${flower.name} ditambahkan ke keranjang'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final flower = widget.flower;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          DetailHeader(
            flower: flower,
            onBack: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(22, 22, 22, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SheetDragHandle(),
                    SizedBox(height: 20),
                    ProductSummary(flower: flower),
                    SizedBox(height: 22),
                    Text(
                      'Deskripsi',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      flower.description,
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.5,
                      ),
                    ),
                    SizedBox(height: 26),
                    QuantityStepper(
                      quantity: _quantity,
                      onIncrement: _increment,
                      onDecrement: _decrement,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addToCart,
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        icon: Icon(Icons.shopping_bag_outlined, size: 20),
        label: Text('Tambah', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      bottomNavigationBar: DetailTotalBar(totalPrice: flower.price * _quantity),
    );
  }
}
