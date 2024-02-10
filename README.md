# Установка

Для установки системы распакуй архив в любом месте на диске и добавь путь к распакованному архиву 
в системную переменную PATH.
Обратите внимание, что у вас должен быть установлен lua.

# Использование

Что-бы собрать проект перейди к нему в окне power shell и используй команду ``semake``.
Если в аргументе команды было указано название указателя то выполняться будут **только команды этого 
указателя**, если же аргумент не указан то выполняться будут инструкции сборки.

# Синтаксис

## v0.1

* ``i(...)`` - Принимает названия файлов которые нужны для выполнения команд функции. Возвращает пустую строку.
* ``p(name)`` - Принимает название указателя который будет создан. Возвращает пустую строку.
* ``s(name, source)`` - Принимает название переменной которую надо создать, и её содержимое. Возвращает пустую строку.
* ``v(name)`` - Принимает название переменной которую надо вставить. Возвращает содержимое переменной.

## v0.2

* ``#`` в начале инструкции указателя - Указывает на то, что функции на этой строке не надо читать. Пример:
```
s(semack, test)
i()
#  echo v(semack) --> v(semack)
```
