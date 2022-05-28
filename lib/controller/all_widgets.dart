import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header(this.heading);
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          heading,
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).tabBarTheme.labelColor,
          ),
        ),
      );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content);
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(content,
            style: GoogleFonts.loveYaLikeASister(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).tabBarTheme.labelColor,
            )),
      );
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail(
    Key? key,
    this.icon,
    this.detail,
  ) : super(key: key);
  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              detail,
              style: const TextStyle(fontSize: 20.0),
            )
          ],
        ),
      );
}

class StyledButton extends StatelessWidget {
  const StyledButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.deepPurple)),
        onPressed: onPressed,
        child: child,
      );
}
