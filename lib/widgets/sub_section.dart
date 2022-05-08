import 'package:breaking_bad/constants.dart';
import 'package:flutter/material.dart';

class SubSection extends StatelessWidget {
  const SubSection({
    Key? key,
    required this.header,
    required this.details,
  }) : super(key: key);

  final String header;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            height: 6,
          ),
          Text(
            details,
            style: kDetailsStyle,
          ),
          const Divider(
            color: Colors.transparent,
          )
        ],
      ),
    );
  }
}
