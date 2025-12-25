import 'package:flutter/material.dart';
import 'package:shopping_cart/model/products.dart';

class ShopModel extends ChangeNotifier {
  final List<ProductModel> _products = [
    ProductModel(
      title: 'Zoom FREAK',
      price: '236',
      description: 'The forward-thinking design of his latest signature shoe',
      image: 'lib/images/color-sport-sneaker.jpg',
    ),
    ProductModel(
      title: 'Air Jordans',
      price: '220',
      description:
          'You\'ve got the hops and the speed-lace up in shoes that enhance',
      image: 'lib/images/fashion-shoes-sneakers.jpg',
    ),
    ProductModel(
      title: 'KD Treys',
      price: '240',
      description:
          'You\'ve got the hops and the speed-lace up in shoes that enhance',
      image: 'lib/images/vecteezy_casual.png',
    ),
    ProductModel(
      title: 'Kyrie 6',
      price: '190',
      description:
          'A secure midfoot strap is suited for scoring binges and defensive',
      image: 'lib/images/background-red-retro-model-tennis.jpg',
    ),
  ];

  final List<ProductModel> _listCart = [];

  List<ProductModel> get products => _products;

  List<ProductModel> get listCart => _listCart;

  void addToCart(ProductModel product) {
    _listCart.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _listCart.remove(product);
    notifyListeners();
  }
}
