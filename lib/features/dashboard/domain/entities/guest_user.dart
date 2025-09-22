class GuestUserModel {
  final String name;
  final String email;
  final String mobileNo;
  final String? profileImage;

  GuestUserModel({
    required this.name,
    required this.email,
    required this.mobileNo,
    this.profileImage,
  });
}

