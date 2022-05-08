import 'package:breaking_bad/constants.dart';
import 'package:flutter/material.dart';

class EssentialData extends StatelessWidget {
  const EssentialData({
    Key? key,
    required this.header,
    required this.value,
  }) : super(key: key);

  final String header;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                ' $header ',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                    backgroundColor: kGreen),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(value, style: kDetailsStyle),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.transparent,
          )
        ],
      ),
    );
  }
}
