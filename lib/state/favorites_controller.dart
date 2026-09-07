import 'package:flutter/material.dart';

// ValueListenable --> ValueNotifier --> FavController
class FavoritesController extends ValueNotifier<Set<String>> {
  FavoritesController._() : super(<String>{});

  static final FavoritesController instance = FavoritesController._();

  bool isFavorite(String id) => value.contains(id);

  void toggle(String id) {
    final updated = Set<String>.from(value);
    if (!updated.remove(id)) {
      updated.add(id);
    }

    // ELSE
    value = updated;
  }
}