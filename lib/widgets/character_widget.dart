import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hogwarts_sorting_hat/models/character_model.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget({super.key, required this.character, this.image});

  final Character? character;
  final File? image;

  @override
  Widget build(BuildContext context) {
    return Container(


      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image == null 
          ? const Icon(Icons.person) 
          : Image.file(image!),
          const SizedBox(height: 10),
          Text(character?.name ?? ''),
        ],
      ),
    );
  }
}
