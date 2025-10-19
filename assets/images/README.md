# Assets/Images Directory

Este diretório contém todas as imagens e recursos visuais do aplicativo TOTP.

## Estrutura de Organização

```
assets/
├── images/
│   ├── icons/          # Ícones personalizados
│   ├── illustrations/  # Ilustrações e gráficos
│   ├── logos/          # Logos e branding
│   └── backgrounds/    # Imagens de fundo
```

## Formatos Suportados

- **PNG**: Para imagens com transparência
- **JPG/JPEG**: Para fotos e imagens sem transparência
- **SVG**: Para ícones vetoriais (com flutter_svg)
- **WebP**: Para imagens otimizadas

## Convenções de Nomenclatura

- Use snake_case para nomes de arquivos
- Seja descritivo: `login_background.png`
- Inclua variações de densidade quando necessário:
  - `icon.png` (1x)
  - `icon@2x.png` (2x)
  - `icon@3x.png` (3x)

## Como Usar

```dart
// Para imagens
Image.asset('assets/images/logo.png')

// Para ícones
ImageIcon(AssetImage('assets/images/icons/home.png'))
```

## Otimização

- Comprima imagens antes de adicionar
- Use formatos apropriados para cada tipo de conteúdo
- Considere usar SVG para ícones escaláveis