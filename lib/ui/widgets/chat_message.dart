import 'package:bubble/bubble.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';

class AppBody extends StatelessWidget {
  final List<Map<String, dynamic>> messages;

  const AppBody({
    Key? key,
    this.messages = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, i) {
        var obj = messages[messages.length - 1 - i];
        Message message = obj['message'];
        bool isUserMessage = obj['isUserMessage'] ?? false;
        return Row(
          mainAxisAlignment:
              isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            chat(
              message.text?.text?[0],
              isUserMessage,
            ),
          ],
        );
      },
      separatorBuilder: (_, i) => Container(height: 10),
      itemCount: messages.length,
      reverse: true,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
    );
  }
}

Widget chat(String? message, bool isUserMessage) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Bubble(
        radius: const Radius.circular(15.0),
        color: isUserMessage ? Colors.blue : Colors.orangeAccent,
        elevation: 0.0,
        alignment: isUserMessage ? Alignment.topRight : Alignment.topLeft,
        nip: isUserMessage ? BubbleNip.rightTop : BubbleNip.leftBottom,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(isUserMessage
                    ? "assets/images/user.png"
                    : "assets/images/bot.png"),
              ),
              const SizedBox(width: 10.0),
              SizedBox(
                width: message!.length >= 28 ? 200 : null,
                child: Flexible(
                    child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              )
            ],
          ),
        )),
  );
}
