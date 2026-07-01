import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../../../cubit/profile/profile_cubit.dart';
import '../../../cubit/profile/profile_state.dart';
import '../../../data/models/Profile/profile_model.dart';
import '../../widget/auth/snackBar_controller_widget.dart';
import 'EditInformationScreen.dart';

class EditPhotoScreen extends StatefulWidget {
  final ProfileData profileData;
  const EditPhotoScreen({Key? key, required this.profileData}) : super(key: key);

  @override
  State<EditPhotoScreen> createState() => _EditPhotoScreenState();
}

class _EditPhotoScreenState extends State<EditPhotoScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  final Color limeGreen = const Color(0xffB8FF1A);
  final Color grayInactive = const Color(0xFFF1F1EF);

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      context.read<ProfileCubit>().updateAvatar(_imageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1FDE1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Edit Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: IconButton(
              padding: const EdgeInsets.only(left: 6),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black54, size: 14),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is AvatarUploadSuccess) {

            showSnackbar(
              title: "update image",
              message: state.message,

            );
          } else if (state is AvatarRemoveSuccess) {
            setState(() { _imageFile = null; });
            showSnackbar(
              title: "remove image",
              message: state.message,
            );
          } else if (state is AvatarActionFailure) {

            showSnackbar(
              title: "failure process",
              message: state.message,
              isError: true,
            );
          }
        },

        builder: (context, state) {

          final isProcessing = state is AvatarUploading || state is AvatarRemoving;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Column(
                children: [

                  Container(
                    decoration: BoxDecoration(color: grayInactive, borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(color: limeGreen, borderRadius: BorderRadius.circular(25)),
                            child: const Center(child: Text('Edit Photo', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13))),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: isProcessing ? null : () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => BlocProvider.value(
                                    value: context.read<ProfileCubit>(),
                                    child: EditInformationScreen(profileData: widget.profileData),
                                  ),
                                ),
                              );
                            },
                            child: const Center(child: Text('Edit Information', style: TextStyle(color: Colors.black54, fontSize: 13))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),


                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 65,
                        backgroundColor: const Color(0xFFEFEFEF),
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!)
                            : (widget.profileData.avatarFullUrl != null ? NetworkImage(widget.profileData.avatarFullUrl!) : null) as ImageProvider?,
                        child: _imageFile == null && widget.profileData.avatarFullUrl == null ? const Icon(Icons.person, size: 50, color: Colors.grey) : null,
                      ),
                      if (isProcessing)
                        const CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.black26,
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      if (!isProcessing)
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(radius: 18, backgroundColor: limeGreen, child: const Icon(Icons.camera_alt_outlined, color: Colors.black, size: 18)),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Profile Photo', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  const Text('JPG, PNG max 5MB', style: TextStyle(color: Colors.grey, fontSize: 11)),
                  const SizedBox(height: 30),


                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isProcessing ? null : _pickImage,
                      style: ElevatedButton.styleFrom(backgroundColor: limeGreen, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                      child: const Text('Choose Photo', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                  ),
                  const SizedBox(height: 12),


                  TextButton(
                    onPressed: isProcessing ? null : () {

                      context.read<ProfileCubit>().removeAvatar();
                    },
                    child: const Text('Remove Photo', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}