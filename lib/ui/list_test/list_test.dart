import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ican_project/consts.dart';
import 'package:ican_project/custom/custom_layout.dart';
import 'package:ican_project/model/data_of_a_test.dart';
import 'package:ican_project/ui/list_test/list_test_bloc.dart';
import 'package:ican_project/ui/list_test/list_test_event.dart';
import 'package:ican_project/ui/list_test/list_test_state.dart';

// ignore: must_be_immutable
class ListTest extends StatefulWidget {

  @override
  _ListTestState createState() => _ListTestState();
}

class _ListTestState extends State<ListTest> {
  var grade;

  var subject;

  var checkState = false;

  ListTestBloc bloc;

  Test data;

  List<bool> listItem = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = ListTestBloc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    grade = 'Lớp ${data.grade}';
    switch(data.subject){
      case 'maths': subject = 'Môn Toán';break;
      case 'physics': subject = 'Môn Vật Lý';break;
      case 'chemistry': subject = 'Môn Hóa';break;
      case 'english': subject = 'Tiếng Anh';break;
    }
    return BlocConsumer<ListTestBloc,ListTestState>(
      cubit: bloc,
      listener: (context, state){
        if(state is ListTestErrorState){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AlertDialog(
                    content: Text(state.errorMessage),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  )));
        }
        else if(state is ListTestLoadedState){
          listItem = state.listItems;
        }
      },
      builder: (context, state){
        if(state is ListTestInitState)
          bloc.add(ListTestGetAllTests(data.subject, data.grade));
        else if(state is ListTestLoading)
          return SpinKitDoubleBounce(color: Colors.blue.shade500,);
        return CustomLayout(
          title: grade,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Constants.listTestBackground,
                    border: Border(
                        top: BorderSide(
                          color: Constants.listTestBorderItem,
                        ),
                        bottom: BorderSide(
                          color: Constants.listTestBorderItem,
                        ))),
                height: 85,
                child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Danh sách các bài đánh giá năng lực',
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            '$subject, $grade',
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              ///ListTest
              Expanded(
                child: ListView.builder(
                  itemCount: listItem.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildListTest(context, index),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  ///Giao dien cua list
  Widget buildListTest(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(27, 13, 27, 0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Constants.test, arguments: {
            "test": data..testId = '${index+1}',
            "hasDone": listItem[index]
          });
        },
        child: Container(
          height: 53,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlue),
            color: Constants.listTestBackground,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 0, 10, 0),
                      child: SvgPicture.asset(
                        listItem[index]?'images/svg_images/tich_hoan_thanh.svg':'images/svg_images/bai_test.svg',
                        width: 50,
                        color: Constants.listTestIconColor,
                      ),
                    ),
                    Text(
                      "Bài ${index+1}",
                      style: TextStyle(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w500,
                        color: Constants.listTestIconColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(
                    'images/svg_images/mui_ten_mon_hoc.svg',
                    width: 50,
                    color: Constants.listTestIconColor,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
