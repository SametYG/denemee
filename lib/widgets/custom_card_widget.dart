import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget(
      {super.key,
      required this.onPressed,
      required this.imgAsset,
      required this.cardName});
  final VoidCallback onPressed;
  final String imgAsset;
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgAsset),
                  fit: BoxFit.cover,
                ),
              ),
              height: 150,
              // width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                cardName,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Colors.white,
                  backgroundColor: Colors.black45,
                ),
                softWrap: true,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
