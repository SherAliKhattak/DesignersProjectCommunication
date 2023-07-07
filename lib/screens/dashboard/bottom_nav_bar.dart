// ignore_for_file: library_private_types_in_public_api


import 'package:elabd_project/screens/dashboard/dash_board.dart';
import 'package:elabd_project/screens/dashboard/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/images.dart';

class ReturnNavigationBar extends StatefulWidget {
  const ReturnNavigationBar({super.key});

  @override
  _ReturnNavigationBarState createState() => _ReturnNavigationBarState();
}

class _ReturnNavigationBarState extends State<ReturnNavigationBar> {
  Duration animationDuration = const Duration(milliseconds: 1500);

  int _selectedIndex = 0;
  int previousIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const ProjectsTab(),
    const DesignersTab(),
    const ChatsTab(),
    const Profile(),
    
  ];

  _onItemTapped(int index) {
    setState(() {
      previousIndex = _selectedIndex;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ).copyWith(top: 5, bottom: 15),
          height: Get.height * 0.09,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80), color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (() {
                  _onItemTapped(0);
                }),
                child: Image.asset(
                  Images.project,
                  height: Get.width * 0.06,
                  width: Get.width * 0.1,
                  color: color(
                      0, _selectedIndex, Theme.of(context).primaryColor, Theme.of(context).secondaryHeaderColor),
                ),
              ),
              InkWell(
                onTap: () {
                  _onItemTapped(1);
                },
                child: Image.asset(
                  Images.designer,
                  height: Get.width * 0.06,
                  width: Get.width * 0.1,
                  color: color(
                      1, _selectedIndex, Theme.of(context).primaryColor, Theme.of(context).secondaryHeaderColor),
                ),
              ),
              InkWell(
                onTap: () {
                  _onItemTapped(2);
                },
                child: Image.asset(
                  Images.comments,
                  height: Get.width * 0.06,
                  width: Get.width * 0.1,
                  color: color(
                      2, _selectedIndex, Theme.of(context).primaryColor, Theme.of(context).secondaryHeaderColor),
                ),
              ),
              InkWell(
                onTap: () {
                  _onItemTapped(3);
                },
                child: Image.asset(
                  Images.user,
                  height: Get.width * 0.06,
                  width: Get.width * 0.1,
                  color: color(
                      3, _selectedIndex, Theme.of(context).primaryColor, Theme.of(context).secondaryHeaderColor),
                ),
              ),
              
            ],
          )),
    );
  }
}

 Color color(
      int selectedIndex, int selected, Color color1, Color color2) {
    if (selected == selectedIndex) {
      return color1;
    } else {
      return color2;
    }
  }