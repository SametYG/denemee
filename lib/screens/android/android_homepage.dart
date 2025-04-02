import 'package:flutter/material.dart';
import 'package:sezin_scp/utils/page_paddings.dart';
import 'package:sezin_scp/widgets/homepage_view.dart';
import 'package:sezin_scp/widgets/person_view.dart';
import 'package:sezin_scp/widgets/roles_view.dart';

class AndroidHomepage extends StatefulWidget {
  const AndroidHomepage({super.key});

  @override
  State<AndroidHomepage> createState() => _AndroidHomepageState();
}

class _AndroidHomepageState extends State<AndroidHomepage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomepageView(),
    const RolesView(),
    const PersonView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sezin Online",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: PagePaddings().homePadding,
          child: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Sayfa"),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), label: "Roller"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profilim"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
