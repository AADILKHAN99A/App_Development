import 'package:flutter/material.dart';

class ImageWithText extends StatelessWidget {
  const ImageWithText(
      {super.key,
      required this.urlImage,
      required this.index,
      required this.name});

  final String urlImage;
  final int index;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(urlImage,
                height: 250,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width),
          ),
          Positioned(
            left: 0,
            child: Container(
              height: 250,
              margin: const EdgeInsets.only(top: 170),
              // padding: EdgeInsets.only(left: ),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
