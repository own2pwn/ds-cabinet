# language: ru
Функционал: Элементы интерфейса главной страницы

  Сценарий: Вход на главную страницу, проверка наличия элементов интерфейса
    Допустим неавторизованный пользователь открывает "главную страницу"
    Если скриншот "главная страница"
    То в шапке имеется ссылка "Как это работает"
      И в шапке имеется ссылка "Тариф"
      И в шапке имеется ссылка "Контакты"
      И в шапке имеется ссылка "Регистрация"
      И в шапке имеется ссылка "Войти"

  Сценарий: Клик на кнопке "Вход" в форме входа и регистрации
    Допустим неавторизованный пользователь открывает "главную страницу"
    Если пользователь кликает на вкладке "Вход" формы регистрации и входа
      И скриншот "главная страница, нажата кнопка Вход"
    То в шапке имеется ссылка "Как это работает"
      И в шапке имеется ссылка "Тариф"
      И в шапке имеется ссылка "Контакты"
      И в шапке имеется ссылка "Регистрация"
      И в шапке имеется ссылка "Войти"
