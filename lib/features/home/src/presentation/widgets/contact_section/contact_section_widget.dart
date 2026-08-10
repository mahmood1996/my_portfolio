import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/features/home/src/domain/entities/contact_info_entity.dart';
import 'package:portfolio/core/l10n/app_localizations.dart';
import 'package:portfolio/design_system/theme/app_colors.dart';
import 'package:portfolio/features/home/src/domain/entities/contact_inquiry.dart';
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
            InkWell(
              onTap: _launchDirectEmail,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.mail_outline,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.emailLabel,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: AppColors.onSurfaceVariant),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.contactInfo.email,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Phone Info
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Icon(
                    Icons.phone_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.phoneLabel,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: AppColors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.contactInfo.phone,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Location Info
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryContainer.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.secondary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.secondary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.locationLabel,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: AppColors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.contactInfo.location,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
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

        final nameField = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.formFullNameLabel,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: AppColors.onSurface),
              decoration: InputDecoration(
                hintText: l10n.formFullNameHint,
                hintStyle: const TextStyle(color: AppColors.outline),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.outlineVariant),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
              validator: (val) =>
                  val == null || val.trim().isEmpty ? l10n.formFieldRequired : null,
            ),
          ],
        );

        final emailField = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.formCorporateEmailLabel,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              style: const TextStyle(color: AppColors.onSurface),
              decoration: InputDecoration(
                hintText: l10n.formCorporateEmailHint,
                hintStyle: const TextStyle(color: AppColors.outline),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.outlineVariant),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
              validator: (val) =>
                  val == null || !val.contains('@') || val.trim().length < 5
                      ? l10n.formEmailInvalid
                      : null,
            ),
          ],
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
                Text(
                  l10n.formProjectSummaryLabel,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _summaryController,
                  maxLines: 4,
                  style: const TextStyle(color: AppColors.onSurface),
                  decoration: InputDecoration(
                    hintText: l10n.formProjectSummaryHint,
                    hintStyle: const TextStyle(color: AppColors.outline),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.outlineVariant),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                  ),
                  validator: (val) =>
                      val == null || val.trim().isEmpty ? l10n.formFieldRequired : null,
                ),
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
