import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/colors.dart';

Widget dataListTile(context, title, subtitle, leadingIcon, isEdit) {
  return ListTile(
    visualDensity: VisualDensity.compact,
    leading: Icon(leadingIcon,
        size: MediaQuery.of(context).size.width * 0.06,
        color: Colors.grey.shade600),
    title: Text(title),
    titleTextStyle: TextStyle(color: Colors.grey.shade600),
    subtitle: Text(subtitle),
    subtitleTextStyle:
        TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
    trailing: isEdit
        ? Icon(Icons.edit,
            size: MediaQuery.of(context).size.width * 0.06,
            color: tealGreenColor)
        : Text(''),
  );
}
