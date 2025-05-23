import 'dart:io';

import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  // Constructor
  const DisplayImage({
    super.key,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const color = Color.fromRGBO(64, 105, 225, 1);

    return Center(
      child: Stack(
        children: [
          buildImage(color),
          Positioned(
            right: 4,
            top: 10,
            child: buildEditIcon(color),
          )
        ],
      ),
    );
  }

  // Builds Profile Image
  Widget buildImage(Color color) {
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));

    return CircleAvatar(
      radius: 100,
      backgroundColor: color,
      child: CircleAvatar(
        radius: 97,
        backgroundColor: Colors.transparent, // Make the inner circle transparent
        child: AspectRatio(
          aspectRatio: 1, // Maintain aspect ratio of the image
          child: ClipOval(
            child: Image(
              image: image as ImageProvider,
              fit: BoxFit.contain, // Fill the available space
            ),
          ),
        ),
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
        all: 8,
        child: Icon(
          Icons.edit,
          color: color,
          size: 20,
        ),
      );

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: Colors.white,
          child: child,
        ),
      );
}
