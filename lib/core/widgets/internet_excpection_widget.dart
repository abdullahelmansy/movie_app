import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/text_style.dart';

class InternetExcpectionWidget extends StatelessWidget {
  const InternetExcpectionWidget({super.key, required this.onPressed});
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.15,
        ),
        const Icon(
          Icons.cloud_off,
          color: Colors.red,
          size: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Center(
            child: Text(
              'We are unable to show result.\nPleace check your data\nconnection.',
              textAlign: TextAlign.center,
              style: getBodyTextStyle(context, color: Colors.white),
            ),
          ),
        ),
        ElevatedButton(onPressed: onPressed, child: Text('Retry',style: getBodyTextStyle(context),))
      ],
    );
  }
}
