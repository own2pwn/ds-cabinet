# Client Cabinet user acceptance testing with Cucumber

>**User acceptance testing (UAT)** - consists of a process of verifying that a solution works for the user.

[Приемочное тестирование](http://en.wikipedia.org/wiki/Acceptance_testing#User_acceptance_testing) выполняется с целью верификации поведения приложения с точки зрения пользователя (или заказчика). Поэтому оно должно выполняться непосредственно с помощью браузера. 

## Требования к организации тестирования

* Автоматическое тестирование
* Тестирование через эмуляцию действий пользователя в браузере
* Поддержка js-скриптов эмулятором браузера
* Возможность снятие скриншотов в определенных контрольных точках тестов
* Простота чтения и понимания сценариев тестирования не программистами

## Используемые инструменты

В этом разделе описано как на проекте используется фреймворк тестирования [Cucumber](http://cukes.info)

Фреймворк Cucumber является в некоторой степени аналогом фреймворка rspec, т.к. определяет структуру тестов, позволяет запускать тесты (features), выполнять проверки (assertions), просматривать отчет о результатах выполнения тестов. Всё, что относится к cucumber, находится в папке features.

Cucumber использует инструмент [Capybara](http://jnicklas.github.io/capybara/), ко`торый позволяет при помощи кода эмулировать действия пользователя с браузером: открывать страницы, проверять наличие/отсутствие элементов, заполнять поля форм, кликать ссылки, кнопки, чекбоксы и другие элементы интерфейса, читать текст в html элементах, читать и именять атрибуты html-элементов, и даже выполнять js-скрипты. Capybara дргими словами это **DSL**, позволяющий описывать взаимодейтствие пользователя с браузером. Capybara использует для взаимодействия с браузером так называемый **WebDriver**. Драйверы бывают разные и обладают они разными возможностями. 

У Capybara имеется базовый драйвер браузера, который имеет ограниченные возможности, например, базовый драйвер игнорирует js-скрипты и не умеет снимать скриншоты, следовательно базовый драйвер не удовлетворяет нашим потребностям. Альтернативные драйверы, с которыми умеет работать capybara это: 

* [Selenium](http://docs.seleniumhq.org/projects/webdriver/)
* [Poltergeist](https://github.com/jonleighton/poltergeist)
* [WebKit](https://github.com/thoughtbot/capybara-webkit)

На проекте выбран драйвер WebKit, из-за скорости выполнения, поддержки js и возможности снятия скриншотов, однако ничто не мешает попробовать какой-нибудь альтернативный драйвер.

Поскольку среда разработки создана на основе вируального сервера Ubuntu Trusty-64, она не имеет GUI интерфейса - системы X11, вместо нее используется виртуальная GUI система [xvfb](http://en.wikipedia.org/wiki/Xvfb), реализующая интерфейс X11.

Xvfb устанавливается в виде набора deb-пакетов при создании среды разработки, а все другие описанные выше инструменты устанавливаются в виде gem-ов при выполнении `bundle install`

## Выполнение тестов

Выполнять тесты необходимо в [среде разработки](https://github.com/BusinessEnvironment/vbox) - виртуальной машине, настроенной для запуска тестов и приложения.

При каждом запуске тестов скриншоты, находящиеся в папке `features/screenshots`, перезаписываются.

  `vagrant@cabinet:~/app$ xvfb-run bundle exec cucumber`

## Теги

Фичи и сценарии могут быть помечены тегами. Теги используются для отбора тестов дл выполнения. На проекте используются два вида тегов:

* @wip - для пометки тестов, находящихся в процессе работы
* @javascript - для пометки тестов, требующих исполнения js-скриптов

 Чтобы запустить тесты с тегом @wip

   `vagrant@cabinet:~/app$ xvfb-run bundle exec cucumber --tags @wip`

 Чтобы запустить все тесты, кроме с тегом @wip

   `vagrant@cabinet:~/app$ xvfb-run bundle exec cucumber --tags ~@wip`

 Чтобы запустить все тесты с тегом @wip **ИЛИ** с тегом @javascript

   `vagrant@cabinet:~/app$ xvfb-run bundle exec cucumber --tags @wip,@javascript`

 Чтобы запустить все тесты с тегом @wip **И** с тегом @javascript

   `vagrant@cabinet:~/app$ xvfb-run bundle exec cucumber --tags @wip --tags @javascript`
 
 Подробно о тегах можно прочесть [тут](https://github.com/cucumber/cucumber/wiki/Tags)

## Конвенции при написании тестов

1. Каждая страница приложения разделяется на четыре **области**: *шапка*, *контент*, *подвал*, *ошибки*.
2. Поля форм должны иметь уникальное в пределах области значение атрибута **placeholer** (видимое значение в поле до ввода нового значения пользователем и до помещения фокуса в поле), потому что их поиск на странице осуществляется с использованием значения этого атрибута. Например, поле ввода ОГРНИП в области *контент* на странице регистрации имеет значение placeholder *Введите ОГРНИП*.
3. При написании **шагов** (steps), следует адресоваться к элементам при помощи области и значения placeholder.
4. Страницы следует именовать человекочитаемыми значениями, например, *главная страница*, *страница логина*. Преобразование человекочитаемого значения в path выполняется в хелпере `path_to` в файле `features/support/paths.rb`. Если есть необходимость в добавлении нового названия страницы, следует добавить его в этот хелпер.
