import 'package:flutter/material.dart';

List<Color> colors = [
  Color(0xFFFFFFFF),
  Color(0xffF28B83),
  Color(0xFFFCBC05),
  Color(0xFFd49a89),
  Color(0xFF81b214),
  Color(0xFF00b7c2),
  Color(0xFFE6C9A9),
  Color(0xFFee6f57),
  Color(0xFF838383),
  Color(0xFFfccbcb)
];

class ColorPickerWidget extends StatefulWidget {
  final Function(int) onTap;
  final int selectedIndex;

  ColorPickerWidget({
    this.selectedIndex,
    this.onTap,
  });

  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == null) {
      selectedIndex = widget.selectedIndex;
    }
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onTap(index);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 35,
                width: 35,
                child: Center(
                  child: selectedIndex == index
                      ? Icon(
                          Icons.done,
                          color: Colors.black,
                        )
                      : Container(),
                ),
                decoration: BoxDecoration(
                  color: colors[index],
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
