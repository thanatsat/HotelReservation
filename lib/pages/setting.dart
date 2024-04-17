// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/pages/edit_profile.dart';
import 'package:test/pages/hotel_favorite.dart';
import 'package:test/pages/root_app.dart';
import 'package:test/screens/signin_screen.dart';
import 'package:test/theme/color.dart';
import 'package:test/widgets/setting_item.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: _buildAppBar(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildBody(),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "Setting",
            style: TextStyle(
              color: AppColor.textColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 20, top: 10),
      child: Column(
        children: [
          _buildProfile(),
          const SizedBox(height: 50),
          SettingItem(
            title: "General Setting",
            leadingIcon: Icons.settings,
            leadingIconColor: AppColor.orange,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfile()),
              );
            },
          ),
          const SizedBox(height: 10),
          SettingItem(
            title: "Favorites",
            leadingIcon: Icons.favorite,
            leadingIconColor: AppColor.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteHotelsPage()),
              );
            },
          ),
          const SizedBox(height: 10),
          SettingItem(
            title: "Home Page",
            leadingIcon: Icons.home_filled,
            leadingIconColor: Color.fromARGB(135, 41, 23, 21),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RootApp()),
              );
            },
          ),
          const SizedBox(height: 10),
          SettingItem(
            title: "Log Out",
            leadingIcon: Icons.logout_outlined,
            leadingIconColor: Colors.grey.shade400,
            onTap: () {
              _showConfirmLogout();
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          CircleAvatar(
            radius: 75,
            backgroundImage: AssetImage(
              '/Users/dm/Documents/coding/flutter/test/lib/assets/rabbit.jpg',
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Hi there",
            style: TextStyle(
              color: AppColor.textColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Have a good one :-)",
            style: TextStyle(
              color: AppColor.labelColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  _showConfirmLogout() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: Text("Would you like to log out?"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
            child: Text(
              "Log Out",
              style: TextStyle(color: AppColor.actionColor),
            ),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
