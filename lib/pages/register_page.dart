import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  Future<void> register() async {
    final email = emailController.text.trim();
    final pass = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    // 🔥 BLACKBOX VALIDATION SESUAI GAMBAR --------------------

    // 1. Semua field kosong
    if (email.isEmpty && pass.isEmpty && confirm.isEmpty) {
      _showError("Please Fill out this field");
      return;
    }

    // 2. Email terisi tetapi password kosong
    if (email.isNotEmpty && (pass.isEmpty || confirm.isEmpty)) {
      _showError("Please Fill out this field");
      return;
    }

    // 3. Password tidak sama
    if (pass != confirm) {
      _showError("Password tidak sama");
      return;
    }

    // ---------------------------------------------------------

    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selamat anda berhasil login')),
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException {
      // 🟥 BLACKBOX: jika gagal simpan → tampilkan pesan error sesuai tabel
      _showError(
        "Data tidak berhasil disimpan. Column count doesn't match value count at row 1",
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  // ---- Helper untuk snackbar ----
  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration:
                  const InputDecoration(labelText: 'Konfirmasi Password'),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: isLoading ? null : register,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
