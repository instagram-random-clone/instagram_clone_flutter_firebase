import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter_firebase/controllers/user_controllers.dart';
import 'package:instagram_clone_flutter_firebase/resources/firestore_methods.dart';
import 'package:instagram_clone_flutter_firebase/utils/colors.dart';
import 'package:instagram_clone_flutter_firebase/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool _isUploading = false;
  final TextEditingController _descriptionController = TextEditingController();

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create a post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20.0),
                child: const Text("Take a photo"),
                onPressed: () async {
                  // Remove this Dialog box
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20.0),
                child: const Text("Choose from gallery"),
                onPressed: () async {
                  // Remove this Dialog box
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20.0),
                child: const Text("Cancel"),
                onPressed: () async {
                  // Remove this Dialog box
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  postImage(String uid, String profileImageUrl, String username) async {
    setState(() {
      _isUploading = true;
    });
    String res = await FirestoreMethods().uploadPost(
        _file!, _descriptionController.text, uid, profileImageUrl, username);
    setState(() {
      _isUploading = false;
    });
    if (res == "success") {
      Get.snackbar("success", 'post successful');
      setState(() {
        _file = null;
      });
    } else {
      Get.snackbar("error", res);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Center(
            child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _selectImage(context),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("Post to"),
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    _file = null;
                  });
                },
                icon: const Icon(Icons.arrow_back),
              ),
              actions: [
                GetBuilder<UserController>(
                  init: UserController(),
                  builder: (_) {
                    return TextButton(
                        onPressed: () => postImage(_.user.uid,
                            _.user.profileImageUrl, _.user.username),
                        child: const Text(
                          "Post",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ));
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _isUploading ? const LinearProgressIndicator() : Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      // height: 200,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  alignment: FractionalOffset.topCenter,
                                  image: MemoryImage(_file!))),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<UserController>(
                        init: UserController(),
                        builder: (_) {
                          return CircleAvatar(
                            backgroundImage:
                                NetworkImage(_.user.profileImageUrl),
                          );
                        },
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                              hintText: "White a caption...",
                              border: InputBorder.none),
                          maxLines: 6,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
