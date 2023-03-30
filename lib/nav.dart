import 'package:flutter/material.dart';
import 'package:wishwell/add_client.dart';
import 'package:wishwell/user_screen.dart';
import 'package:wishwell/home_screen.dart';
//import 'package:wishwell/legatee_screen.dart';
import 'package:wishwell/client_screen.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    //const Home(),
    const Home(),
    const DetailsScreen(),
    const ClientScreen(),
    const ClientAdd(),
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(
        //  title: const Text('Bottom Nav Bar'),
        //),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.grey.shade600,
              ),
              // backgroundColor: Colors.blue,
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                color: Colors.grey.shade600,
              ),
              // backgroundColor: Colors.white,
              label: 'User Details',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.grey.shade600,
              ),
              // backgroundColor: Colors.blue,
              label: 'Clients',
            ),
            BottomNavigationBarItem(
              // backgroundColor: Colors.blue,
              icon: Icon(
                Icons.person_add,
                color: Colors.grey.shade600,
              ),
              label: 'Add Client',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
        ));
  }
}
