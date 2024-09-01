import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:steps_counter/data/models/user_model.dart';
import 'package:steps_counter/data/data_source/data_storage.dart';
import 'package:steps_counter/core/utils/key_constant.dart';
import 'package:steps_counter/domain/auth_service/auth_service.dart';
import 'package:steps_counter/data/data_source/auth_data_source.dart';
import 'package:steps_counter/generated/l10n.dart';
import 'package:steps_counter/presentation/widgets/default_text_form_field.dart';
import 'package:steps_counter/presentation/widgets/show_toast.dart';

// Updated Profile Screen
class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  final TextEditingController _weightController = TextEditingController();
  File? _profileImage;
  String? _imageUrl;
  UserModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final authService = AuthService();

    // Check if user data exists locally first
    final userData = await DataStorage.readData(KeyConstants.currentUser);
    if (userData != null) {
      var data = jsonDecode(userData);
      setState(() {
        _currentUser = UserModel.fromMap(data, data['uid']);
        _weightController.text = _currentUser?.weight.toString() ?? '';
        _imageUrl = _currentUser?.profileImage;
      });
    } else {
      // If not available locally, fetch from Firestore
      final firebaseUser = authService.getCurrentUser();
      if (firebaseUser != null) {
        final userMap = await authService.getUserData();
        if (userMap != null) {
          setState(() {
            _currentUser = UserModel.fromMap(userMap, firebaseUser.uid);
            _weightController.text = _currentUser?.weight.toString() ?? '';
            _imageUrl = _currentUser?.profileImage;
          });
        }
      }
    }
  }

  Future<void> _updateWeight() async {
    if (_currentUser == null) return;

    // Update weight in Firestore
    final newWeight = double.tryParse(_weightController.text);
    if (newWeight != null) {
      _currentUser = _currentUser!.copyWith(weight: newWeight);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .update({
        'weight': newWeight,
      });
      // Update locally stored data as well
      AuthLocalDataSource().persistAuth(_currentUser!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Weight updated successfully!')),
      );
    }
  }

  Future<void> _pickImage() async {
    // Pick an image from the gallery
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    // Upload image to Firebase Storage and update Firestore
    if (_profileImage == null || _currentUser == null) return;

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('profile_images/${_currentUser!.uid}.jpg');
    await storageRef.putFile(_profileImage!);
    final imageUrl = await storageRef.getDownloadURL();

    // Update profile image URL in Firestore and local storage
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser!.uid)
        .update({
      'profileImage': imageUrl,
    });

    setState(() {
      _imageUrl = imageUrl;
      _currentUser = _currentUser!.copyWith(profileImage: imageUrl);
    });

    // Update locally stored data as well
    AuthLocalDataSource().persistAuth(_currentUser!);

    ToastService.showCustomSnakeBar(
      context: context,
      msg: S.current.profile_image_uploaded_successfully,
      isSuccess: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.user_profile),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 60,
                  backgroundImage:
                      _imageUrl != null ? NetworkImage(_imageUrl!) : null,
                  child: _imageUrl == null
                      ? const Icon(Icons.camera_alt, size: 40)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(_currentUser?.name ?? ""),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultTextFormField(
                  controller: _weightController,
                  errorMsg: S.of(context).enter_your_weight,
                  hintText: S.of(context).enter_your_weight,
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.number,
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _updateWeight,
                  child: Text(S.current.update_weight),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
