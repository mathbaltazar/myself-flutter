part of '../user_page.dart';

class _UserImage extends StatelessWidget {
  const _UserImage({required this.url, this.size});

  final String url;
  final double? size;
  static const double _defaultSize = 48;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: size ?? _defaultSize,
      height: size ?? _defaultSize,
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.medium,
          ),
        ),
      ),
      placeholder: (_, __) => const CircularProgressIndicator.adaptive(),
      errorWidget: (context, url, error) => Padding(
        padding: const EdgeInsets.all(10),
        child: FaIcon(FontAwesomeIcons.solidCircleUser, size: size),
      ),
    );
  }
}
