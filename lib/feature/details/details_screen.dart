import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hogwarts_sorting_hat/app_colors.dart';
import 'package:hogwarts_sorting_hat/models/attempted_character.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.character});

  final AttemptedCharacter character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  color: Colors.black,
                  height: 2,
                ),
              )),
          backgroundColor: AppColors.backgroundPrimary,
          leadingWidth: 110,
          leading: TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
            ),
            onPressed: () => context.go('/HomeScreen', extra: {'index': 1}),
            icon: const Icon(Icons.arrow_back_ios),
            label: const Text('Back',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimaryColor)),
          ),
          title: Text(
            character.name,
            style: const TextStyle(
                fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 150,
                    height: 210,
                    child: Center(
                      child: character.imageFile == null
                          ? (character.gender ?? 'male') == 'male'
                              ? Image.asset('assets/images/male_no_avatar.png')
                              : Image.asset(
                                  'assets/images/female_no_avatar.png')
                          : Image.file(character.imageFile!),
                    )),
                const SizedBox(width: 15),
                character.isGuessed
                    ? Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'House: ${character.house?.isEmpty ?? true ? 'Not in house' : character.house}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Date of Birth: ${character.dateOfBirth?.isEmpty ?? true ? 'Unknown' : character.dateOfBirth}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Actor: ${character.actor?.isEmpty ?? true ? 'Unknown' : character.actor}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Species: ${character.species?.isEmpty ?? true ? 'Unknown' : character.species}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: Image.asset('assets/images/access_denied.png')),
              ],
            ),
          ),
        ));
  }
}
