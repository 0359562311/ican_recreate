import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'consts.dart';


/// WelcomeScreen
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int index = 1;

  List<Widget> listChildWidget = [
    // Chat(),
    // PracticeScreen(),
    // Profile(),
  ];

  Future<bool> pressedBack(){
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Thoát khỏi ứng dụng?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Hủy",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              onPressed: () => Navigator.pop(context,false),
            ),
            FlatButton(
              child: Text("Thoát",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              onPressed: () => exit(0),
            ),
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: index==1?pressedBack:(){
        setState(() {
          index=1;
        });
        Navigator.pushNamed(context, Constant.routeWelcome);
        return Future.value(false);
      },
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          /// Background
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.cover
                )
            ),
          ),
          /// custom
          Column(
            children: [
              _getStackScreen(),
              _getNavigationButton(),
              SizedBox(height: 10),
            ],
          )
        ],
      ),
    );
  }
  Widget _getStackScreen() {
    return Expanded(
      child: IndexedStack(
        index: index,
        children: listChildWidget,
      ),
    );
  }

  Widget _getNavigationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FlatButton(
          child: Column(
            children: [
              SvgPicture.asset(
                'images/svg_images/tro_truyen.svg',
                height: 35,
                color: index == 0? Colors.white:Colors.white30,
              ),
              Text("Trò truyện", style: TextStyle(
                  color: index == 0? Colors.white:Colors.white30,
                  fontSize: 13,
                  fontWeight: FontWeight.w500
              ),),
            ],
          ),
          onPressed: (){
            setState(() {
              index = 0;
            });
          },
        ),
        FlatButton(
          child: Column(
            children: [
              SvgPicture.asset(
                'images/svg_images/luyen_tap.svg',
                height: 35,
                color: index == 1? Colors.white:Colors.white30,
              ),
              Text("Luyện tập", style: TextStyle(
                  color: index == 1? Colors.white:Colors.white30,
                  fontSize: 13,
                  fontWeight: FontWeight.w500
              ),),
            ],
          ),
          onPressed: (){
            setState(() {
              index = 1;
            });
          },
        ),
        FlatButton(
          child: Column(
            children: [
              SvgPicture.asset(
                'images/svg_images/ca_nhan.svg',
                height: 35,
                color: index == 2? Colors.white:Colors.white30,
              ),
              Text("Cá nhân", style: TextStyle(
                  color: index == 2? Colors.white:Colors.white30,
                  fontSize: 13,
                  fontWeight: FontWeight.w500
              ),),
            ],
          ),
          onPressed: (){
            setState(() {
              index = 2;
            });
          },
        ),
      ],
    );
  }

}
