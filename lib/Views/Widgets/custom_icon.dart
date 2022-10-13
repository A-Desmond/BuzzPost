import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 40,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            width: 38,
            decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  32,
                  211,
                  234,
                ),
                borderRadius: BorderRadius.circular(12)),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            width: 38,
            decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  32,
                  211,
                  234,
                ),
                borderRadius: BorderRadius.circular(12)),
          ),
          Center(
            child: Container(
              width: 38,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: const Icon(
                Icons.add,
                color: Colors.black,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
