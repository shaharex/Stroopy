import 'package:flutter/material.dart';

import '../game/game_screen.dart';

class NicknamePage extends StatefulWidget {
  const NicknamePage({super.key});

  @override
  State<NicknamePage> createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {
  final TextEditingController _nameController = TextEditingController();
  late String _selectedImagePath;
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    const Color color = Colors.black;
    BoxShadow bottomShadow = BoxShadow(
      color: color.withOpacity(0.2),
      spreadRadius: 2,
      blurRadius: 6,
      offset: const Offset(0, 5),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            // app bar
            StroopyAppBar(),
            const SizedBox(
              height: 30,
            ),
            // configure your nickname and icon
            ConfigureStrooper(bottomShadow, context),
            const SizedBox(
              height: 50,
            )
          ],
        )),
      ),
    );
  }

  Widget ConfigureStrooper(BoxShadow bottomShadow, BuildContext context) {
    return Container(
      height: 700,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(70),
        boxShadow: [bottomShadow],
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ChooseYourAvatarText(),
          IconsTable(),
          NickName(bottomShadow),
          ToGameButton(context, bottomShadow)
        ],
      ),
    );
  }

  Container StroopyAppBar() {
    return Container(
      width: double.infinity,
      height: 80,
      color: const Color(0xFF00A991),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: Image.asset(
              'assets/logo/img.png',
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              ' Stroopy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w800,
              ),
            ),
          )
        ],
      ),
    );
  }

  Text ChooseYourAvatarText() {
    return const Text(
      'Choose your avatar',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  InkWell ToGameButton(BuildContext context, BoxShadow bottomShadow) {
    return InkWell(
      onTap: () {
        if (_nameController.text.isEmpty || _selectedIndex == -1) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Please enter the nickname and choose icon',
              ),
            ),
          );
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GameScreen(
              playerName: _nameController.text,
              playerIcon: _selectedImagePath,
            );
          }));
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF00A991),
            width: 2,
            style: BorderStyle.solid,
          ),
          boxShadow: [bottomShadow],
        ),
        child: const Icon(
          Icons.arrow_forward,
          color: Color(0xFF00A991),
          size: 50,
        ),
      ),
    );
  }

  Column NickName(BoxShadow bottomShadow) {
    return Column(
      children: [
        const Text(
          'Nickname',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [bottomShadow],
          ),
          child: TextField(
            controller: _nameController,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: 'Name',
              hintStyle: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  Column IconsTable() {
    return Column(
      children: [
        SizedBox(
          width: 330,
          height: 350,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              String imagePath = 'assets/resource/icons/img_${index + 1}.png';
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedImagePath = imagePath;
                    _selectedIndex = index;
                  });
                },
                child: Stack(
                  children: [
                    Image.asset(imagePath),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 0, left: 5, bottom: 10, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: _selectedIndex == index
                            ? Border.all(
                                color: const Color(0xFf00A991), width: 6)
                            : Border.all(color: Colors.white, width: 5),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: 9,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 300,
          height: 1,
          color: Colors.black,
        ),
      ],
    );
  }
}
