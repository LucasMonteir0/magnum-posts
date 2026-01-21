import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

import "../../../commons/presentation/components/app_button.dart";
import "../../../commons/presentation/components/app_text_field.dart";
import "../../../commons/utils/config/routes.dart";
import "../../../commons/utils/helpers/toast_helper.dart";
import "../../../commons/utils/resources/theme/app_theme.dart";
import "../../../commons/utils/states/base_state.dart";
import "../../../commons/utils/validators/app_input_validators.dart";
import "../blocs/sign_in_bloc.dart";

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late final SignInBloc _bloc;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<SignInBloc>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      _bloc.call(_emailController.text.trim(), _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: BlocConsumer<SignInBloc, BaseState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is SuccessState) {
            ToastHelper.showSuccess(context, "Login realizado com sucesso");
            Modular.to.navigate(Routes.posts + Routes.root);
          } else if (state is ErrorState) {
            ToastHelper.showError(context, state.error.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is LoadingState;

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.article_rounded,
                        size: AppSizes.avatarXl,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        "Magnum Posts",
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        "Faça login para continuar",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.xxl),

                      AppTextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        enabled: !isLoading,
                        labelText: "E-mail",
                        hintText: "seu@email.com",
                        prefixIcon: Icons.email_outlined,
                        validator: AppInputValidators.email,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      AppTextField(
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        enabled: !isLoading,
                        isPassword: true,
                        labelText: "Senha",
                        hintText: "••••••••",
                        onFieldSubmitted: (_) => _onSignIn(),
                        validator: AppInputValidators.password,
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      AppButton.filled(
                        text: "Entrar",
                        isLoading: isLoading,
                        onPressed: _onSignIn,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
