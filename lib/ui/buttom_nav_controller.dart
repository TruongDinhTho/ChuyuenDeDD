import 'package:flutter/material.dart';
import 'package:flutter_store_app/ui/bottom_nav_pages/cart_screen.dart';
import 'package:flutter_store_app/ui/bottom_nav_pages/favourite_screen.dart';
import 'package:flutter_store_app/ui/bottom_nav_pages/home_screen.dart';
import 'package:flutter_store_app/ui/bottom_nav_pages/profile_screen.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({ Key? key }) : super(key: key);

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
 
  final _pages = [HomeScreen(), FavouriteScreen(), CartScreen(), ProfileScreen()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.blueGrey,
        selectedLabelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home",backgroundColor: Colors.grey,),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favourite",backgroundColor: Colors.grey,),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart",backgroundColor: Colors.grey,),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile",backgroundColor: Colors.grey,),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    
      body: _pages[_currentIndex],
    );
  }
}