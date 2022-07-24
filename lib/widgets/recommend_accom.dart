import 'package:flutter/material.dart';

class RecommendAccom extends StatelessWidget {
  const RecommendAccom(
      {Key? key,
        required this.imageUrl,
        required this.name,
        required this.address,
        required this.price})
      : super(key: key);

  final String imageUrl;
  final String name;
  final String address;
  final String price;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(image: AssetImage(imageUrl),
            width: MediaQuery.of(context).size.width * 0.38,
            height: MediaQuery.of(context).size.width * 0.38,
            fit: BoxFit.fill,
          ),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(address),
          Text(price,style: TextStyle(color: Color.fromRGBO(221, 81, 37, 1),fontWeight: FontWeight.w500,),)
        ],
      ),
    );
  }
}