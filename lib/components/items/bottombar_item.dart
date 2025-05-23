import 'package:ecosecha_app/styles/app_colors.dart';
import 'package:flutter/material.dart';

class BottomBarItem extends StatelessWidget {
  const BottomBarItem(
    this.icon, {
    super.key,
    this.onTap,
    this.color = AppColors.inActiveColor,
    this.activeColor = AppColors.primary,
    this.isActive = false,
    this.isNotified = false,
  });

  final IconData icon;
  final Color color;
  final Color activeColor;
  final bool isNotified;
  final bool isActive;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [isNotified ? _buildNotifiedIcon() : _buildIcon()],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.white.withOpacity(.15) : Colors.transparent,
      ),
      child: Icon(
        icon,
        size: 26,
        color: isActive ? activeColor : color,
      ),
    );
  }

  Widget _buildNotifiedIcon() {
    return Stack(
      children: <Widget>[
        Icon(
          icon,
          size: 26,
          color: isActive ? activeColor : color,
        ),
        const Positioned(
          top: 5.0,
          right: 0,
          left: 8.0,
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.brightness_1,
              size: 10.0,
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}
