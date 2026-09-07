

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_app/providers/auth_provider.dart';
import 'package:new_app/repositories/auth_repository.dart';

class AuthViewModel extends AsyncNotifier<void>{
  late final AuthRepository authRepository;

  @override
  Future<void> build() async{
    authRepository = ref.read(authRepositoryProvider);
  }

  Future<void> register(String email, String password)async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await authRepository.register(email, password);
    });
    }

  Future<void> login(String email, String password)async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await authRepository.login(email, password);
    });
  }

}