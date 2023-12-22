import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/colors.dart';

Widget dataListTile(context, controller, title, subtitle, leadingIcon, isEdit) {
  return ListTile(
    visualDensity: VisualDensity.compact,
    leading: Icon(leadingIcon,
        size: MediaQuery.of(context).size.width * 0.06,
        color: Colors.grey.shade600),
    title: Text(title),
    titleTextStyle: TextStyle(color: Colors.grey.shade600, fontSize: 13),
    subtitle: isEdit
        ? Container(
            height: 24,
            child: Center(
              child: TextFormField(
                controller: controller,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                // initialValue: subtitle,
                cursorHeight: 15,
                cursorColor: tealDarkGreenColor,
                decoration: InputDecoration(
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
          )
        : Text(subtitle),
    subtitleTextStyle:
        TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
    trailing: isEdit
        ? Icon(Icons.edit,
            size: MediaQuery.of(context).size.width * 0.06,
            color: tealGreenColor)
        : Text(''),
  );
}
