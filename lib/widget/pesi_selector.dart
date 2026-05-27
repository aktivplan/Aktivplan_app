import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/activity_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PesiSelector extends StatefulWidget {
  final int? initialValue;
  final ValueChanged<int>? onChanged;
  final double height;
  final double borderRadius;
  final Color selectedColor;
  final Color borderColor;

  const PesiSelector({
    super.key,
    this.initialValue,
    this.onChanged,
    this.height = 64,
    this.borderRadius = 16,
    this.selectedColor = const Color(0xFF64B5F6),
    this.borderColor = const Color(0xFFB0BEC5),
  });

  @override
  State<PesiSelector> createState() => _PesiSelectorState();
}

class _PesiSelectorState extends State<PesiSelector> {
  int? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant PesiSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _value = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          context.i18n.pesiQuestion,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 1.01,
                height: 1.8,
              ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SelectableText(context.i18n.pesiValue_1.toLowerCase(), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: lightTextColor)),
            Spacer(),
            SelectableText(context.i18n.pesiValue_5.toLowerCase(), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: lightTextColor)),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            border: Border.all(color: widget.borderColor),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: List.generate(5, (index) {
                  final value = index + 1;
                  final isSelected = _value == value;
                  final path = 'assets/images/pesi-${value + (isSelected ? 5 : 0)}.svg';

                  return Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _value = value;
                        });
                        widget.onChanged?.call(value);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        child: SvgPicture.asset(
                          path,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        if (_value != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Center(
              child: SelectableText(
                getPesiValueText(context, _value!),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.01,
                    ),
              ),
            ),
          ),
        SizedBox(height: 8),
      ],
    );
  }
}
