// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class card_note extends StatelessWidget {
  final void Function()? ontap;
  final void Function()? onDlete;

  const card_note({
    super.key,
    required this.ontap,
    required this.onDlete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: ontap,
        child: Card(
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                "",
                height: 150,
                width: 300,
              ),
            ),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: const Text(
                    "Title",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text("Content",
                      style: TextStyle(
                        fontSize: 17,
                      )),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: onDlete,
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
