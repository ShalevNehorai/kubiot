import 'package:flutter/material.dart';

class GlowingButton extends StatefulWidget {
  Widget? child;

  Color colorStart, colorEnd;

  void Function()? onTap;
  GlowingButton({super.key, this.child, required this.colorStart, required this.colorEnd, this.onTap});

  @override
  State<GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton> {
  bool glowing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapCancel: () {
        setState(() {
          glowing = false;
        });
      },
      onTapUp: (details) {
        setState(() {
          glowing = false;
        });
      },
      onTapDown: (details) {
        setState(() {
          glowing = true;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: 48,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            colors: [
              widget.colorStart,
              widget.colorEnd,
            ]
          ),
          boxShadow: glowing ? [
            BoxShadow(
              color: widget.colorStart.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 16,
              offset: Offset(-8, 0),
            ),
            BoxShadow(
              color: widget.colorEnd.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 16,
              offset: Offset(8, 0),
            ),
            BoxShadow(
              color: widget.colorStart.withOpacity(0.4),
              spreadRadius: 16,
              blurRadius: 32,
              offset: Offset(-8, 0),
            ),
            BoxShadow(
              color: widget.colorEnd.withOpacity(0.4),
              spreadRadius: 16,
              blurRadius: 32,
              offset: Offset(8, 0),
            ),
          ] : [],
        ),
        child: widget.child,
      ),
    );
  }
}