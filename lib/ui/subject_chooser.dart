import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ican_project/consts.dart';
import 'package:ican_project/custom/custom_layout.dart';
import 'package:ican_project/firebase_service/authentication_service.dart';
import 'package:ican_project/firebase_service/cloud_service.dart';
import 'package:ican_project/firebase_service/storage_service.dart';
import 'package:ican_project/model/data_of_a_test.dart';

/// one of the 3 fragments in welcome.dart
class SubjectChooser extends StatefulWidget {
  @override
  _SubjectChooserState createState() => _SubjectChooserState();
}

class _SubjectChooserState extends State<SubjectChooser> {
  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// welcome
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Welcome \n" + AuthService.currentUser.displayName,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            /// avatar
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.white)),
                child: FutureBuilder(
                  future: StorageService.avatarURL,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data as String,
                        ),
                        radius: 60,
                      );
                    } else {
                      return CircleAvatar(
                        backgroundImage: AssetImage(
                          'images/logo_color.png',
                        ),
                        radius: 60,
                      );
                    }
                  },
                ),
              ),
            ),

            /// Mathematics
            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Constants.gradeChooser,
                      arguments: Test(subject: 'maths'));
                },
                child: Stack(
                  children: [
                    Container(
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Constants.mathBackground,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Toán học",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                    child: SvgPicture.asset(
                                        'images/svg_images/mui_ten_mon_hoc.svg')))
                          ],
                        )),
                    Opacity(
                      opacity: 0.15,
                      child: Container(
                        height: 85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: AssetImage('images/mon_toan.jpg'),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Physics
            Padding(
              padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Constants.gradeChooser,
                      arguments: Test(subject: 'physics'));
                },
                child: Stack(
                  children: [
                    Container(
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Constants.physicsBackground,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Vật lý",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                    child: SvgPicture.asset(
                                        'images/svg_images/mui_ten_mon_hoc.svg')))
                          ],
                        )),
                    Opacity(
                      opacity: 0.15,
                      child: Container(
                        height: 85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: AssetImage('images/mon_ly.jpg'),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Chemistry
            Padding(
              padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Constants.gradeChooser,
                      arguments: Test(subject: 'chemistry'));
                },
                child: Stack(
                  children: [
                    Container(
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Constants.chemistryBackground,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Hóa học",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                    child: SvgPicture.asset(
                                        'images/svg_images/mui_ten_mon_hoc.svg')))
                          ],
                        )),
                    Opacity(
                      opacity: 0.15,
                      child: Container(
                        height: 85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: AssetImage('images/mon_hoa.jpg'),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///English
            Padding(
              padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Constants.gradeChooser,
                      arguments: Test(subject: 'english'));
                },
                child: Stack(
                  children: [
                    Container(
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Constants.englishBackground,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Tiếng Anh",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                    child: SvgPicture.asset(
                                        'images/svg_images/mui_ten_mon_hoc.svg'))),
                          ],
                        )),
                    Opacity(
                      opacity: 0.15,
                      child: Container(
                        height: 85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: AssetImage('images/mon_Anh.jpg'),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
