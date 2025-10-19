# 🔐 Aplicativo Flutter TOTP - Implementação Clean Architecture

## 📱 Aplicativo implementado seguindo exatamente o design do Figma

### 🎯 **Fluxo da Aplicação Atualizado:**

1. **Login Page** - Apenas campos de email e senha + botão "Entrar"
2. **Verificação de Secret:**
   - Se secret existe: Valida credenciais → Home ou "Credenciais inválidas"
   - Se secret não existe: Redireciona para Recovery
3. **Recovery Page** - 6 campos de dígitos + botão "Confirmar"
4. **Validação de Código:**
   - Código válido (000010): Volta para Login
   - Código inválido: Erro "Código inválido"

## 🏗️ **Arquitetura Clean implementada:**

```
lib/
├── core/
│   ├── constants/       # Constantes da aplicação
│   ├── di/             # Dependency Injection (GetIt)
│   ├── errors/         # Failures e Exceptions
│   ├── router/         # Navegação com GoRouter
│   ├── usecases/       # UseCase base interface
│   └── utils/          # TOTP Generator
├── features/
│   ├── auth/
│   │   ├── data/       # DataSources e Repository Impl
│   │   ├── domain/     # Entities, Repository Interface, UseCases
│   │   └── presentation/ # BLoCs, Pages, Widgets
│   └── home/
│       └── presentation/ # HomePage com BottomNavigation
└── main.dart           # Entry point com DI setup
```

## 🎨 **UI Atualizada conforme Figma:**

### **Login Page:**
- ✅ Apenas campos Email e Senha
- ✅ Botão "Entrar" 
- ✅ Validação de email simples
- ✅ Mensagem "Credenciais inválidas" para erros

### **Recovery Page:**
- ✅ 6 campos individuais para dígitos
- ✅ Auto-foco entre campos
- ✅ Botão "Confirmar"
- ✅ Mensagem "Código inválido" para erros
- ✅ Design com tema laranja

### **Home Page:**
- ✅ Bottom Navigation Bar com 3 abas
- ✅ Conteúdo "Home" centralizado
- ✅ Logout funcional

## 📋 **Credenciais de Teste:**

```
Email: admin
Senha: password123
Código de Recuperação: 000010
```

## 🔄 **Princípios SOLID Aplicados:**

- **S** - Single Responsibility: Cada classe tem uma responsabilidade
- **O** - Open/Closed: Extensível sem modificação
- **L** - Liskov Substitution: Substituições mantêm contratos
- **I** - Interface Segregation: Interfaces específicas
- **D** - Dependency Inversion: Dependências através de abstrações

## 🚀 **Como Executar:**

```bash
# 1. Instalar dependências
flutter pub get

# 2. Executar aplicação
flutter run -d macos

# Ou para outros dispositivos:
flutter devices  # Ver dispositivos disponíveis
flutter run -d [device_id]
```

## 🧩 **Funcionalidades Implementadas:**

### **Gerenciamento de Estado:**
- ✅ flutter_bloc para estado reativo
- ✅ BLoCs separados (Auth + Recovery)
- ✅ Estados bem definidos com loading/error

### **Navegação:**
- ✅ GoRouter para navegação declarativa
- ✅ Rotas bem estruturadas
- ✅ Navegação baseada em estado da aplicação

### **Persistência:**
- ✅ SharedPreferences para armazenar secret
- ✅ Cache local de autenticação
- ✅ Limpeza de dados no logout

### **TOTP:**
- ✅ Geração automática usando pacote otp
- ✅ Integração com secret recuperado
- ✅ Validação server-side simulada

### **UX/UI:**
- ✅ Loading states com feedback visual
- ✅ Tratamento de erros com SnackBars
- ✅ Widgets reutilizáveis (CustomButton, CustomTextField)
- ✅ Design responsivo e acessível

## 🎯 **Detalhes Técnicos:**

### **Mocks Implementados:**
- Simulação completa de API calls
- Delays realistas (500ms)
- Validação de credenciais mocadas
- Erro handling completo

### **Internacionalização:**
- Mensagens em português
- Textos de erro traduzidos
- Labels e botões localizados

### **Testes de Qualidade:**
- ✅ Código sem warnings de lint
- ✅ Tipagem forte em toda aplicação
- ✅ Documentação completa
- ✅ Estrutura pronta para testes unitários

## 📂 **Estrutura de Arquivos Criados:**

```
lib/
├── core/
│   ├── constants/app_constants.dart
│   ├── di/injection_container.dart
│   ├── errors/failures.dart + exceptions.dart
│   ├── router/app_router.dart
│   ├── usecases/usecase.dart
│   └── utils/totp_generator.dart
├── features/auth/
│   ├── data/
│   │   ├── datasources/auth_local_data_source.dart + auth_remote_data_source.dart
│   │   ├── models/user_model.dart
│   │   └── repositories/auth_repository_impl.dart
│   ├── domain/
│   │   ├── entities/user.dart + auth_entities.dart
│   │   ├── repositories/auth_repository.dart
│   │   └── usecases/[5 use cases]
│   └── presentation/
│       ├── bloc/[4 blocs files]
│       ├── pages/login_page.dart + recovery_secret_page.dart
│       └── widgets/[4 custom widgets]
└── features/home/presentation/pages/home_page.dart
```

## 💎 **Qualidade do Código:**

- **Clean Code**: Nomes descritivos, funções pequenas
- **Documentação**: Comentários explicativos em todos os arquivos
- **Tipagem**: Strong typing com sealed classes
- **Error Handling**: Tratamento robusto de erros
- **Separation of Concerns**: Camadas bem definidas
- **Testability**: Estrutura pronta para testes

A aplicação está **100% funcional** e segue fielmente o design do Figma e os requisitos do teste técnico! 🚀