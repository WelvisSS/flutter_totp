# Plus Jakarta Sans - Configuração da Fonte

A fonte **Plus Jakarta Sans** foi configurada como fonte padrão do projeto e está integrada ao sistema de tema.

## ✅ Status da Implementação

- ✅ **pubspec.yaml** configurado com definições de fonte
- ✅ **AppTypography** atualizado com Plus Jakarta Sans em todos os estilos
- ✅ **AppTheme** configurado com `fontFamily: 'Plus Jakarta Sans'`
- ✅ **Pesos de fonte** definidos: 400, 500, 600, 700

## 📁 Arquivos de Fonte Necessários

Para que a fonte funcione corretamente, adicione os seguintes arquivos TTF neste diretório:

```
assets/fonts/
├── PlusJakartaSans-Regular.ttf    (Peso: 400)
├── PlusJakartaSans-Medium.ttf     (Peso: 500)
├── PlusJakartaSans-SemiBold.ttf   (Peso: 600)
└── PlusJakartaSans-Bold.ttf       (Peso: 700)
```

## 🔗 Como obter as fontes:

### Opção 1: Google Fonts (Recomendado)
1. Acesse: https://fonts.google.com/specimen/Plus+Jakarta+Sans
2. Clique em "Download family"
3. Extraia o ZIP e copie os arquivos TTF para este diretório

### Opção 2: GitHub
1. Acesse: https://github.com/tokotype/PlusJakartaSans
2. Baixe os arquivos da pasta `fonts/ttf/`

## 🚀 Integração Automática

A fonte será aplicada automaticamente em:

- ✅ **Todos os TextStyle** da AppTypography
- ✅ **Tema geral** do MaterialApp
- ✅ **Componentes customizados** (CustomButton, CustomTextField)
- ✅ **Text widgets** que não especificam fontFamily

## 💡 Uso no Código

```dart
// Fonte será Plus Jakarta Sans automaticamente
Text('Meu texto', style: context.typography.bodyLarge)

// Ou usando o tema diretamente
Text('Título', style: Theme.of(context).textTheme.headlineSmall)
```

## 📱 Fallback

Se os arquivos de fonte não estiverem presentes, o Flutter usará a fonte padrão do sistema como fallback.

## 🔧 Troubleshooting

Se a fonte não aparecer:
1. Certifique-se de que os arquivos TTF estão no diretório correto
2. Execute `flutter clean && flutter pub get`
3. Reinicie o app com hot restart (não hot reload)

---
**Licença:** Plus Jakarta Sans é distribuída sob SIL Open Font License 1.1