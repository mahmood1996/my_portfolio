import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/l10n/app_localizations.dart';
import '../../../../../../design_system/theme/app_colors.dart';
import '../../../domain/entities/contact_info_entity.dart';
import '../../../domain/entities/contact_inquiry.dart';
import '../../cubit/contact_inquiry_cubit.dart';
import '../../cubit/contact_inquiry_state.dart';
import '../shared/responsive_section_widget.dart';

final class ContactSectionWidget extends StatefulWidget {
  final ContactInfoEntity contactInfo;

  const ContactSectionWidget({super.key, required this.contactInfo});

  @override
  State<ContactSectionWidget> createState() => _ContactSectionWidgetState();
}

final class _ContactSectionWidgetState extends State<ContactSectionWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _summaryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final inquiry = ContactInquiry(
        fullName: _nameController.text.trim(),
        corporateEmail: _emailController.text.trim(),
        projectSummary: _summaryController.text.trim(),
      );
      context.read<ContactInquiryCubit>().submitInquiry(inquiry);
    }
  }

  Future<void> _launchDirectEmail() async {
    final name = Uri.encodeComponent(_nameController.text.trim());
    final body = Uri.encodeComponent(_summaryController.text.trim());
    final subject = Uri.encodeComponent(
      name.isNotEmpty ? 'Strategic Inquiry from $name' : 'Portfolio Inquiry',
    );
    final email = widget.contactInfo.email;
    final uri = Uri.parse('mailto:$email?subject=$subject&body=$body');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isDesktop = sizingInformation.isDesktop;

        final leftColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.contactSectionTag,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.primary,
                    letterSpacing: 2.0,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.contactSectionTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.contactSectionSubtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 48),

            // Email Info
            _ContactInfoTile(
              icon: Icons.mail_outline,
              label: l10n.emailLabel,
              value: widget.contactInfo.email,
              onTap: _launchDirectEmail,
            ),
            const SizedBox(height: 24),

            // Phone Info
            _ContactInfoTile(
              icon: Icons.phone_outlined,
              label: l10n.phoneLabel,
              value: widget.contactInfo.phone,
            ),
            const SizedBox(height: 24),

            // Location Info
            _ContactInfoTile(
              icon: Icons.location_on_outlined,
              label: l10n.locationLabel,
              value: widget.contactInfo.location,
              iconColor: AppColors.secondary,
              containerColor: AppColors.secondaryContainer,
            ),
          ],
        );

        final formWidget = _buildForm(context, l10n, isDesktop);

        return ResponsiveSectionWidget(
          backgroundColor: AppColors.background,
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: leftColumn),
                    const SizedBox(width: 64),
                    Expanded(flex: 7, child: formWidget),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    leftColumn,
                    const SizedBox(height: 48),
                    formWidget,
                  ],
                ),
        );
      },
    );
  }

  Widget _buildForm(
    BuildContext context,
    AppLocalizations l10n,
    bool isDesktop,
  ) {
    return BlocConsumer<ContactInquiryCubit, ContactInquiryState>(
      listener: (context, state) {
        if (state.status == ContactInquiryStatus.success) {
          _nameController.clear();
          _emailController.clear();
          _summaryController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message ?? l10n.inquirySentDefault,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColors.primary,
              duration: const Duration(seconds: 4),
            ),
          );
        } else if (state.status == ContactInquiryStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message ?? 'Failed to send inquiry.',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.redAccent,
              duration: const Duration(seconds: 6),
              action: SnackBarAction(
                label: 'Email Directly',
                textColor: Colors.white,
                onPressed: _launchDirectEmail,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final isSubmitting = state.status == ContactInquiryStatus.submitting;

        final nameField = _ContactFormField(
          label: l10n.formFullNameLabel,
          hintText: l10n.formFullNameHint,
          controller: _nameController,
          validator: (val) =>
              val == null || val.trim().isEmpty ? l10n.formFieldRequired : null,
        );

        final emailField = _ContactFormField(
          label: l10n.formCorporateEmailLabel,
          hintText: l10n.formCorporateEmailHint,
          controller: _emailController,
          validator: (val) =>
              val == null || !val.contains('@') || val.trim().length < 5
                  ? l10n.formEmailInvalid
                  : null,
        );

        final summaryField = _ContactFormField(
          label: l10n.formProjectSummaryLabel,
          hintText: l10n.formProjectSummaryHint,
          controller: _summaryController,
          maxLines: 4,
          validator: (val) =>
              val == null || val.trim().isEmpty ? l10n.formFieldRequired : null,
        );

        return Container(
          padding: EdgeInsets.all(isDesktop ? 40 : 24),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(child: nameField),
                      const SizedBox(width: 24),
                      Expanded(child: emailField),
                    ],
                  )
                else ...[
                  nameField,
                  const SizedBox(height: 24),
                  emailField,
                ],
                const SizedBox(height: 32),
                summaryField,
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: isSubmitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: isSubmitting
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: AppColors.onPrimary,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            l10n.sendStrategicInquiry,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ContactInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
  final Color containerColor;
  final VoidCallback? onTap;

  const _ContactInfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor = AppColors.primary,
    this.containerColor = AppColors.primaryContainer,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: containerColor.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: iconColor.withValues(alpha: 0.3),
            ),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ],
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: content,
        ),
      );
    }

    return content;
  }
}

class _ContactFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int maxLines;

  const _ContactFormField({
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: AppColors.onSurface),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.outline),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.outlineVariant),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}

