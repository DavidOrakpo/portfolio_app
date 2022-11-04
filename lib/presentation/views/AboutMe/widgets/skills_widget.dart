import 'dart:async';

import 'package:flutter/material.dart';

class SkillsWidget extends StatefulWidget {
  SkillsWidget({
    Key? key,
    this.title,
    required this.isFirstSequence,
  })  : isInverseSequence = !isFirstSequence!,
        super(key: key);
  final String? title;
  bool? isFirstSequence, isInverseSequence;
  @override
  State<SkillsWidget> createState() => _SkillsWidgetState();
}

class _SkillsWidgetState extends State<SkillsWidget> {
  Timer? timer, offSyncTimer;
  bool? firstSequence = true, inverseSequence = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        firstSequence = !firstSequence!;
      });
    });

    offSyncTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        inverseSequence = !inverseSequence!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (timer != null) {
      timer?.cancel();
    }
    if (offSyncTimer != null) {
      offSyncTimer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFirstSequence!
        ? AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: firstSequence! ? 80 : 90,
            width: firstSequence! ? 80 : 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 129, 180, 221),
                  Color.fromRGBO(5, 70, 123, 1),
                ],
                stops: [0, 0.5],
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                  offset: const Offset(2, 3),
                  blurRadius: 13,
                )
              ],
            ),
            child: Center(
              child: Text(
                widget.title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        //! SECOND SEQUENCE
        : AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: inverseSequence! ? 80 : 90,
            width: inverseSequence! ? 80 : 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 129, 180, 221),
                  Color.fromRGBO(5, 70, 123, 1),
                ],
                stops: [0, 0.5],
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                  offset: const Offset(2, 3),
                  blurRadius: 13,
                )
              ],
            ),
            child: Center(
              child: Text(
                widget.title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
  }
}
