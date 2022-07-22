import 'package:flutter/material.dart';
import 'schedule_complete.dart';

class SelectWantToGo extends StatelessWidget {
  const SelectWantToGo({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              '제주도',
              style: TextStyle(color: Colors.black),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(130),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 19,
                    ),
                    Text(
                      '가고 싶은 곳을 선택해주세요',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    TabBar(
                      labelColor: Colors.black,
                      tabs: [
                        Tab(
                          text: '맛집',
                        ),
                        Tab(
                          text: '숙소',
                        ),
                        Tab(
                          text: '관광지',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 18, top: 10, right: 18),
                child: TabBarView(
                  children: [
                    DisplaySelectList(
                        name: '장소', catagory: '카페', address: '주소'),
                    DisplaySelectList(
                        name: '장소', catagory: '숙소', address: '주소'),
                    DisplaySelectList(
                        name: '장소', catagory: '관광지', address: '주소'),
                  ],
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height - 550,
                left: 0,
                right: 0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleComplete(),
                      ),
                    );
                  },
                  child: Text('확인'), //font 적용하기
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    minimumSize: Size(339, 48),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplaySelectList extends StatelessWidget {
  final String name;
  final String catagory;
  final String address;
  final bool checkBox;
  const DisplaySelectList(
      {Key? key,
      required this.name,
      required this.catagory,
      required this.address,
      this.checkBox = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: FlutterLogo(size: 56.0),
          title: Row(
            children: [
              Text(name),
              SizedBox(
                width: 6,
              ),
              Text(catagory),
            ],
          ),
          subtitle: Row(
            children: [
              Icon(Icons.place_outlined),
              SizedBox(
                width: 3.5,
              ),
              Text(address),
            ],
          ),
          trailing: Icon(Icons.check_circle_outline, color: Colors.amber),
        );
      },
    );
  }
}
