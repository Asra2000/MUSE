import 'package:flutter/material.dart';
import '../services/bottomNavBar.dart';
import '../services/constants.dart';

class PlayerScreen extends StatelessWidget {
  final String imageUrl;
  PlayerScreen({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      body: Stack(
        children: [
        Container(
        decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(this.imageUrl),
            colorFilter: ColorFilter.mode(pale, BlendMode.colorBurn),
        fit: BoxFit.cover,
        ),
        )
      ),
        ],
      ),
    );
  }
}
