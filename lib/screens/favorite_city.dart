import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorite_list.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TripService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class Food {
  String name; //이름
  String address; //주소
  Food(
    this.name,
    this.address,
  ); //생성자
}

/// 홈 페이지
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TripService>(
      builder: (context, tripService, child) {
        List<Food> foodList = tripService.foodList;
        return Scaffold(
            appBar: AppBar(
              title: Text("사용자님이 찜한 곳들이에요"),
              backgroundColor: Colors.amber,
            ),
            body: Column(
              children: [
                Divider(height: 10),
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoritePage_Room()),
                          );
                        },
                        child: Text("제주도 >"),
                      ),
                      Spacer(),
                      Text("15곳"),
                    ],
                  ),
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                Divider(height: 10),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(Icons.face),
                        SizedBox(height: 10),
                        Text("제주도에서 아직 찜한 곳이 없어요"),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {}, //제주도 구경하기 클릭시 이동
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "제주도 구경하기",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoritePage_Room()),
                          );
                        },
                        child: Text("부산 >"),
                      ),
                      Spacer(),
                      Text("15곳"),
                    ],
                  ),
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            'https://i.ibb.co/xf2HpfG/dynamite.jpg',
                            width: MediaQuery.of(context).size.width * 0.20,
                          ),
                          Text('Dynamite',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text('BTS')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            'https://i.ibb.co/xf2HpfG/dynamite.jpg',
                            width: MediaQuery.of(context).size.width * 0.20,
                          ),
                          Text('Dynamite',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text('BTS')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            'https://i.ibb.co/xf2HpfG/dynamite.jpg',
                            width: MediaQuery.of(context).size.width * 0.20,
                          ),
                          Text('Dynamite',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text('BTS')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            'https://i.ibb.co/xf2HpfG/dynamite.jpg',
                            width: MediaQuery.of(context).size.width * 0.20,
                          ),
                          Text('Dynamite',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text('BTS')
                        ],
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: 140,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: '찜한곳'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.flight_takeoff_outlined), label: '여행계획'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle), label: 'MY'),
              ],
            ));
      },
    );
  }
}
