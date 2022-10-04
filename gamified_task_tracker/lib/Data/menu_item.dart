import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Model/menu_item.dart';
import '../auth.dart';

class MenuItems {
  final User? user = Auth().currentUser;

  static const List<MenuItemT> itemsMain = [
    itemSignOut,
  ];

  static const itemSignOut = MenuItemT(
    text: 'Sign Out',
  );
}
