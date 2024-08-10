import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hogwarts_sorting_hat/feature/home/cubit/home_cubit.dart';
import 'package:hogwarts_sorting_hat/models/attempted_character.dart';

class CharacterCard extends StatelessWidget {
  final AttemptedCharacter character;
  final void Function() onReload;

  const CharacterCard(
      {super.key, required this.character, required this.onReload});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.go('/DetailsScreen', extra: {'character': character}),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            height: 56,
            child: Center(
              child: character.imageFile == null
                  ? (character.gender ?? 'male') == 'male'
                      ? Image.asset('assets/images/male_no_avatar.png')
                      : Image.asset('assets/images/female_no_avatar.png')
                  : Image.file(character.imageFile!),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(character.name),
              const SizedBox(height: 5),
              Text('Attempts: ${character.totalAttempts}'),
            ],
          ),
          const Spacer(),
          if (character.isGuessed)
            const Icon(
              Icons.check,
              color: Colors.green,
            )
          else
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      context.read<HomeCubit>().reload(character);
                      onReload();
                    },
                    icon: const Icon(Icons.replay_outlined)),
                const Icon(
                  Icons.close,
                  color: Colors.red,
                )
              ],
            )
        ],
      ),
    );
  }
}
