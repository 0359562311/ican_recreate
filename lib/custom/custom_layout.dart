import 'package:flutter/material.dart';

class CustomLayout extends StatelessWidget {
  final Widget leading;
  final String title;
  final Widget body;
  final List<Widget> bottomBar;
  final double titleFontSize;

  const CustomLayout({
    Key key,Widget leading, String title, Widget body, this.bottomBar,
    double titleFontSize
  }):leading = leading ?? const SizedBox(),
    title = title ?? "",
    body = body ?? const SizedBox(),
    titleFontSize = titleFontSize ?? 24,
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
                    alignment: Alignment.centerLeft,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:4.0),
                        child: Center(
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: titleFontSize
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left:4.0,top: 4.0),
                        child: leading,
                      ),
                    ],
                  ),
                ),
                /// body
                Expanded(child: body),
                /// bottomBar
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: bottomBar == null ? [const SizedBox()]:bottomBar,
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}

