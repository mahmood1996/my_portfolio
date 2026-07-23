import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../design_system/theme/app_colors.dart';
import '../../domain/entities/contact_inquiry.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_event.dart';
import '../bloc/portfolio_state.dart';
import 'shared/responsive_section_widget.dart';

final class ContactSectionWidget extends StatefulWidget {
  const ContactSectionWidget({super.key});

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
      context.read<PortfolioBloc>().add(SubmitContactInquiryEvent(inquiry));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isDesktop = sizingInformation.isDesktop;

        return ResponsiveSectionWidget(
          backgroundColor: AppColors.background,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column
              Expanded(
                flex: isDesktop ? 5 : 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ENGAGEMENT',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Let's Discuss Your Strategic Vision",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Currently open to architectural consulting and high-impact partnership opportunities.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 48),

                    // Email Info
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer.withValues(
                              alpha: 0.2,
                            ),
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
                              'EMAIL',
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(color: AppColors.onSurfaceVariant),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'strategy@devexpert.io',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
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
                            color: AppColors.secondaryContainer.withValues(
                              alpha: 0.2,
                            ),
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
                              'LOCATION',
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(color: AppColors.onSurfaceVariant),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Global Architecture | remote',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: AppColors.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              if (isDesktop) const SizedBox(width: 64),

              // Right Form Column
              if (isDesktop) Expanded(flex: 7, child: _buildForm(context)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildForm(BuildContext context) {
    return BlocConsumer<PortfolioBloc, PortfolioState>(
      listener: (context, state) {
        if (state.inquiryStatus == InquiryStatus.success) {
          _nameController.clear();
          _emailController.clear();
          _summaryController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.inquiryMessage ?? 'Inquiry Sent!'),
              backgroundColor: AppColors.primaryContainer,
            ),
          );
        }
      },
      builder: (context, state) {
        final isSubmitting = state.inquiryStatus == InquiryStatus.submitting;

        return Container(
          padding: const EdgeInsets.all(40),
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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'FULL NAME',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(color: AppColors.onSurfaceVariant),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _nameController,
                            style: const TextStyle(color: AppColors.onSurface),
                            decoration: const InputDecoration(
                              hintText: 'John Doe',
                              hintStyle: TextStyle(color: AppColors.outline),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.outlineVariant,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            validator: (val) =>
                                val == null || val.isEmpty ? 'Required' : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CORPORATE EMAIL',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(color: AppColors.onSurfaceVariant),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _emailController,
                            style: const TextStyle(color: AppColors.onSurface),
                            decoration: const InputDecoration(
                              hintText: 'john@company.com',
                              hintStyle: TextStyle(color: AppColors.outline),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.outlineVariant,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            validator: (val) =>
                                val == null || !val.contains('@')
                                ? 'Enter valid email'
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'PROJECT SUMMARY',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _summaryController,
                  maxLines: 4,
                  style: const TextStyle(color: AppColors.onSurface),
                  decoration: const InputDecoration(
                    hintText:
                        'How can I help you scale your mobile infrastructure?',
                    hintStyle: TextStyle(color: AppColors.outline),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.outlineVariant),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                  ),
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
                        : const Text(
                            'Send Strategic Inquiry',
                            style: TextStyle(
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
