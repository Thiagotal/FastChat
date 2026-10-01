// ============================================================================
// app_theme.dart
// Centraliza a identidade visual do app: cores oficiais e o tema (ThemeData)
// aplicado a todos os widgets (botões, campos de texto, cards, navegação...).
// Manter tudo em um único lugar facilita trocar as cores/estilo do app inteiro.
// ============================================================================

import 'package:flutter/material.dart';

/// Paleta baseada na identidade visual fornecida (tons de azul e laranja).
/// Usar essas constantes em vez de cores "soltas" no código garante
/// consistência visual em todas as telas.
class AppColors {
  static const azulPrincipal = Color(0xFF0B3B8C);
  static const azulEscuro = Color(0xFF0A2A66);
  static const azulClaro = Color(0xFF1C6DD0);
  static const laranja = Color(0xFFF7941D);
  static const laranjaEscuro = Color(0xFFE07B00);
  static const fundoClaro = Color(0xFFF3F6FB);
}

/// Classe responsável por montar o ThemeData (tema global) do MaterialApp.
/// É chamada em main.dart através de "AppTheme.tema".
class AppTheme {
  static ThemeData get tema {
    // Gera um esquema de cores (ColorScheme) a partir da cor principal,
    // seguindo as diretrizes do Material 3, e depois sobrescreve algumas
    // cores específicas (primary, secondary, surface) com a paleta da marca.
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.azulPrincipal,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.azulPrincipal,
      secondary: AppColors.laranja,
      surface: Colors.white,
    );

    return ThemeData(
      // Habilita os componentes visuais mais recentes do Flutter (Material 3).
      useMaterial3: true,
      colorScheme: colorScheme,
      // Cor de fundo padrão de todas as telas (Scaffold).
      scaffoldBackgroundColor: AppColors.fundoClaro,

      // Estilo padrão da barra superior (AppBar) de todas as telas.
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.azulPrincipal,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),

      // Estilo padrão dos botões elevados (ElevatedButton), como o botão "ENTRAR".
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.laranja,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.4),
        ),
      ),

      // Estilo da barra de navegação inferior (usada na HomeScreen para
      // alternar entre "Setores" e "Chatbot").
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.laranja.withOpacity(0.18),
        // Define a cor do ícone dependendo se o item está selecionado ou não.
        iconTheme: MaterialStateProperty.resolveWith((states) {
          final selecionado = states.contains(MaterialState.selected);
          return IconThemeData(
            color: selecionado ? AppColors.azulPrincipal : Colors.grey[500],
          );
        }),
        // Mesma lógica, mas para o texto (label) do item da navegação.
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          final selecionado = states.contains(MaterialState.selected);
          return TextStyle(
            color: selecionado ? AppColors.azulPrincipal : Colors.grey[600],
            fontWeight: selecionado ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          );
        }),
      ),

      // Estilo padrão dos campos de texto (TextField), usados na tela de login.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.azulClaro, width: 2),
        ),
        labelStyle: const TextStyle(color: AppColors.azulEscuro),
      ),

      // Estilo padrão dos Cards (usado no login e no detalhe do colaborador).
      cardTheme: CardThemeData(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Cor padrão dos ícones dentro de ListTile (itens de lista).
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.azulPrincipal,
      ),
    );
  }
}
