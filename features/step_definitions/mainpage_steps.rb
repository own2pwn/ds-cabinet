# Проверяет наличие формы регистрации и входа
# @param[String] existence - имеется|отсутствует
Если(/^(имеется|отсутствует?) форма регистрации и входа$/) do |existence|
  tabs_selector = '.js-forms_container'
  area = "контент"

  x = find(area_to_selector area)
  x.should be
  
  should_exist = case existence
    when 'имеется'     then true
    when 'отсутствует' then false
    else raise "Unknown option: #{existence}, should be either имеется or отсутствует"
  end

  should_exist ? ( x.should     have_selector(tabs_selector) ) :
                 ( x.should_not have_selector(tabs_selector) )
end

Если(/^пользователь кликает на вкладке "(Вход|Регистрация?)" формы регистрации и входа$/) do |name|
  tabs = page.find('.js-forms_container')
  tab = tabs.find('div', text: name)
  tab.click
end

Если(/^пользователь кликает на переключателе "(Я являюсь ИП|Я не являюсь ИП?)"$/) do |switcher_name|
  x = find(area_to_selector "контенте").find '.js-forms_container'
  within x do
    if switcher_name == "Я являюсь ИП"
      tab = find('#switch_btn1')
    else
      tab = find('#switch_btn2')
    end
    tab.click
  end
end

Если(/^форма регистрации и входа имеет вид "Регистрация, я являюсь ИП"$/) do
  step("в форме регистрации и входа имеется поле ввода \"Введите телефон\"")
  step("в форме регистрации и входа имеется поле ввода \"Введите ОГРН\"")
  step("в форме регистрации и входа имеется кпопка \"Зарегистрироваться\"")
  step("в форме регистрации и входа имеется ссылка \"Условиями использования\"")
  step("в форме регистрации и входа имеется ссылка \"Политикой конфиденциальности\"")
  step("в форме регистрации и входа имеется переключатель \"Я являюсь ИП\"")
  step("в форме регистрации и входа отсутствует кпопка \"Войти\"")
  step("в форме регистрации и входа отсутствует кпопка \"Зарегистрироваться\"")
  step("в форме регистрации и входа отсутствует поле ввода \"Пароль\"")
  step("в форме регистрации и входа отсутствует переключатель \"Я не являюсь ИП\"")
end

Если(/^форма регистрации и входа имеет вид "Регистрация, я НЕ являюсь ИП"$/) do
  step("в форме регистрации и входа отсутствует поле ввода \"Введите телефон\"")
  step("в форме регистрации и входа отсутствует ссылка \"Условиями использования\"")
  step("в форме регистрации и входа отсутствует ссылка \"Политикой конфиденциальности\"")
  step("в форме регистрации и входа отсутствует поле ввода \"Введите ОГРН\"")
  step("в форме регистрации и входа отсутствует кпопка \"Зарегистрироваться\"")
  step("в форме регистрации и входа отсутствует кпопка \"Войти\"")
  step("в форме регистрации и входа отсутствует кпопка \"Зарегистрироваться\"")
  step("в форме регистрации и входа отсутствует поле ввода \"Пароль\"")
  step("в форме регистрации и входа отсутствует переключатель \"Я являюсь ИП\"")
  step("в форме регистрации и входа имеется переключатель \"Я не являюсь ИП\"")
  step("в форме регистрации и входа имеется ссылка \"Сервисом онлайн регистрации ИП\"")
  step("в форме регистрации и входа имеется переключатель \"Я не являюсь ИП\"")
end

Если(/^форма регистрации и входа имеет вид "Вход"$/) do
  step("в форме регистрации и входа имеется кпопка \"Войти\"")
  step("в форме регистрации и входа имеется поле ввода \"Введите телефон\"")
  step("в форме регистрации и входа имеется поле ввода \"Пароль\"")
  step("в форме регистрации и входа имеется ссылка \"Напомнить пароль\"")
  step("в форме регистрации и входа отсутствует ссылка \"Условиями использования\"")
  step("в форме регистрации и входа отсутствует ссылка \"Политикой конфиденциальности\"")
  step("в форме регистрации и входа отсутствует поле ввода \"Введите ОГРН\"")
  step("в форме регистрации и входа отсутствует кпопка \"Зарегистрироваться\"")
  step("в форме регистрации и входа отсутствует переключатель \"Я являюсь ИП\"")
  step("в форме регистрации и входа отсутствует переключатель \"Я не являюсь ИП\"")
end
