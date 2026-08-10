import 'package:equatable/equatable.dart';

class ContactInfoEntity extends Equatable {
  final String email;
  final String phone;
  final String location;
  final String linkedInUrl;
  final String gitHubUrl;
  final String gitLabUrl;

  const ContactInfoEntity({
    required this.email,
    required this.phone,
    required this.location,
    this.linkedInUrl = '',
    this.gitHubUrl = '',
    this.gitLabUrl = '',
  });

  @override
  List<Object?> get props => [
        email,
        phone,
        location,
        linkedInUrl,
        gitHubUrl,
        gitLabUrl,
      ];
}

