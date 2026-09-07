


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_app/repositories/auth_repository.dart';
import 'package:new_app/services/auth_service.dart';
import 'package:new_app/view_models/auth_view_model.dart';

final authServiceProvider = Provider<AuthService>((ref){
  return AuthService();
});

final authRepositoryProvider = Provider<AuthRepository>((ref){
  final authService = ref.watch(authServiceProvider);
  return AuthRepository(authService);
});

final authViewModelProvider = AsyncNotifierProvider<AuthViewModel,void>(
  AuthViewModel.new
);