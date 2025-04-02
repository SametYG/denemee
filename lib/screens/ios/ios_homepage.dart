import 'package:flutter/material.dart';
import 'package:sezin_scp/utils/page_paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:sezin_scp/widgets/homepage_view.dart';
import 'package:sezin_scp/widgets/person_view.dart';
import 'package:sezin_scp/widgets/roles_view.dart';

class IosHomepage extends StatefulWidget {
  const IosHomepage({super.key});

  @override
  State<IosHomepage> createState() => _IosHomepageState();
}

class _IosHomepageState extends State<IosHomepage> {
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
      bottomNavigationBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "Ana Sayfa"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_2), label: "Roller"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), label: "Profilim"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        activeColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
