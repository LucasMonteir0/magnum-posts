import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

import "../../../commons/presentation/blocs/sign_out_bloc.dart";
import "../../../commons/presentation/components/app_button.dart";
import "../../../commons/presentation/components/app_error_view.dart";
import "../../../commons/presentation/components/app_network_image.dart";
import "../../../commons/presentation/components/custom_app_bar.dart";
import "../../../commons/presentation/components/loading_indicator.dart";
import "../../../commons/utils/config/routes.dart";
import "../../../commons/utils/helpers/toast_helper.dart";
import "../../../commons/utils/resources/theme/app_theme.dart";
import "../../../commons/utils/states/base_state.dart";
import "../../core/domain/entites/profile_entity.dart";
import "../blocs/get_profile_bloc.dart";

part "sections/profile_header_section.dart";
part "sections/profile_stats_section.dart";
part "sections/profile_interests_section.dart";

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final GetProfileBloc _bloc;
  late final SignOutBloc _signOutBloc;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<GetProfileBloc>();
    _signOutBloc = Modular.get<SignOutBloc>();
    _bloc.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocListener<SignOutBloc, BaseState>(
      bloc: _signOutBloc,
      listener: (context, state) {
        if (state is SuccessState<bool>) {
          Modular.to.pushNamedAndRemoveUntil(
            Routes.auth + Routes.signIn,
            (_) => false,
          );
        } else if (state is ErrorState) {
          ToastHelper.showError(context, state.error.message);
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: "Perfil"),
        body: BlocBuilder<GetProfileBloc, BaseState>(
          bloc: _bloc,
          builder: (context, state) {
            return switch (state) {
              LoadingState() => const LoadingIndicator(),
              ErrorState(error: final error) => AppErrorView(
                message: error.message,
                onRetry: _bloc.call,
              ),
              SuccessState<ProfileEntity>(data: final profile) =>
                SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      _ProfileHeaderSection(
                        profile: profile,
                        theme: theme,
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      _ProfileStatsSection(
                        profile: profile,
                        theme: theme,
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      _ProfileInterestsSection(
                        theme: theme,
                        colorScheme: colorScheme,
                        interests: profile.interests,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      BlocBuilder<SignOutBloc, BaseState>(
                        bloc: _signOutBloc,
                        builder: (context, signOutState) {
                          return AppButton.outlined(
                            text: "Sair",
                            icon: Icons.logout,
                            isLoading: signOutState is LoadingState,
                            onPressed: _signOutBloc.call,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
