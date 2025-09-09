import 'package:flutter/material.dart';

class LanguageDropdown extends StatefulWidget {
  final String initialValue;
  final List<String> options;
  final ValueChanged<String?>? onChanged;

  const LanguageDropdown({
    super.key,
    required this.initialValue,
    required this.options,
    this.onChanged,
  });

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: isWide ? 16 : 14),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selected,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          isExpanded: true,
          style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          items: widget.options
              .map((lang) => DropdownMenuItem<String>(
                    value: lang,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(lang),
                    ),
                  ))
              .toList(),
          onChanged: (val) {
            if (val == null) return;
            setState(() => _selected = val);
            widget.onChanged?.call(val);
          },
        ),
      ),
    );
  }
}
