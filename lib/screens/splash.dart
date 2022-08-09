import 'package:chang_2nd_main_project/screens/main_page.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
              image : AssetImage("assets/images/login_title.jpeg"),
              fit: BoxFit.fitWidth
              ),
            ),
            child: Column(
                children: [
                    SizedBox(height: MediaQuery.of(context).size.height/2-100,),
                    Column(
                      children: [
                        Text('1인 여행의 모든 것',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'SpoqaHanSansNeo',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Image(image: svg_provider.Svg("assets/images/title_logo.svg", size: Size(153,36))),
                      ],
                    ),
                ],
            ),
        ),
    );
  }
}
