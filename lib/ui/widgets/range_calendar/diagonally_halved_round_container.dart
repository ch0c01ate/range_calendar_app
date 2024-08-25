part of 'range_calendar.dart';

class _DiagonallyHalvedRoundContainer extends StatelessWidget {
  const _DiagonallyHalvedRoundContainer({
    required this.size,
    required this.topLeftColor,
    required this.bottomRightColor,
    required this.child,
  });

  final double size;

  final Widget child;

  final Color topLeftColor;
  final Color bottomRightColor;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: size,
            width: size,
            color: bottomRightColor,
          ),
          ClipPath(
            clipper: const _DiagonalClipPath(),
            child: Container(
              height: size,
              width: size,
              color: topLeftColor,
            ),
          ),
          child,
        ],
      );
}

class _DiagonalClipPath extends CustomClipper<Path> {
  const _DiagonalClipPath();

  @override
  Path getClip(Size size) => Path()
    ..lineTo(size.width, 0)
    ..lineTo(0, size.height)
    ..lineTo(0, 0);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
