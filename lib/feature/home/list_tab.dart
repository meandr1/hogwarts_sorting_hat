import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_sorting_hat/feature/home/cubit/home_cubit.dart';
import 'package:hogwarts_sorting_hat/models/attempted_character.dart';
import 'package:hogwarts_sorting_hat/widgets/attempts_box.dart';
import 'package:hogwarts_sorting_hat/widgets/character_card.dart';

class ListTab extends StatelessWidget {
  const ListTab({
    super.key,
    required this.onReload,
    required this.characters,
    required this.totalSuccessAttempts,
    required this.totalFailedAttempts,
  });

  final void Function() onReload;
  final List<AttemptedCharacter> characters;
  final int totalSuccessAttempts;
  final int totalFailedAttempts;

  @override
  Widget build(BuildContext context) {
    final textFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 2.0,
      ),
    );
    return Column(
      children: [
        Row(
          children: [
            AttemptsBox(
                text: "Total",
                attempts: totalSuccessAttempts + totalFailedAttempts),
            const Spacer(),
            AttemptsBox(text: "Success", attempts: totalSuccessAttempts),
            const Spacer(),
            AttemptsBox(text: "Failed", attempts: totalFailedAttempts),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 10),
          child: TextField(
            onChanged: (pattern) =>
                context.read<HomeCubit>().filterUsers(pattern),
            decoration: InputDecoration(
                hintText: 'Filter characters...',
                prefixIcon: Icon(Icons.search),
                border: textFieldBorder,
                enabledBorder: textFieldBorder,
                focusedBorder: textFieldBorder),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: CharacterCard(
                  onReload: onReload,
                  character: character,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
