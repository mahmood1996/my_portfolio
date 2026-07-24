import '../../domain/entities/contact_info_entity.dart';

class ContactInfoModel extends ContactInfoEntity {
  const ContactInfoModel({
    required super.email,
    required super.phone,
    required super.location,
    super.linkedInUrl,
    super.gitHubUrl,
    super.gitLabUrl,
  });

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) {
    return ContactInfoModel(
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      linkedInUrl: json['linkedInUrl'] ?? '',
      gitHubUrl: json['gitHubUrl'] ?? '',
      gitLabUrl: json['gitLabUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'location': location,
      'linkedInUrl': linkedInUrl,
      'gitHubUrl': gitHubUrl,
      'gitLabUrl': gitLabUrl,
    };
  }
}
