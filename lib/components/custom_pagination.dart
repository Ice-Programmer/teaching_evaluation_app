import 'package:flutter/material.dart';
import 'package:teaching_evaluation_app/components/page_size_selector.dart';

class CustomPagination extends StatefulWidget {
  final int total;
  final int pageSize;
  final double size;
  final Function(int page, int pageSize)? onChange;
  final Function(int pageSize)? onPageSizeChange;

  const CustomPagination({
    super.key,
    required this.total,
    this.pageSize = 10,
    this.size = 14,
    this.onChange,
    this.onPageSizeChange,
  });

  @override
  State<CustomPagination> createState() => _CustomPaginationState();
}

class _CustomPaginationState extends State<CustomPagination> {
  late int _currentPage;
  late int _pageSize;

  @override
  void initState() {
    super.initState();
    _currentPage = 1;
    _pageSize = widget.pageSize;
  }

  int get totalPages =>
      (widget.total / _pageSize).ceil() == 0
          ? 1
          : (widget.total / _pageSize).ceil();

  void _changePage(int page) {
    setState(() {
      _currentPage = page.clamp(1, totalPages);
    });
    widget.onChange?.call(_currentPage, _pageSize);
  }

  void _changePageSize(int? newSize) {
    if (newSize == null) return;
    setState(() {
      _pageSize = newSize;
      _currentPage = 1;
    });
    widget.onPageSizeChange?.call(_pageSize);
    widget.onChange?.call(_currentPage, _pageSize);
  }

  @override
  Widget build(BuildContext context) {
    final double fontSize = widget.size;
    final double iconSize = fontSize * 1.5;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "共 ${widget.total} 条数据",
          style: TextStyle(fontSize: widget.size, color: Colors.black),
        ),
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            size: iconSize,
            color: _currentPage > 1 ? Colors.black : Color(0xFFC6C6C6),
          ),
          onPressed:
              _currentPage > 1 ? () => _changePage(_currentPage - 1) : null,
        ),

        _buildPageNumberItem(1),

        _buildMiddlePageNumberItem(),

        if (totalPages > 1) _buildPageNumberItem(totalPages),

        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_right_rounded,
            size: iconSize,
            color: _currentPage < totalPages ? Colors.black : Color(0xFFC6C6C6),
          ),
          onPressed:
              () =>
                  _currentPage < totalPages
                      ? _changePage(_currentPage + 1)
                      : null,
        ),

        PageSizeSelector(pageSize: _pageSize, onChanged: _changePageSize),
      ],
    );
  }

  Widget _buildPageNumberItem(int number) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: widget.size * 2.5,
      width: widget.size * 2.5,
      child: ElevatedButton(
        onPressed: () => _changePage(number),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white), // 始终白底
          foregroundColor: WidgetStateProperty.all(
            _currentPage == number ? Colors.white : Colors.black,
          ),
          elevation: WidgetStateProperty.all(0),
          side: WidgetStateProperty.all(
            BorderSide(
              color: _currentPage == number ? Colors.blue : Colors.transparent,
              width: 1.2,
            ),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.size / 2),
            ),
          ),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
        ),
        child: Text(
          number.toString(),
          style: TextStyle(fontSize: widget.size, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildMiddlePageNumberItem() {
    List<Widget> buttons = [];
    if (totalPages <= 5) {
      // 页数较少时直接全部显示
      for (int i = 2; i < totalPages; i++) {
        buttons.add(_buildPageNumberItem(i));
      }
    } else {
      int start = (_currentPage - 2).clamp(2, totalPages - 4);
      int end = (start + 4).clamp(5, totalPages - 1);

      for (int i = start; i <= end; i++) {
        buttons.add(_buildPageNumberItem(i));
      }
    }

    return Row(
      children: [
        if (_currentPage - 1 >= 4)
          Icon(
            Icons.more_horiz_rounded,
            color: Color(0xFFC6C6C6),
            size: widget.size * 1.5,
          ),
        ...buttons,
        if (totalPages - _currentPage >= 4)
          Icon(
            Icons.more_horiz_rounded,
            color: Color(0xFFC6C6C6),
            size: widget.size * 1.5,
          ),
      ],
    );
  }
}
