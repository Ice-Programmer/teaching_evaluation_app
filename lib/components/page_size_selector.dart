import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class PageSizeSelector extends StatefulWidget {
  final int pageSize;
  final List<int> options;
  final ValueChanged<int>? onChanged;
  final double fontSize;

  const PageSizeSelector({
    super.key,
    required this.pageSize,
    this.options = const [13, 20, 50, 100],
    this.onChanged,
    this.fontSize = 14,
  });

  @override
  State<PageSizeSelector> createState() => _PageSizeSelectorState();
}

class _PageSizeSelectorState extends State<PageSizeSelector> {
  int? _hoveredItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<int>(
      isExpanded: true,
      underline: const SizedBox(), // 去掉下划线
      value: widget.pageSize,
      onChanged: (value) {
        if (value != null) {
          widget.onChanged?.call(value);
        }
      },
      customButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '每页 ${widget.pageSize} 条',
              style: TextStyle(
                fontSize: widget.fontSize,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(padding: EdgeInsets.zero),
      dropdownStyleData: DropdownStyleData(
        padding: EdgeInsets.zero,
        elevation: 0,
        offset: const Offset(0, 0),
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),

      // ✅ 选项渲染
      items:
          widget.options.map((item) {
            final bool isSelected = item == widget.pageSize;
            final bool isHovered = item == _hoveredItem;
            return DropdownMenuItem<int>(
              value: item,
              child: MouseRegion(
                onEnter: (_) => setState(() => _hoveredItem = item),
                onExit: (_) => setState(() => _hoveredItem = null),
                child: Container(
                  width: double.infinity,
                  color:
                      isSelected
                          ? Colors.blue.shade50
                          : (isHovered
                              ? Colors.grey.shade100
                              : Colors.transparent),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  child: Text(
                    '$item 条/页',
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      color: isSelected ? Colors.blue : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
