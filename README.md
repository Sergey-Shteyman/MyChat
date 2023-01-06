# MyChat

Мобильное приложение мессенджер. Написано на архитектуре MVP + Router.

## Быстрый старт

 + git clone [https://github.com/Sergey-Shteyman/MyChat]
 + pod install

## Критерии создания проекта:

+ Проект на Swift 5, верстка uikit, только iphone и портретная ориентация экрана.
+ Шрифт Roboto 
+ Использовал API [https://plannerok.ru/docs#/]
+ Интерфейс подерживается, начиная с IPhone 14, заканчивая IPhone SE 2-nd gen
+ IOS 15 +

## В проекте были использованы библиотеки: 

+ CountryPickerSwift
+ Moya
+ RealmSwift
+ KeychainSwift
+ MessageKit

## Экраны

+ Авторизация.
+ Номер телефона.
+ Код подтверждения СМС.
+ Регистрация.
+ Чаты. (Только верстка самого простого чата, без функционала) 
  + Чат. (Только верстка самого простого чата, без функционала)
+ Профиль.
  + Редактирование профиля.


### Запросы

Все запросы кроме [/api/v1/users/register/], [/api/v1/users/send-auth-code/], [/api/v1/users/check-auth-code/], 
должны содержать значение заголовка авторизации с помощью токена доступа (value: "Bearer access token", forHTTPHeaderField: "Authorization"). 
Access token (время жизни 10 минут) полученный при регистрации или авторизации профиля.
По истечение 10 минут access token будет недействителен, ответ запроса будет 401, Вам следует сделать refresh token, запросом POST - [/api/v1/users/refresh-token/] и повторить предыдущий запрос. 

### 	Требования к экрану «Авторизация»

+ Ввод номера телефона с маской, флагом и кодом страны. Страну можно выбрать, вручную кликнув по флагу или ввести код страны. Должен быть placeholder. Дефолтное значение: currentRegion. 
+	Отправка номера телефона (phone: String) запросом POST - [/api/v1/users/send-auth-code/], пример номера телефона: +79219999999. 
+	При удачном запросе, пользователь должен ввести код подтверждения, смс не придет, для теста используем код: 133337. Ввод кода подтверждения должен состоять из 6 символов, только цифры.
+	Отправка данных (phone: String, code: String) запросом POST - [/api/v1/users/check-auth-code/].
+	При удачном запросе Вы получите refresh token, access token, user id, is user exists.
+	Если is user exists == true, авторизуем пользователя, либо отправляем на регистрацию.
+	Cохранить refresh token, access token. 

### 	Требование к экрану «Регистрация»

+	Показывать номер телефона, без возможности редактирования.
+	Ввод имени пользователя. 
+	Ввод username пользователя: 
  +	Заглавные латинские буквы: от A до Z (26 символов)
  +	Строчные латинские буквы: от a до z (26 символов)
  +	Цифры от 0 до 9 (10 символов)
  +	Символы: -_ (2 символа)
+	Отправка данных (phone: String, name: String, username: String) запросом POST - /api/v1/users/register/.
+	При удачном запросе Вы получите refresh token, access token, user id.
+	Авторизуем пользователя, либо выдаем toast с ошибкой.
+	Cохранить refresh token, access token.


### 	Требование к экрану «Чаты»

+	Вёрстка по своему усмотрению, должна содержать список чатов.

### 	Требование к экрану «Чата с сообщениями»

+	Вёрстка по своему усмотрению, должна содержать список сообщений и TextField прикреплена к нижней части экрана 
  и кнопки отправить (Эта панель должна быть всегда видна). При нажатии на TextField открывать клавиатуру, панель 
  с TextField и кнопкой отправки прикреплена к вверху клавиатуры. Клавиатура должна быть interactively.

###  Требование к экрану «Профиль»

+	Должен содержать аватарку пользователя, номер телефона, никнейм, город проживания, дату рождения, знак зодиака по дате рождения, о себе.
+	Все данные пользователя можно получить запросом GET - /api/v1/users/me/.
+	Данные пользователя храним на устройстве, чтобы не делать повторных запросов.

### Требования к экрану «Редактировать профиль»

+	Изменение всех данных, кроме phone и username. 
+	Изменение аватарки или добавление новой.
+	Сохраняем новые данные на устройстве и отправляем на сервер.
+	Отправка данных запросом PUT - /api/v1/users/me/.
+	Данные аватарки: название файла и сам файл base 64.


# Демонстрация работы приложения

<h3><p align="center"> Страничка приветствия </p></h3>

<p align="center"> <img src=https://github.com/Sergey-Shteyman/MyChat/blob/main/Screenshots/WelcomePage.png width="300" height="650"> </p>

<h3><p align="center"> Страничка аутентификации </p></h3>

<p align="center"> <img src=https://github.com/Sergey-Shteyman/MyChat/blob/main/Screenshots/AuthPage.png width="300" height="650"> </p>

<h3><p align="center"> Страничка верификации </p></h3>

<p align="center"> <img src=https://github.com/Sergey-Shteyman/MyChat/blob/main/Screenshots/VerifyPage.png width="300" height="650"> </p>

<h3><p align="center"> Страничка регистрации </p></h3>

<p align="center"> <img src=https://github.com/Sergey-Shteyman/MyChat/blob/main/Screenshots/RegistrationPage.png width="300" height="650"> </p>

<h3><p align="center"> Страничка списка чатов </p></h3>

<p align="center"> <img src=https://github.com/Sergey-Shteyman/MyChat/blob/main/Screenshots/ChatListPage.png width="300" height="650"> </p>

<h3><p align="center"> Страничка чата </p></h3>

<p align="center"> <img src=https://github.com/Sergey-Shteyman/MyChat/blob/main/Screenshots/ChatPage.png width="300" height="650"> </p>

<h3><p align="center"> Страничка пустого профиля </p></h3>

<p align="center"> <img src=https://github.com/Sergey-Shteyman/MyChat/blob/main/Screenshots/ProfilePage.png width="300" height="650"> </p>

<h3><p align="center"> Страничка редактирования профиля </p></h3>

<p align="center"> <img src=https://github.com/Sergey-Shteyman/MyChat/blob/main/Screenshots/EditProfilePage.png width="300" height="650"> </p>

<h3><p align="center"> Страничка заполненного профиля </p></h3>

<p align="center"> <img src=https://github.com/Sergey-Shteyman/MyChat/blob/main/Screenshots/FullProfilePage.png width="300" height="650"> </p>

