import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/widgets/cached_network_image.dart';
import 'package:gulfcoast/view/widgets/custom_button.dart';
import 'package:gulfcoast/view/widgets/custom_scroll_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  XFile? attachFile;
  String imageUrl = '';
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool loading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        loading = true;
      });

      if (attachFile != null) {
        while (!imageUrl.startsWith('http')) {
          try {
            imageUrl = await firebaseStorage
                .ref()
                .child('contact/$id/${basename(attachFile!.path)}')
                .getDownloadURL();
          } catch (e) {
            //
          }
        }
      }

      await firestore.collection('contact').doc(id).set({
        'name': _nameController.text,
        'message': _messageController.text,
        'email': _emailController.text,
        'uid': authController.userData!.uid,
        'id': id,
        'attachFile': imageUrl,
        'timestamp': DateTime.now().microsecondsSinceEpoch.toString()
      });
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
      attachFile = null;
      setState(() {
        loading = false;
      });

      Get.showSnackbar(GetSnackBar(
        margin: const EdgeInsets.all(20),
        message: 'thanks_for_your_message,we_will_reply_as_soon_as_possible'.tr,
        duration: const Duration(seconds: 3),
        borderRadius: 20,
      ));
    }
  }

  pickImage() async {
    final XFile? pickedImages = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedImages != null) {
      setState(() {
        attachFile = pickedImages;
      });

      String filePath = 'contact/$id/${basename(attachFile!.path)}';
      final fileBytes = attachFile!.readAsBytes();
      firebaseStorage
          .ref()
          .child(filePath)
          .putData(
              await fileBytes,
              SettableMetadata(
                contentType: 'image/jpeg',
              ))
          .then((e) async {
        imageUrl = await firebaseStorage.ref().child(filePath).getDownloadURL();
      });
    }
  }

  @override
  void initState() {
    if (authController.userData != null) {
      _emailController.text = authController.userData!.email;
      _nameController.text = authController.userData!.name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollBar(
      child: Center(
        child: Container(
          width: isMobile ? Get.width : 500,
          height: isMobile ? Get.height : 600,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'we_would_love_to_hear_from_you'.tr,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  cursorColor: appTheme.primaryColor,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: appTheme.primaryColor,
                          fontWeight: FontWeight.bold),
                      labelText: 'name',
                      fillColor: Colors.white70,
                      filled: true,
                      border: InputBorder.none),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please_enter_your_name'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  cursorColor: appTheme.primaryColor,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: appTheme.primaryColor,
                          fontWeight: FontWeight.bold),
                      labelText: 'email',
                      fillColor: Colors.white70,
                      filled: true,
                      border: InputBorder.none),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) {
                      return 'please_enter_a_valid_email'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _messageController,
                  cursorColor: appTheme.primaryColor,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: appTheme.primaryColor,
                          fontWeight: FontWeight.bold),
                      labelText: 'message'.tr,
                      fillColor: Colors.white70,
                      filled: true,
                      border: InputBorder.none),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please_enter_your_message'.tr;
                    }
                    return null;
                  },
                ),
                attachFile == null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: InkWell(
                          onTap: () {
                            pickImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.attach_file,
                                color: appTheme.primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'attach_file'.tr,
                                style: TextStyle(
                                  color: appTheme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                            leading: CustomImageNetwork(
                                url: attachFile!.path,
                                width: 50,
                                height: 50,
                                boxFit: BoxFit.fill),
                            title: Text(
                              attachFile!.name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  attachFile = null;
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            )),
                      ),
                CustomButton(
                  title: 'send_message',
                  function: _submitForm,
                  width: 50,
                  loading: loading,
                  color: appTheme.primaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
