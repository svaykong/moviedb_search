import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';

import '../../models/base_movie_model.dart';
import '../../widgets/display_rating.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({
    super.key,
    required this.item,
  });

  final Result item;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          item.posterPath == null
              ? const Text('No image')
              : CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                    child: CircularProgressIndicator(value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl: item.posterPath!,
                  fit: BoxFit.cover,
                  height: height * 0.15,
                ),
          const Gap(10.0),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(10.0),
                item.overview.isEmpty
                    ? const SizedBox.shrink()
                    : Text(
                        item.overview,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                DisplayRating(voteAvg: item.voteAverage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
