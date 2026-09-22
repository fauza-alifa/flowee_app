import 'package:flowee_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.primary.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: selected ? AppTheme.primary : Colors.transparent,
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              child: selected
                  ? Padding(
                      padding: EdgeInsetsGeometry.only(left: 8),
                      child: Text(
                        label,
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ),
            // animate the change of size of the child.
            // Here is used so the label come with animation 'spread',
            // at first the width 0 not suddenly appear
          ],
        ),
      ),
    );
  }
}
