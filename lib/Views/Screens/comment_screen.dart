import 'package:buzpost/Controllers/comment_controller.dart';
import 'package:buzpost/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as tmgo;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({super.key, required this.id});
  final TextEditingController controller = TextEditingController();
  final CommentController _commentController = Get.put(CommentController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _commentController.updatePostId(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(child: Obx(() {
                return ListView.builder(
                    itemCount: _commentController.comments.length,
                    itemBuilder: (context, index) {
                      final comment = _commentController.comments[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage(comment.profilePhoto),
                        ),
                        title: Row(
                          children: [
                            Text(
                              '${comment.username}  ',
                              style:const TextStyle(
                                  fontSize: 20,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              comment.comment,
                              style:const  TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            ///time ago package to be added
                            Text(
                              //timeago.format
                              tmgo.format(comment.datePublished.toDate()),
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${comment.likes.length.toString()} likes' ,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () {
                            _commentController.likeComment(comment.id);
                          },
                          child: Icon(
                            Icons.favorite,
                            size: 40,
                            color: comment.likes.contains(authController.user.uid)? Colors.red : Colors.white,
                          ),
                        ),
                      );
                    });
              })),
              const Divider(),
              ListTile(
                title: TextField(
                  controller: controller,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: buttonColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: buttonColor)),
                  ),
                
                ),
                trailing: TextButton(
                    onPressed: () {
                     _commentController.postComment(controller);
                    },
                    child:const  Text(
                      'Send',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
