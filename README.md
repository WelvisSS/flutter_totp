# Teste de Desenvolvedor Flutter: Aplicativo de Autenticação TOTP

## 🎥 Demo

<img src="demo/demo.gif" alt="Demo do App TOTP" width="200" />

## Visão Geral

Este teste avalia suas habilidades na construção de um aplicativo Flutter que se integra a uma API para autenticação TOTP
(Time-based One-Time Password). O aplicativo deve seguir o design fornecido no Figma e incluir três páginas principais:

1. **Página de Login**: O usuário insere o nome de usuário e senha.
2. **Página de Recuperação de Secret**: O usuário insere um código de recuperação (`000010`) para obter o secret TOTP.
3. **Página Home**: Após o login bem-sucedido, o usuário é redirecionado para a página Home.

### Fluxo do Teste

1. Na **Página de Login**, o usuário insere o nome de usuário (`admin`) e a senha (`password123`) e clica no botão de login.
2. Se o secret TOTP não estiver presente, o usuário é redirecionado automaticamente para a **Página de Recuperação de Secret**.
3. Na **Página de Recuperação de Secret**, o usuário insere o código de recuperação (`000010`) para obter o secret.
4. Após recuperar o secret, o usuário é redirecionado de volta para a **Página de Login**.
5. Com o secret agora disponível, o usuário tenta fazer login novamente.
6. Um login bem-sucedido redireciona o usuário para a **Página Home**.

## Estrutura do Projeto

O projeto base já contém a estrutura inicial e as dependências necessárias para começar. O foco principal será implementar
o gerenciamento de estado e a integração com a API.

### Páginas a Implementar

Figma: [Autenticação TOTP](https://www.figma.com/design/GcvlFrYngcezQUY78XGEmG/Flutter-Test?node-id=0-1&t=KC4t2EvVMdYyYzUW-1)

1. **Login Page**:
   - Inputs para nome de usuário e senha.
   - Botão de login.
   - Se o secret não estiver presente, redirecionar para a página de recuperação de secret após clicar no login.

2. **Recovery Secret Page**:
   - Input para o código de recuperação (somente `000010` é válido na API).
   - Botão para recuperar o secret.
   - Após a recuperação, redirecionar de volta para a página de login.

3. **Home Page**:
   - Exibir um texto "Home" centralizado na tela com uma bottom navigation bar.

### Organização do Projeto

A organização do código será um dos pontos de avaliação. Recomendamos uma estrutura clara e modular para facilitar
a manutenção e a expansão futura do aplicativo.

## Configuração do Backend

O backend é necessário para testar a funcionalidade do aplicativo. Para configurar e executar a API, siga as instruções no
arquivo `api/README.md` localizado no repositório base.

1. Acesse o diretório `api` no repositório base.
2. Siga as instruções no `README.md` para instalar as dependências e iniciar o servidor.
3. O servidor deve estar disponível em `http://127.0.0.1:5000`.

### Endpoints Disponíveis

1. **POST** `/auth/login`:
   - Verifica as credenciais do usuário e um código TOTP gerado.
   - Corpo da requisição:
     ```json
     {
       "username": "admin",
       "password": "password123",
       "totp_code": "<generated_totp_code>"
     }
     ```

2. **POST** `/auth/recovery-secret`:
   - Retorna o secret TOTP quando fornecido o código de recuperação correto (`000010`).
   - Corpo da requisição:
     ```json
     {
       "username": "admin",
       "password": "password123",
       "code": "000010"
     }
     ```

## Requisitos

1. **Gerenciamento de Estado**: Use `flutter_bloc` para gerenciar o estado do aplicativo.
2. **Geração de TOTP**: O código TOTP deve ser gerado automaticamente após o usuário fornecer o usuário e senha corretos.
3. **Navegação**: Implemente a navegação entre as três páginas de acordo com o fluxo descrito.
4. **Tratamento de Erros**: Exiba mensagens de erro apropriadas para o usuário em caso de falha na recuperação do secret
   ou na autenticação.

## Detalhes da Implementação

### 1. Geração de TOTP

O `otp` já está incluído no `pubspec.yaml` do projeto base. Use a função abaixo para gerar o código TOTP com base no secret
recuperado:

```dart
import 'package:otp/otp.dart';

String generateTOTP(String secret) {
  return OTP.generateTOTPCodeString(
    secret,
    DateTime.now().millisecondsSinceEpoch,
    interval: 30,
    algorithm: Algorithm.SHA1,
    isGoogle: true,
  );
}
```

### 2. Lógica de Login

- Se o secret não estiver presente, redirecione automaticamente para a **Recovery Secret Page**.
- Gere o código TOTP usando o secret recuperado e envie junto com a solicitação de login.
- Redirecione para a **Home Page** em caso de sucesso.

### 3. Lógica de Recuperação de Secret

- A API aceita apenas o código `000010` para recuperar o secret.
- Exiba uma mensagem de erro se o código estiver incorreto.
- Redirecione para a **Login Page** após a recuperação bem-sucedida do secret.

## Avaliação

1. **Implementação de UI**: A interface deve corresponder ao design fornecido no Figma.
2. **Gerenciamento de Estado**: Utilize o `flutter_bloc` corretamente para gerenciar as transições de estado.
3. **Navegação**: Navegue corretamente entre as páginas de login, recuperação de secret e home.
4. **Tratamento de Erros**: Exiba mensagens de erro apropriadas para o usuário em caso de falhas.
5. **Qualidade do Código**: O código deve ser limpo, modular e fácil de manter, com uma boa organização.

## Submissão

Após finalizar o teste, compacte o projeto em um arquivo `.zip` ou faça o push para um repositório pessoal e envie o link.

Boa sorte, e entre em contato se tiver alguma dúvida!
