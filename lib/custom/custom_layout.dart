import 'package:flutter/material.dart';

class CustomLayout extends StatelessWidget {
  final Widget leading;
  final String title;
  final Widget body;
  final List<Widget> bottomBar;

  const CustomLayout({
    Key key,Widget leading, String title, Widget body, this.bottomBar
  }):leading = leading ?? const SizedBox(height: 0,),
    title = title ?? "",
    body = body ?? const SizedBox(),
    super(key: key)
  ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
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
                /// SimpleAppbar
                SizedBox(
                  height: (title == "")? 0 : 50,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      leading,
                      Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                /// body
                Expanded(child: body),
                /// bottomBar
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: bottomBar == null ? [SizedBox()]:bottomBar,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

