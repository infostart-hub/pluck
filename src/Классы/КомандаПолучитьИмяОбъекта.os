#Использовать logos
#Использовать tempfiles
#Использовать yabr
#Использовать v8unpack
#Использовать fs

Перем Лог; // объект лога

Процедура ОписаниеКоманды(Команда) Экспорт
    Команда.Аргумент("PATH", "", "Путь файла 1С")
        .ТСтрока() // тип опции Строка
        .ВОкружении(ПараметрыПриложения.ИмяПриложения() + "_PATH");

КонецПроцедуры

Процедура ВыполнитьКоманду(Знач Команда) Экспорт
	ПутьФайла = Команда.ЗначениеАргумента("PATH");
	ПутьФайла = ФС.ОбъединитьПути(ТекущийКаталог(), ПутьФайла);

	ИмяМетаданного = ИмяМетаданногоИзФайлаЧерезКомпоненту(ПутьФайла);

	Сообщить(ИмяМетаданного);
КонецПроцедуры

Функция ИмяМетаданногоИзФайлаЧерезКомпоненту(ПутьФайла)
	ВременныйКаталог = ВременныеФайлы.СоздатьКаталог();

	ГуидФайлаОписания = Неопределено;
	Лог.Отладка("ПутьФайла %1", ПутьФайла);

	Попытка
		ЧтениеФайла = Новый ЧтениеФайла8(ПутьФайла);
	Исключение
		ИнформацияОбОшибке = ИнформацияОбОшибке();
		Сообщить(ИнформацияОбОшибке.ПодробноеОписаниеОшибки());
		ВызватьИсключение;
	КонецПопытки;
	КорневойЭлемент = ЧтениеФайла.Элементы.Найти("root");
	Если Не ЗначениеЗаполнено(КорневойЭлемент) Тогда
		Лог.Ошибка("Не удалось найти root в контейнере %1", ПутьФайла);
		Возврат "";
	КонецЕсли;
	ЧтениеФайла.Извлечь(КорневойЭлемент, ВременныйКаталог, Истина);

	ГуидФайлаОписания = ГуидФайлаОписания(ВременныйКаталог, "root");
	Лог.Отладка(ГуидФайлаОписания);

	ЭлементОписания = ЧтениеФайла.Элементы.Найти(ГуидФайлаОписания);
	Если Не ЗначениеЗаполнено(ЭлементОписания) Тогда
		Лог.Ошибка("Не удалось найти элемент %2 в контейнере %1", ПутьФайла, ЭлементОписания);
		Возврат "";
	КонецЕсли;

	ЧтениеФайла.Извлечь(ЭлементОписания, ВременныйКаталог, Истина);

	ИмяМетаданного = ИмяМетаданногоИзФайлаОписания(ВременныйКаталог, ГуидФайлаОписания);
	Возврат ИмяМетаданного;

КонецФункции

Функция ГуидФайлаОписания(ВременныйКаталог, ИмяКорневогоФайла)

	Файл = ФС.ОбъединитьПути(ВременныйКаталог, ИмяКорневогоФайла);

	Менеджер = Новый МенеджерОбработкиДанных();
	Менеджер.Лог().УстановитьУровень(УровниЛога.Предупреждение);
	Чтение = Новый ЧтениеСкобкофайла(Менеджер);
	Чтение.УстановитьПараметрыОбработкиДанных(Новый Структура);
	Чтение.УстановитьДанные(Файл);
	Чтение.ОбработатьДанные();

	Структура = Чтение.РезультатОбработки();

	Лог.Отладка("Структура %1", Структура);
	Лог.Отладка("Структура.Значения %1", Структура.Значения);
	Лог.Отладка("Структура.Значения.Количество() %1", Структура.Значения.Количество());
	Лог.Отладка("Структура.Значения[0].Значения %1", Структура.Значения[0].Значения);
	Лог.Отладка("Структура.Значения[0].Значения.Количество() %1", Структура.Значения[0].Значения.Количество());

	Результат = Структура.Значения[0].Значения[1];
	Возврат Результат;
КонецФункции

Функция ИмяМетаданногоИзФайлаОписания(ВременныйКаталог, ГуидФайлаОписания)
	Файл = ФС.ОбъединитьПути(ВременныйКаталог, ГуидФайлаОписания);

	Менеджер = Новый МенеджерОбработкиДанных();
	Менеджер.Лог().УстановитьУровень(УровниЛога.Предупреждение);
	Чтение = Новый ЧтениеСкобкофайла(Менеджер);
	НастройкаЧтения = Новый Структура("НачальнаяСтрока,КонечнаяСтрока", 8, 8);
	Чтение.УстановитьПараметрыОбработкиДанных(НастройкаЧтения);
	Чтение.УстановитьДанные(Файл);
	Чтение.ОбработатьДанные();

	Структура = Чтение.РезультатОбработки();

	Результат = Структура.Значения[0].Значения[3].Значения[1].Значения[1].Значения[3].Значения[1].Значения[2];

	Результат = СтрЗаменить(Результат, """", "");
	Возврат Результат;
КонецФункции

Функция ПолучитьЛог() Экспорт
	Если Лог = Неопределено Тогда
		Лог = ПараметрыПриложения.Лог();
	КонецЕсли;
	Возврат Лог;
КонецФункции

Лог = ПолучитьЛог();
