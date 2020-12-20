import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatefulWidget {
  final Color color;
  final ImageProvider imageProvider;
  final double height;
  final double width;
  final double left;


  const CustomCircleAvatar({Key key,
    this.color,
    this.imageProvider,
    this.height,
    this.width,
    this.left
  }) :super(key: key);
  _CustomCircleAvatarState createState() => _CustomCircleAvatarState();
}

class _CustomCircleAvatarState extends State<CustomCircleAvatar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            height: widget.height??38,
            width: widget.width??38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 0.5, color: Colors.white),
            ),
            child: widget.imageProvider == null?Image.asset('images/logo_white.png'):
            CircleAvatar(
              backgroundImage: widget.imageProvider,
            )
        ),
        Container(
          margin: EdgeInsets.only(left: widget.left??30,top: 2),
          height: 9,
          width: 9,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
          ),
        ),
      ],
    );
  }
}

