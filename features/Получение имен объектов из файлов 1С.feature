# language: ru

Функциональность: Получение имен объектов из файлов 1С

Как разработчик
Я хочу быстро получить имена объектов из файлов 1С
Чтобы я мог просто устанавливать эти объекты в демо-базу

Контекст: Отключение отладки в логах
    Допустим Я выключаю отладку лога с именем "oscript.lib.commands"
    И Я очищаю параметры команды "oscript" в контексте
    # И Я сохраняю значение "DEBUG" в переменную окружения "LOGOS_LEVEL"
    И Я показываю текущий каталог
    Тогда Я показываю каталог проекта
    И Я показываю рабочий каталог

Сценарий: Имя объекта для внешней обработки
    Когда Я добавляю параметры для команды "oscript"
    | src/pluck.os |
    | p |
    | fixtures/СделатьПаузу.epf |
    И Я выполняю команду "oscript"
    И Я показываю вывод команды
    Тогда я вижу в консоли строку подобно "СделатьПаузу"

Сценарий: Имя объекта для внешней обработки с пробелами в именах
    Когда Я добавляю параметры для команды "oscript"
    | src/pluck.os |
    | p |
    | "fixtures/СделатьПаузу ОФ.epf" |
    И Я выполняю команду "oscript"
    И Я показываю вывод команды
    Тогда я вижу в консоли строку подобно "СделатьПаузуОФ"

Сценарий: Имя объекта для внешней обработки РаботаСВидео
    Когда Я добавляю параметры для команды "oscript"
    | src/pluck.os |
    | p |
    | fixtures/РаботаСВидео.epf |
    И Я выполняю команду "oscript"
    Тогда я вижу в консоли строку подобно "РаботаСВидео"

Сценарий: Имя объекта для внешней обработки с макетами - СозданиеFixturesПоМакетуОбработкиФичи
    Когда Я добавляю параметры для команды "oscript"
    | src/pluck.os |
    | p |
    | fixtures/СозданиеFixturesПоМакетуОбработкиФичи.epf |
    И Я выполняю команду "oscript"
    И Я показываю вывод команды
    Тогда я вижу в консоли строку подобно "СозданиеFixturesПоМакетуОбработкиФичи"

Сценарий: Имя объекта для внешнего отчета
    Когда Я добавляю параметры для команды "oscript"
    | src/pluck.os |
    | p |
    | fixtures/КомпоновкаТест.erf |
    И Я выполняю команду "oscript"
    Тогда я вижу в консоли строку подобно "КомпоновкаТест"

Сценарий: Имя объекта для внешнего отчета, имя файла и имя метаданного не совпадают
    Когда Я добавляю параметры для команды "oscript"
    | src/pluck.os |
    | p |
    | fixtures/ОтчетПереносСтрок.erf |
    И Я выполняю команду "oscript"
    И Я показываю вывод команды
    Тогда я вижу в консоли строку подобно "ОтчетПереносСтрок_ДругоеНаименование"

Сценарий: Запуска без параметров
    Когда Я добавляю параметры для команды "oscript"
    | src/pluck.os |
    И Я выполняю команду "oscript"
    Тогда я вижу в консоли вывод "Получение имени метаданного из файла 1С"

Сценарий: Справка
    Когда Я добавляю параметры для команды "oscript"
    | src/pluck.os |
    | --help |
    И Я выполняю команду "oscript"
    Тогда я вижу в консоли вывод "p, parse"

Сценарий: Версия
    Когда Я добавляю параметры для команды "oscript"
    | src/pluck.os |
    | --version |
    И Я выполняю команду "oscript"
    Тогда я вижу в консоли строку подобно "\d\.\d\.\d"

Сценарий: Ошибочная команда
    Когда Я добавляю параметры для команды "oscript"
    | src/pluck.os |
    | wrong |
    И Я выполняю команду "oscript"
    Тогда я вижу в консоли вывод "Ошибка чтения параметров команды"
