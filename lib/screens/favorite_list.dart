import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chang_2nd_main_project/screens/favorite_city.dart';

class FavoritePage_Room extends StatelessWidget {
  const FavoritePage_Room({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TripService>(
      builder: (context, catService, child) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                title: Text("제주도"),
                backgroundColor: Colors.amber,
                bottom: TabBar(
                  tabs: [
                    Tab(text: '맛집'),
                    Tab(text: "숙소"),
                    Tab(text: "관광지"),
                  ],
                  indicatorColor: Colors.blue[400],
                  labelColor: Colors.black,
                ),
              ),
              body: TabBarView(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              'https://i.ibb.co/xf2HpfG/dynamite.jpg',
                              width: MediaQuery.of(context).size.width * 0.29,
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
                              width: MediaQuery.of(context).size.width * 0.29,
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
                              width: MediaQuery.of(context).size.width * 0.29,
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
                    height: 200,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                  Center(
                    child: Text("flight"),
                  ),
                  Center(
                    child: Text("flight"),
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
              )),
        );
      },
    );
  }
}
