import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ican_project/ui/result_of_all_tests/roat_view.dart';
import 'package:ican_project/ui/subject_chooser.dart';


/// WelcomeScreen
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int index = 0;

  List<Widget> listChildWidget = [
    SubjectChooser(),
    ROATView(),
  ];

  @override
  Widget build(BuildContext context) {
    return  Stack(
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
                'images/svg_images/luyen_tap.svg',
                height: 35,
                color: index == 0? Colors.white:Colors.white30,
              ),
              Text("Luyện tập", style: TextStyle(
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
                'images/svg_images/ca_nhan.svg',
                height: 35,
                color: index == 1? Colors.white:Colors.white30,
              ),
              Text("Cá nhân", style: TextStyle(
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
      ],
    );
  }

}
