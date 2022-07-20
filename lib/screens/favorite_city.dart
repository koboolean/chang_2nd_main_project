import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chang_2nd_main_project/screens/favorite_list.dart';
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

class TripService extends ChangeNotifier {}

/// 홈 페이지
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TripService>(
      builder: (context, catService, child) {
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
                      new GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoritePage_Room()),
                          );
                        },
                        child: new Text("제주도 >"),
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
                Divider(height: 10),
                Container(
                  child: Row(
                    children: [
                      new GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoritePage_Room()),
                          );
                        },
                        child: new Text("부산 >"),
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
