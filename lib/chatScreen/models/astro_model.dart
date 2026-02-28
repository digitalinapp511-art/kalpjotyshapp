class AstroModel {
  final String id;
  final String name;
  final String number;
  final String email;
  final String experience;
  final List<String> skills;
  final String? profilePhoto;

  AstroModel({
    required this.id,
    required this.name,
    required this.number,
    required this.email,
    required this.experience,
    required this.skills,
    this.profilePhoto,
  });

  factory AstroModel.fromJson(Map<String, dynamic> json) {
    return AstroModel(
      id: json['_id'] ?? json['id'],
      name: json['name'] ?? '',
      number: json['number'] ?? '',
      email: json['email'] ?? '',
      experience: json['experience'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
      profilePhoto: json['profilePhoto'],
    );
  }
}