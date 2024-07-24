import 'package:flutter/material.dart';

class RotateImage extends StatelessWidget {
  const RotateImage({
    Key? key,
    required this.imageUrl,
    this.degree = 0,
  }) : super(key: key);

  final String imageUrl;
  final int degree;

  @override
  Widget build(BuildContext context) {
    // 자식 위젯을 회전시키는 역할을 함
    return Transform.rotate(
      // angle 속성에는 임의의 숫자만 입력해도 회전시킬 수 있지만 내가 원하는 각도만큼만 회전시키키 위해서 각도 * pi / 180 공식을 이용
      angle: degree * 3.14 / 180,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Image(
          image: AssetImage(imageUrl),
          height: 150.0,
        ),
      ),
    );
  }
}
