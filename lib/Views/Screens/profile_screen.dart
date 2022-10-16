import 'package:buzpost/Controllers/profile_controller.dart';
import 'package:buzpost/constant.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  final String uid;
  Profile({
    super.key,
    required this.uid,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

  final ProfileController controller = Get.put(ProfileController());

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    controller.updateUserId(widget.uid);
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        if(controller.user.isEmpty){
          return const  Center(child: CircularProgressIndicator(),);
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 202, 104, 104),
            leading: const Icon(Icons.person_add_alt_1_outlined),
            actions: const [Icon(Icons.more_horiz)],
            centerTitle: true,
            title:  Text(
             controller.user['name'],
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          body: SafeArea(
              child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                          child: CachedNetworkImage(
                        imageUrl:  controller.user['photoUrl'],
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                           Text(
                             controller.user['following'],
                            style:const  TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Following',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 15,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                      ),
                      Column(
                        children: [
                           Text(
                             controller.user['followers'],
                            style:const  TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Followers',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.black,
                        width: 1,
                        height: 15,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                      ),
                      Column(
                        children: [
                          Text(
                             controller.user['likes'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Likes',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        width: 10,
                        height: 47,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12
                          )
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: (){
                              if(widget.uid==authController.user.uid){
                                authController.signOut();
                              }
                            },
                            child: Text(
                              widget.uid ==authController.user.uid? 'SignOut': controller.user['isFollowing']?'UnFollow':'Follow',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          )),
        );
      }
    );
  }
}


///3 hours 41 mins 