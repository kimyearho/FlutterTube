import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../widgets/search/search_list.dart';
import '../widgets/subscribe/subscribe.dart';
import '../widgets/alarm/notice.dart';
import '../widgets/collection/collection_box.dart';
import '../commons/app_property.dart';

import 'app_bar.dart';

class AppPage extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<AppPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      SearchList(),
      Subscribe(),
      NoticeWidget(),
      CollectionBox(),
    ];
    return Scaffold(
      appBar: TopAppBar(),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 3개이상 아이템이 배치될경우 이 항목이 필수
        backgroundColor: StoreStyleProperties.systemBarColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? Colors.blue : Colors.white,
            ),
            label: "홈",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                MaterialCommunityIcons.theater,
                color: _currentIndex == 1 ? Colors.blue : Colors.white,
              ),
              label: "구독"),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesome5.bell,
                color: _currentIndex == 2 ? Colors.blue : Colors.white,
              ),
              label: "알림"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.video_collection,
                color: _currentIndex == 3 ? Colors.blue : Colors.white,
              ),
              label: "보관함"),
        ],
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
