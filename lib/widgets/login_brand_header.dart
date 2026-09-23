import 'package:flowee_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LoginBrandHeader extends StatelessWidget {
  const LoginBrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 78,
          height: 78,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.16),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.28),
              width: 1.2,
            ),
          ),
          child: Icon(
            Icons.local_florist_rounded,
            size: 40,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20,),
        Text(
          'Flowee',
          style: AppTheme.display(
            fontSize: 32,
            color: Colors.white,
            letterSpacing: 0.5
          ),
        ),
        SizedBox(height: 6,),
        Text(
          'Rangkaian bunga segar, dikirim dengan cintsa',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 13,
          ),
        )
      ],
    );
  }
}
