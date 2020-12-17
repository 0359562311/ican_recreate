import 'package:flutter/material.dart';
import 'package:ican_project/consts.dart';
import 'package:ican_project/custom/custom_layout.dart';
import 'package:ican_project/model/data_of_a_test.dart';

final List<Color> listColors = [
  Constants.grade6Color,
  Constants.grade7Color,
  Constants.grade8Color,
  Constants.grade9Color,
  Constants.grade10Color,
  Constants.grade11Color,
  Constants.grade12Color
];

class GradeChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Test data = ModalRoute.of(context).settings.arguments;
    String subject;
    switch (data.subject) {
      case 'maths':
        subject = 'môn Toán';
        break;
      case 'physics':
        subject = 'môn Vật Lý';
        break;
      case 'chemistry':
        subject = 'môn Hóa';
        break;
      case 'english':
        subject = 'môn Tiếng Anh';
        break;
      default:
        subject = "";
    }
    return CustomLayout(
      titleFontSize: 17,
      title: "Danh sách các lớp học\n $subject",
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: GridView.count(
                crossAxisCount: 2,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                childAspectRatio: 1.2,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                children: List.generate(6, (index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: listColors[index])),
                    child: FlatButton(
                      color: Color.fromRGBO(255, 255, 255, 0.05),
                      onPressed: () {
                        Navigator.pushNamed(context, Constants.routeListTest,
                            arguments: data..grade = "${index + 6}");
                      },
                      child: Text(
                        " Lớp ${index + 6}",
                        style:
                            TextStyle(color: listColors[index], fontSize: 16),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(24, 0, 24, 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: listColors[6])),
              child: AspectRatio(
                aspectRatio: 2.3,
                child: FlatButton(
                  color: Color.fromRGBO(255, 255, 255, 0.05),
                  onPressed: () {
                    Navigator.pushNamed(context, Constants.routeListTest,
                        arguments: data..grade = "12");
                  },
                  child: Text(
                    "  Lớp 12",
                    style: TextStyle(color: listColors[6], fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
