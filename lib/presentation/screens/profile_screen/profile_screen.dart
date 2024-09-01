import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:steps_counter/core/utils/app_colors.dart';
import 'package:steps_counter/data/models/user_model.dart';
import 'package:steps_counter/domain/auth_service/user_profile_notifier.dart';
import 'package:steps_counter/generated/l10n.dart';
import 'package:steps_counter/presentation/widgets/default_text_form_field.dart';
import 'package:steps_counter/presentation/widgets/show_toast.dart';

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
    final userState = ref.read(userProfileProvider);

    userState.when(
      data: (user) {
        setState(() {
          _currentUser = user;
          _weightController.text = user?.weight.toString() ?? '';
          _imageUrl = user?.profileImage;
        });
      },
      loading: () => debugPrint('Loading user data...'),
      error: (e, _) => debugPrint('Error loading user data: $e'),
    );
  }

  Future<void> _updateWeight() async {
    final newWeight = double.tryParse(_weightController.text);
    if (newWeight != null) {
      await ref.read(userProfileProvider.notifier).updateWeight(newWeight);
      ToastService.showCustomSnakeBar(
        context: context,
        msg: S.current.weight_uploaded_successfully,
        isSuccess: true,
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
    if (_profileImage == null || _currentUser == null) return;

    await ref.read(userProfileProvider.notifier).updateProfileImage(
          _profileImage!,
          _currentUser!.uid,
        );

    ToastService.showCustomSnakeBar(
      context: context,
      msg: S.current.profile_image_uploaded_successfully,
      isSuccess: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<UserModel?>>(userProfileProvider, (previous, next) {
      if (next is AsyncData && next.value != null) {
        setState(() {
          _currentUser = next.value;
          _weightController.text = _currentUser?.weight.toString() ?? '';
          _imageUrl = _currentUser?.profileImage;
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.user_profile),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 60,
                      backgroundImage:
                          _imageUrl != null ? NetworkImage(_imageUrl!) : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _currentUser?.name ?? "",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DefaultTextFormField(
                    controller: _weightController,
                    errorMsg: S.of(context).enter_your_weight,
                    hintText: S.of(context).enter_your_weight,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _updateWeight,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 10),
                      child: Text(
                        S.current.update_weight,
                        style: const TextStyle(
                          color: AppColors.kScaffoldBackgroundColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
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
