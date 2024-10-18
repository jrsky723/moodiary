import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';

class PostUser extends StatelessWidget {
  final UserProfileModel owner;
  final DateTime date;

  const PostUser({
    super.key,
    required this.owner,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: owner.hasAvatar
            ? NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/moodiary-b37ca.appspot.com/o/avatars%2F${owner.uid}?alt=media&test=${DateTime.now().millisecondsSinceEpoch}",
              )
            : null,
        child: Text(
          owner.hasAvatar
              ? ''
              : owner.username == ''
                  ? 'U'
                  : owner.username[0],
          style: const TextStyle(fontSize: Sizes.size24),
        ),
      ),
      title: Text(owner.username),
      subtitle: Text(
        DateFormat.yMMMd().format(date),
        style: const TextStyle(
          color: Colors.grey,
          fontSize: Sizes.size12,
        ),
      ),
    );
  }
}
