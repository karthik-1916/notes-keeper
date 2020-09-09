import 'package:flutter/material.dart';
import '../models/note.dart';
import 'snackbar.dart';

class CustomTextFormWidget extends StatelessWidget {
  final Note note;
  final String hintText;
  final TextEditingController textEditingController;
  final double textSize;
  final int maxLength;
  final FontWeight fontWeight;
  final int minLine;
  final int maxLine;

  CustomTextFormWidget({
    @required this.note,
    @required this.hintText,
    @required this.textEditingController,
    @required this.textSize,
    @required this.maxLength,
    @required this.fontWeight,
    this.minLine,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          print(DateTime.parse(note.reminder));
          if (note.trashed == 'true')
            showSnackBar(context, 'Restore the Note to Edit');
        },
        child: TextFormField(
          enabled: note.trashed == 'true' ? false : true,
          keyboardType: TextInputType.multiline,
          minLines: minLine,
          maxLines: maxLine,
          controller: textEditingController,
          maxLength: maxLength,
          style: TextStyle(
            fontSize: textSize,
            fontWeight: fontWeight,
            color: Colors.black,
          ),
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
            disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
            hintText: hintText,
            hintStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5),
          ),
        ),
      ),
    );
  }
}
