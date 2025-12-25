import 'package:flutter/material.dart';
import 'package:shopping_cart/models/shoes.dart';

class Cart extends ChangeNotifier {
  List<Shoes> shoesShop = [
    Shoes(
      name: 'Zoom FREAK',
      price: '236',
      description: 'The forward-thinking design of his latest signature shoe',
      image: 'lib/images/color-sport-sneaker.jpg',
    ),
    Shoes(
      name: 'Air Jordans',
      price: '220',
      description:
          'You\'ve got the hops and the speed-lace up in shoes that enhance',
      image: 'lib/images/fashion-shoes-sneakers.jpg',
    ),
    Shoes(
      name: 'KD Treys',
      price: '240',
      description:
          'You\'ve got the hops and the speed-lace up in shoes that enhance',
      image: 'lib/images/vecteezy_casual.png',
    ),
    Shoes(
      name: 'Kyrie 6',
      price: '190',
      description:
          'A secure midfoot strap is suited for scoring binges and defensive',
      image: 'lib/images/background-red-retro-model-tennis.jpg',
    ),
  ];

  List<Shoes> cartItems = [];

  List<Shoes> getShoes() {
    return shoesShop;
  }

  List<Shoes> getCart() {
    return cartItems;
  }

  void addToCart(Shoes shoes) {
    cartItems.add(shoes);
    notifyListeners();
  }

  void removeFromCart(Shoes shoes) {
    cartItems.remove(shoes);
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
  }
}
