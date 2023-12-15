import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class chatcard extends StatelessWidget {
  final bool ismychat;
  final String message;
  final String time;
  const chatcard(
      {super.key,
      required this.message,
      required this.time,
      required this.ismychat});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: ismychat ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
          color: ismychat ? mychatcolor : Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 30, 20),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Positioned(
                  bottom: ismychat ? 4 : 2,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.done_all,
                        size: 16,
                        color: Colors.blue,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
