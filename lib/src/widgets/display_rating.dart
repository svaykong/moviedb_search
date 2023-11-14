import 'package:flutter/material.dart';

class DisplayRating extends StatelessWidget {
  const DisplayRating({
    super.key,
    required this.voteAvg,
  });

  final double voteAvg;

  @override
  Widget build(BuildContext context) {
    var vote = voteAvg.floor();
    var stars = <Widget>[];
    for (var i = 0; i < 5; i++) {
      // vote: 8 -> 10
      if (vote >= 8) {
        stars = [
          ...stars,
          const Icon(
            Icons.star,
            color: Colors.orangeAccent,
          )
        ];
      }

      // vote: 6 -> 8
      else if (vote >= 6) {
        if (i == 3) {
          stars = [
            ...stars,
            iconColorMixed,
          ];
        } else if (i == 4) {
          stars = [
            ...stars,
            const Icon(
              Icons.star,
              color: Colors.black,
            )
          ];
        } else {
          stars = [
            ...stars,
            const Icon(
              Icons.star,
              color: Colors.orangeAccent,
            )
          ];
        }
      } else if (voteAvg.floor() >= 5) {
        if (i == 2) {
          stars = [
            ...stars,
            iconColorMixed,
          ];
        } else if (i == 3 || i == 4) {
          stars = [
            ...stars,
            const Icon(
              Icons.star,
              color: Colors.black,
            ),
          ];
        } else {
          stars = [
            ...stars,
            const Icon(
              Icons.star,
              color: Colors.orangeAccent,
            )
          ];
        }
      } else {
        stars = [
          ...stars,
          const Icon(
            Icons.star,
            color: Colors.black,
          )
        ];
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...stars,
        Chip(
          label: Text(
            (voteAvg * 10).round().toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: const CircleBorder(),
          backgroundColor: Colors.blueGrey[900],
        ),
      ],
    );
  }

  Widget get iconColorMixed {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => const RadialGradient(
        center: Alignment.centerRight,
        stops: [.9, 1],
        colors: [
          Colors.black,
          Colors.orangeAccent,
        ],
      ).createShader(bounds),
      child: const Icon(
        Icons.star,
      ),
    );
  }
}
