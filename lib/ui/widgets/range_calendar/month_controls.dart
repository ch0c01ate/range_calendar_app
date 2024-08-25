part of 'range_calendar.dart';

class _MonthControls extends StatelessWidget {
  const _MonthControls({required this.buttonSize});

  final double buttonSize;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _MonthControlButton(
            icon: Icons.arrow_back_sharp,
            size: buttonSize,
            onPressed: context.read<RangeCalendarCubit>().selectPreviousMonth,
          ),
          _MonthControlButton(
            icon: Icons.arrow_forward_sharp,
            size: buttonSize,
            onPressed: context.read<RangeCalendarCubit>().selectNextMonth,
          ),
        ],
      );
}

class _MonthControlButton extends StatelessWidget {
  const _MonthControlButton({required this.icon, required this.onPressed, required this.size});

  final IconData icon;

  final VoidCallback onPressed;

  final double size;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onPressed,
        child: Container(
          height: size,
          width: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryButton,
          ),
          child: Icon(
            icon,
            size: 24,
            color: AppColors.primaryText,
          ),
        ),
      );
}
