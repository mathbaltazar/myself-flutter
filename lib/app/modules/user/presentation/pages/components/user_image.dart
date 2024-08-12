part of '../user_page.dart';

class _UserImage extends StatelessWidget {
  const _UserImage({required this.url, this.size});

  final String url;
  final double? size;
  static const double _defaultSize = 48;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size ?? _defaultSize,
        height: size ?? _defaultSize,
        child: Uri.tryParse(url)?.let(
          (it) => CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) => Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),
            errorWidget: (context, url, error) =>
                _ErrorIcon(size: size ?? _defaultSize),
          ),
        ) ?? _ErrorIcon(size: size ?? _defaultSize));
  }
}

class _ErrorIcon extends StatelessWidget {
  const _ErrorIcon({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.account_circle,
      size: size,
    );
  }
}
