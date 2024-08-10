import 'package:flutter/material.dart';
import 'package:hogwarts_sorting_hat/app_constants.dart';
import 'package:hogwarts_sorting_hat/models/attempted_character.dart';
import 'package:hogwarts_sorting_hat/widgets/attempts_box.dart';
import 'package:hogwarts_sorting_hat/widgets/house_box.dart';
import 'package:hogwarts_sorting_hat/widgets/not_in_house_box.dart';

class HomeTab extends StatelessWidget {
  const HomeTab(
      {super.key,
      this.character,
      required this.totalSuccessAttempts,
      required this.totalFailedAttempts,
      required this.onHouseTap});

  final AttemptedCharacter? character;
  final int totalSuccessAttempts;
  final int totalFailedAttempts;
  final Function(House) onHouseTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
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
        ),
        const SizedBox(height: 10),
        character == null
            ? const SizedBox(
                width: 150,
                height: 240,
                child: Center(child: CircularProgressIndicator()))
            : Column(children: [
                SizedBox(
                    width: 150,
                    height: 210,
                    child: Center(
                      child: character?.imageFile == null
                          ? (character?.gender ?? 'male') == 'male'
                              ? Image.asset('assets/images/male_no_avatar.png')
                              : Image.asset(
                                  'assets/images/female_no_avatar.png')
                          : Image.file(character!.imageFile!),
                    )),
                const SizedBox(height: 10),
                Text(character!.name)
              ]),
        const SizedBox(height: 20),
        Expanded(
          child: Row(
            children: [
              HouseBox(
                onHouseTap: () => onHouseTap(House.gryffindor),
                houseName: House.gryffindor.name,
                child: Image.asset('assets/icons/gryffindor.png'),
              ),
              const SizedBox(width: 10),
              HouseBox(
                onHouseTap: () => onHouseTap(House.slytherin),
                houseName: House.slytherin.name,
                child: Image.asset('assets/icons/slytherin.png'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Row(
            children: [
              HouseBox(
                onHouseTap: () => onHouseTap(House.ravenclaw),
                houseName: House.ravenclaw.name,
                child: Image.asset('assets/icons/ravenclaw.png'),
              ),
              const SizedBox(width: 10),
              HouseBox(
                onHouseTap: () => onHouseTap(House.hufflepuff),
                houseName: House.hufflepuff.name,
                child: Image.asset('assets/icons/hufflepuff.png'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        NotInHouseBox(
          onHouseTap: () => onHouseTap(House.NotInHouse),
        ),
      ],
    );
  }
}
