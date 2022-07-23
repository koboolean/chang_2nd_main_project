import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleService extends ChangeNotifier {
  List<DisplaySelectList> foodTabList = [
    //더미 데이터
    DisplaySelectList(
      name: '장소',
      catagory: '카페',
      address: '주소',
      checkBox: false,
    ),
    DisplaySelectList(
      name: '장소',
      catagory: '카페',
      address: '주소',
      checkBox: false,
    ),
    DisplaySelectList(
      name: '장소',
      catagory: '카페',
      address: '주소',
      checkBox: false,
    ),
    DisplaySelectList(
      name: '장소',
      catagory: '카페',
      address: '주소',
      checkBox: false,
    ),
    DisplaySelectList(
      name: '장소',
      catagory: '카페',
      address: '주소',
      checkBox: false,
    ),
    DisplaySelectList(
      name: '장소',
      catagory: '카페',
      address: '주소',
      checkBox: false,
    ),
  ];
  List<DisplaySelectList> hotelTabList = [
    //더미 데이터
    DisplaySelectList(
      name: '장소',
      catagory: '숙소',
      address: '주소',
      checkBox: false,
    ),
    DisplaySelectList(
      name: '장소',
      catagory: '숙소',
      address: '주소',
      checkBox: false,
    ),
    DisplaySelectList(
      name: '장소',
      catagory: '숙소',
      address: '주소',
      checkBox: false,
    ),
    DisplaySelectList(
      name: '장소',
      catagory: '숙소',
      address: '주소',
      checkBox: false,
    ),
    DisplaySelectList(
      name: '장소',
      catagory: '숙소',
      address: '주소',
      checkBox: false,
    ),
    DisplaySelectList(
      name: '장소',
      catagory: '숙소',
      address: '주소',
      checkBox: false,
    ),
  ];
  List<DisplaySelectList> touristTabList = [
    //더미 데이터
    DisplaySelectList(
      name: '장소',
      catagory: '관광지',
      address: '주소',
      checkBox: false,
    ),
    DisplaySelectList(
      name: '장소',
      catagory: '관광지',
      address: '주소',
      checkBox: false,
    ),
    DisplaySelectList(
      name: '장소',
      catagory: '관광지',
      address: '주소',
      checkBox: false,
    ),
    DisplaySelectList(
      name: '장소',
      catagory: '관광지',
      address: '주소',
      checkBox: false,
    ),
    DisplaySelectList(
      name: '장소',
      catagory: '관광지',
      address: '주소',
      checkBox: false,
    ),
    DisplaySelectList(
      name: '장소',
      catagory: '관광지',
      address: '주소',
      checkBox: false,
    ),
  ];

  void toggleCheckBox(DisplaySelectList schedual, int index) {
    schedual.checkBox = !schedual.checkBox;
    notifyListeners();
  }

  Widget listViewBuild(List Tab) {
    textBottenInTab();

    return ListView.builder(
      padding: EdgeInsets.only(top: 50),
      itemCount: Tab.length,
      itemBuilder: (context, index) {
        var schedual = Tab[index];
        return ListTile(
          leading: FlutterLogo(size: 56.0),
          title: Row(
            children: [
              Text(schedual.name),
              SizedBox(
                width: 6,
              ),
              Text(schedual.catagory),
            ],
          ),
          subtitle: Row(
            children: [
              Icon(Icons.place_outlined),
              SizedBox(
                width: 3.5,
              ),
              Text(schedual.address),
            ],
          ),
          trailing: schedual.checkBox
              ? Icon(Icons.check_circle_outline, color: Colors.amber)
              : Icon(
                  Icons.check_circle_outline,
                  color: Colors.grey[350],
                ),
          onTap: () {
            toggleCheckBox(schedual, index);
          },
        );
      },
    );
  }
}

class textBottenInTab extends StatelessWidget {
  const textBottenInTab({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10),
        primary: Colors.black,
        backgroundColor: Colors.grey,
        minimumSize: Size(43, 22),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        textStyle: TextStyle(fontSize: 11),
      ),
      child: Text('전체'),
    );
  }
}

class DisplaySelectList {
  String name;
  String catagory;
  String address;
  bool checkBox;
  DisplaySelectList(
      {Key? key,
      required this.name,
      required this.catagory,
      required this.address,
      this.checkBox = true});
}
