import 'package:ecosecha_app/styles/app_colors.dart';
import 'package:ecosecha_app/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const CustomHeader({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTap,
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.whiteshade,
              size: 24,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            text,
            style: KTextStyle.headerTextStyle,
          )
        ],
      ),
    );
  }
}
