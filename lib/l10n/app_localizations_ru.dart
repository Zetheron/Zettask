// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => 'Лента';

  @override
  String get navBoard => 'Доска';

  @override
  String get navUnplanned => 'Без даты';

  @override
  String get navMore => 'Ещё';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get close => 'Закрыть';

  @override
  String get delete => 'Удалить';

  @override
  String get edit => 'Изменить';

  @override
  String get undo => 'Отменить';

  @override
  String get back => 'Назад';

  @override
  String get retry => 'Повторить';

  @override
  String get clear => 'Очистить';

  @override
  String get all => 'Все';

  @override
  String get or => 'или';

  @override
  String get continueAction => 'Продолжить';

  @override
  String get understand => 'Понятно';

  @override
  String get useAction => 'Использовать';

  @override
  String get today => 'Сегодня';

  @override
  String get tomorrow => 'Завтра';

  @override
  String get yesterday => 'Вчера';

  @override
  String get toDo => 'К выполнению';

  @override
  String get overdue => 'Просрочено';

  @override
  String get unplanned => 'Без даты';

  @override
  String get allDay => 'Весь день';

  @override
  String get scheduled => 'По времени';

  @override
  String get addTaskToday => 'Добавить задачу на сегодня';

  @override
  String get addTask => 'Добавить задачу';

  @override
  String get noTasksForDate => 'На эту дату задач нет.';

  @override
  String get savedToUnplanned => 'Сохранено в Без даты';

  @override
  String get savedToUnplannedNoDate => 'Сохранено в Без даты (без даты)';

  @override
  String scheduledForDate(String date) {
    return 'Запланировано на $date';
  }

  @override
  String taskScheduledForDate(String date) {
    return 'Задача запланирована на $date';
  }

  @override
  String get taskDeleted => 'Задача удалена';

  @override
  String get searchTasksTooltip => 'Поиск задач';

  @override
  String get timelineOptionsTooltip => 'Настройки ленты';

  @override
  String get addTaskTooltip => 'Добавить задачу';

  @override
  String get completedLabel => 'Готово';

  @override
  String get uncompleteLabel => 'Вернуть в работу';

  @override
  String subtasksCount(int done, int total) {
    return '$done/$total подзадач';
  }

  @override
  String get repeatingTaskLabel => 'Повторяющаяся задача';

  @override
  String get quickAddHint => 'Добавить новую задачу...';

  @override
  String get expandTooltip => 'Развернуть';

  @override
  String get saveTaskTooltip => 'Сохранить задачу';

  @override
  String get newTask => 'Новая задача';

  @override
  String get editTask => 'Редактировать задачу';

  @override
  String get taskTitleLabel => 'Название задачи';

  @override
  String get taskTitleHint => 'Напр.: Проверить заметки спринта';

  @override
  String get taskTitleRequired => 'Введите название задачи';

  @override
  String get descriptionLabel => 'Описание';

  @override
  String get descriptionHint => 'Добавьте заметки или детали...';

  @override
  String get pickDate => 'Выбрать дату';

  @override
  String get pickOnCalendar => 'Выбрать в календаре...';

  @override
  String get noDateUnplanned => 'Без даты (Не запланировано)';

  @override
  String get noDate => 'Без даты';

  @override
  String get taskTime => 'Время задачи';

  @override
  String get changeTime => 'Изменить время';

  @override
  String get clearTimeAllDay => 'Убрать время (Весь день)';

  @override
  String get timeLabel => 'Время';

  @override
  String get reminderLabel => 'Напоминание';

  @override
  String get noReminder => 'Без напоминания';

  @override
  String get atTime => 'Вовремя';

  @override
  String get minutesBefore10 => 'За 10 мин';

  @override
  String get minutesBefore30 => 'За 30 мин';

  @override
  String get hourBefore1 => 'За 1 час';

  @override
  String get reminderShort10m => '10 мин';

  @override
  String get reminderShort30m => '30 мин';

  @override
  String get reminderShort1h => '1 ч';

  @override
  String get projectLabel => 'Проект';

  @override
  String get noProject => 'Без проекта';

  @override
  String get tagLabel => 'Тег';

  @override
  String get noTag => 'Без тега';

  @override
  String get priorityLabel => 'Приоритет';

  @override
  String get priorityLow => 'Низкий';

  @override
  String get priorityMedium => 'Средний';

  @override
  String get priorityHigh => 'Высокий';

  @override
  String get saveTask => 'Сохранить задачу';

  @override
  String get saveChanges => 'Сохранить изменения';

  @override
  String get checklistLabel => 'Чек-лист';

  @override
  String get addChecklistHint => 'Добавить пункт...';

  @override
  String get repeatLabel => 'Повтор';

  @override
  String get noRepeat => 'Не повторяется';

  @override
  String get repeatDaily => 'Каждый день';

  @override
  String get repeatWeekly => 'Каждую неделю';

  @override
  String get repeatMonthly => 'Каждый месяц';

  @override
  String get colorLabel => 'Цвет';

  @override
  String get timelineOptionsTitle => 'Настройки ленты';

  @override
  String get viewModeLabel => 'Режим просмотра';

  @override
  String get modeTimeline => 'Режим ленты';

  @override
  String get modeDaily => 'Дневной режим';

  @override
  String get firstDayOfWeek => 'Начало недели';

  @override
  String get monday => 'Понедельник';

  @override
  String get sunday => 'Воскресенье';

  @override
  String get firstDayMondayOrder => 'Пн · Вт · Ср · Чт · Пт · Сб · Вс';

  @override
  String get firstDaySundayOrder => 'Вс · Пн · Вт · Ср · Чт · Пт · Сб';

  @override
  String get showCompletedTasks => 'Показывать выполненные';

  @override
  String get showCompletedTasksSubtitle =>
      'Скрывайте завершённые задачи, чтобы не отвлекаться.';

  @override
  String get showCompletedWorkspaceSubtitle =>
      'Показывать или скрывать выполненные задачи.';

  @override
  String get overdueTasksTitle => 'Просроченные задачи';

  @override
  String get noOverdueTasks => 'Нет просроченных задач';

  @override
  String get moveToToday => 'Перенести на сегодня';

  @override
  String get moveAllToToday => 'Перенести все на сегодня';

  @override
  String get searchTasksHint => 'Поиск задач...';

  @override
  String get searchTasksEmpty =>
      'Введите текст для поиска задач, описаний или списков.';

  @override
  String searchNoResults(String query) {
    return 'Нет задач по запросу «$query».';
  }

  @override
  String get calendarEventReadOnly => 'Событие календаря · только чтение';

  @override
  String get prevWeekTooltip => 'Предыдущая неделя';

  @override
  String get nextWeekTooltip => 'Следующая неделя';

  @override
  String get boardTitle => 'Доска';

  @override
  String get allProjects => 'Все проекты';

  @override
  String get searchProjectHint => 'Поиск проекта...';

  @override
  String get searchProjectTooltip => 'Поиск проектов';

  @override
  String get closeSearchTooltip => 'Закрыть поиск';

  @override
  String get createProject => 'Создать проект';

  @override
  String get editProject => 'Изменить проект';

  @override
  String get deleteProject => 'Удалить проект';

  @override
  String get projectOptionsTooltip => 'Опции проекта';

  @override
  String projectDeleted(String name) {
    return 'Проект «$name» удалён';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return '$done/$total готово';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return 'Выполнено $done/$total';
  }

  @override
  String get projectNotFound => 'Проект не найден';

  @override
  String get noProjectsYet => 'Проектов пока нет';

  @override
  String projectSearchEmpty(String query) {
    return 'Нет проектов по запросу «$query».';
  }

  @override
  String get noProjectsSubtitle =>
      'Нажмите на папку внизу, чтобы создать первый проект.';

  @override
  String get newProject => 'Новый проект';

  @override
  String get projectNameLabel => 'Название проекта';

  @override
  String get projectNameHint => 'Напр.: Запуск Zettask';

  @override
  String get projectNameRequired => 'Введите название проекта';

  @override
  String get projectColorLabel => 'Цвет проекта';

  @override
  String get unplannedTitle => 'Без даты';

  @override
  String activeCountLabel(int count) {
    return '$count активных';
  }

  @override
  String get noUnplannedTitle => 'Нет задач без даты';

  @override
  String get noUnplannedSubtitle =>
      'Нажмите +, чтобы добавить задачу без даты.';

  @override
  String get addUnplannedTooltip => 'Добавить задачу без даты';

  @override
  String get workspaceTitle => 'Рабочее пространство';

  @override
  String get organizeSection => 'Организация';

  @override
  String get automationSection => 'Автоматизация';

  @override
  String get insightsSection => 'Статистика и тема';

  @override
  String get settingsInfoSection => 'Настройки и инфо';

  @override
  String get tagsTitle => 'Теги';

  @override
  String get tagsSubtitleEmpty => 'Цветные метки для задач и заметок';

  @override
  String tagsCountSubtitle(int count) {
    return 'Сохранено тегов: $count';
  }

  @override
  String get newTag => 'Новый тег';

  @override
  String get editTag => 'Изменить тег';

  @override
  String get tagNameLabel => 'Название тега';

  @override
  String get tagNameRequired => 'Введите название тега';

  @override
  String get tagDeleted => 'Тег удалён';

  @override
  String get noTagsYet => 'Тегов пока нет';

  @override
  String tagTasksCount(int count) {
    return '$count задач';
  }

  @override
  String get templatesTitle => 'Шаблоны';

  @override
  String get templatesSubtitleEmpty => 'Сохраняйте шаблоны задач и чек-листов';

  @override
  String templatesCountSubtitle(int count) {
    return 'Готово шаблонов: $count';
  }

  @override
  String get newTemplate => 'Новый шаблон';

  @override
  String get editTemplate => 'Изменить шаблон';

  @override
  String get templateNameLabel => 'Название шаблона';

  @override
  String get templateNameRequired => 'Введите название шаблона';

  @override
  String get templateDeleted => 'Шаблон удалён';

  @override
  String get noTemplatesYet => 'Шаблонов пока нет';

  @override
  String get taskFromTemplateSaved => 'Задача из шаблона сохранена';

  @override
  String get notesTitle => 'Заметки';

  @override
  String get notesSubtitleEmpty => 'Быстрые заметки без даты';

  @override
  String notesCountSubtitle(int count) {
    return 'Сохранено заметок: $count';
  }

  @override
  String get newNote => 'Новая заметка';

  @override
  String get editNote => 'Изменить заметку';

  @override
  String get noteTitleLabel => 'Заголовок';

  @override
  String get noteTitleHint => 'Напр.: Итоги встречи';

  @override
  String get noteTitleRequired => 'Введите заголовок';

  @override
  String get noteContentLabel => 'Текст заметки';

  @override
  String get noteContentHint => 'Напишите заметку здесь...';

  @override
  String get noteDeleted => 'Заметка удалена';

  @override
  String get searchNotesHint => 'Поиск заметок...';

  @override
  String get noteNotFound => 'Заметка не найдена';

  @override
  String get noNotesYet => 'Заметок пока нет';

  @override
  String noteSearchEmpty(String query) {
    return 'Нет заметок по запросу «$query».';
  }

  @override
  String get noNotesSubtitle => 'Нажмите +, чтобы создать быструю заметку.';

  @override
  String get saveNote => 'Сохранить заметку';

  @override
  String get repeatingTasksTitle => 'Повторяющиеся задачи';

  @override
  String get repeatingTasksSubtitleEmpty =>
      'Ежедневные, еженедельные и ежемесячные рутины';

  @override
  String repeatingActiveCount(int count) {
    return 'Активных рутин: $count';
  }

  @override
  String get noRepeatingTasks => 'Повторяющихся задач нет';

  @override
  String get repeatingActionTitle => 'Это повторяющаяся задача';

  @override
  String get repeatingThisOnly => 'Только эту задачу';

  @override
  String get repeatingThisAndFollowing => 'Эту и все следующие';

  @override
  String get last7DaysUpper => 'ПОСЛЕДНИЕ 7 ДНЕЙ';

  @override
  String weeklySummary(int tasks, int checklists) {
    return '$tasks задач и $checklists пунктов чек-листа';
  }

  @override
  String get statsTitle => 'Статистика';

  @override
  String get range7Days => '7 дней';

  @override
  String get range30Days => '30 дней';

  @override
  String get completedToday => 'За сегодня';

  @override
  String get last7DaysLabel => 'За 7 дней';

  @override
  String get last30DaysLabel => 'За 30 дней';

  @override
  String get allTimeLabel => 'За всё время';

  @override
  String get completionRateLabel => 'Процент выполнения';

  @override
  String get activity7Days => 'Активность за 7 дней';

  @override
  String get activity30Days => 'Активность за 30 дней';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks задач · $checklists пунктов';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return 'Всего за $days дн.: $tasks задач и $checklists пунктов';
  }

  @override
  String get completedByPriority => 'Выполнено по приоритету';

  @override
  String get progressByProject => 'Прогресс по проектам';

  @override
  String get breakdownByTag => 'Детализация по тегам';

  @override
  String get habits30Days => 'Привычки · 30 дней';

  @override
  String get noProjectsCreated => 'Проекты ещё не созданы.';

  @override
  String get noTagsCreated => 'Теги ещё не созданы.';

  @override
  String get noActiveHabits => 'Нет активных рутин.';

  @override
  String completedCountLabel(int count) {
    return '$count готово';
  }

  @override
  String tagBreakdownTrailing(int done, int total) {
    return '$done/$total готово';
  }

  @override
  String habitCompletedRatio(String summary, int done, int scheduled) {
    return '$summary · $done/$scheduled готово';
  }

  @override
  String statsSubtitle(int completed, int percent) {
    return 'Выполнено $completed · $percent%';
  }

  @override
  String get themeTitle => 'Тема';

  @override
  String get themeAndColorsTitle => 'Тема и цвета';

  @override
  String get livePreviewSection => 'Предпросмотр';

  @override
  String get appearanceModeSection => 'Оформление';

  @override
  String get colorPaletteSection => 'Цветовая палитра';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get themeSystem => 'Система';

  @override
  String get themeSystemLight => 'Система (Светлая)';

  @override
  String get themeSystemDark => 'Система (Тёмная)';

  @override
  String get presetDefault => 'По умолчанию';

  @override
  String get presetDefaultDesc => 'Индиго и сланец';

  @override
  String get presetOcean => 'Океан';

  @override
  String get presetOceanDesc => 'Спокойный синий';

  @override
  String get presetForest => 'Лес';

  @override
  String get presetForestDesc => 'Шалфей и изумруд';

  @override
  String get presetTerracotta => 'Терракота';

  @override
  String get presetTerracottaDesc => 'Тёплый оранжевый';

  @override
  String get presetPlum => 'Слива';

  @override
  String get presetPlumDesc => 'Мягкий фиолетовый';

  @override
  String get presetMonochrome => 'Монохром';

  @override
  String get presetMonochromeDesc => 'Графит и чёрный';

  @override
  String get previewActiveTask => 'Проверить дизайн интерфейса';

  @override
  String get previewCompletedTask => 'Синхронизировать расписание';

  @override
  String get languageTitle => 'Язык';

  @override
  String get deviceLanguageOption => 'Язык устройства (если поддерживается)';

  @override
  String get appLockTitle => 'Блокировка приложения';

  @override
  String get appLockSubtitle => 'Отпечаток, лицо или PIN устройства';

  @override
  String get appLockLockedTitle => 'Zettask заблокирован';

  @override
  String get appLockLockedSubtitle =>
      'Используйте отпечаток, лицо или PIN-код устройства.';

  @override
  String get unlockButton => 'Разблокировать';

  @override
  String get verifyingButton => 'Проверка...';

  @override
  String get appLockUnsupportedError =>
      'На устройстве не настроена биометрия или PIN-код.';

  @override
  String get appLockCancelledError => 'Проверка отменена или не удалась.';

  @override
  String get appLockUnlockFailedError =>
      'Ошибка проверки. Нажмите «Разблокировать».';

  @override
  String get calendarSyncTitle => 'Синхронизация календаря';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return 'Вкл · календарей: $count';
  }

  @override
  String get calendarSyncInactiveSubtitle => 'Выкл · события только для чтения';

  @override
  String get grantCalendarPermission => 'Разрешить доступ к календарю';

  @override
  String get exportCsvTitle => 'Экспорт CSV';

  @override
  String get exportCsvSubtitle => 'Поделиться задачами или заметками в CSV';

  @override
  String get exportDataCsvTitle => 'Экспорт данных CSV';

  @override
  String get exportTasksTitle => 'Экспорт задач';

  @override
  String get exportTasksSubtitle =>
      'Все запланированные, без даты и проектные задачи';

  @override
  String get exportNotesTitle => 'Экспорт заметок';

  @override
  String get exportNotesSubtitle => 'Все быстрые заметки';

  @override
  String get exportBothTitle => 'Экспортировать всё';

  @override
  String get exportBothSubtitle => 'Файлы CSV задач и заметок вместе';

  @override
  String get aboutPrivacyTitle => 'О приложении и конфиденциальность';

  @override
  String aboutPrivacySubtitle(String version) {
    return 'Версия $version · Офлайн и опциональное облако';
  }

  @override
  String get aboutTitle => 'О Zettask';

  @override
  String versionLabel(String version) {
    return 'Версия $version';
  }

  @override
  String get privacySyncTitle => 'Конфиденциальность и синхронизация';

  @override
  String get privacySyncDescription =>
      'По умолчанию данные хранятся локально. Облачная синхронизация Firebase включается по желанию, а аккаунт и облачные данные можно удалить навсегда в любой момент.';

  @override
  String get privacyPolicyLabel => 'Политика конфиденциальности';

  @override
  String get privacyLinkCopied => 'Ссылка скопирована';

  @override
  String get accountAndSyncTitle => 'Аккаунт и синхронизация';

  @override
  String get signInToZettask => 'Войти в аккаунт Zettask';

  @override
  String get accountBannerSubtitle =>
      'Необязательно · облачное резервное копирование';

  @override
  String get authWelcomeTitle => 'Сохраните прогресс и задачи';

  @override
  String get authWelcomeSubtitle =>
      'Автоматически сохраняйте расписание, проекты и заметки в облаке. Можно продолжать пользоваться Zettask локально без аккаунта.';

  @override
  String get createNewAccount => 'Создать аккаунт';

  @override
  String get signIn => 'Войти';

  @override
  String get continueWithGoogle => 'Продолжить с Google';

  @override
  String get authTermsNotice =>
      'Продолжая, вы соглашаетесь с Условиями и Политикой конфиденциальности Zettask.';

  @override
  String get signInToAccountTitle => 'Вход в Zettask';

  @override
  String get signInToAccountSubtitle =>
      'Локальные данные объединятся с облачной копией.';

  @override
  String get emailLabel => 'Эл. почта';

  @override
  String get emailHint => 'name@email.com';

  @override
  String get emailRequired => 'Введите эл. почту.';

  @override
  String get emailInvalid => 'Неверный формат эл. почты.';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get passwordHint => 'Введите пароль';

  @override
  String get passwordNewHint => 'Минимум 6 символов';

  @override
  String get passwordRequired => 'Введите пароль.';

  @override
  String get passwordTooShort => 'Пароль должен быть не короче 6 символов.';

  @override
  String get forgotPassword => 'Забыли?';

  @override
  String get enterValidEmailFirst =>
      'Сначала введите корректный адрес эл. почты.';

  @override
  String passwordResetSent(String email) {
    return 'Ссылка для сброса отправлена на $email.';
  }

  @override
  String get showPasswordTooltip => 'Показать пароль';

  @override
  String get hidePasswordTooltip => 'Скрыть пароль';

  @override
  String get noAccountPrompt => 'Нет аккаунта?';

  @override
  String get createAccountLink => 'Создать';

  @override
  String get createAccountTitle => 'Создать аккаунт';

  @override
  String get createAccountSubtitle =>
      'Храните резервную копию всех задач, рутин и заметок в облаке.';

  @override
  String get haveAccountPrompt => 'Уже есть аккаунт?';

  @override
  String signedInVia(String provider) {
    return 'Вход через $provider';
  }

  @override
  String get syncNowButton => 'Синхронизировать';

  @override
  String get syncingLabel => 'Синхронизация...';

  @override
  String get syncDoneMessage => 'Синхронизация завершена.';

  @override
  String get syncFailedMessage => 'Ошибка синхронизации. Проверьте интернет.';

  @override
  String get syncStatusIdle => 'Ещё не синхронизировано';

  @override
  String get syncStatusSyncing => 'Синхронизация...';

  @override
  String get syncStatusSynced => 'Синхронизировано';

  @override
  String get syncStatusError => 'Ошибка синхронизации';

  @override
  String lastSyncedPrefix(String time) {
    return 'Последняя: $time';
  }

  @override
  String get neverSynced => 'Никогда не синхронизировалось';

  @override
  String get signOutButton => 'Выйти';

  @override
  String get signedOutMessage =>
      'Вы вышли из аккаунта. Локальные данные остались на устройстве.';

  @override
  String get deleteAccountButton => 'Удалить аккаунт';

  @override
  String get deleteAccountStep1Title => 'Удалить аккаунт?';

  @override
  String get deleteAccountStep1Body =>
      'Все облачные данные и аккаунт будут удалены навсегда. Локальные данные на устройстве сохранятся.';

  @override
  String get deleteAccountStep2Title => 'Подтвердите удаление';

  @override
  String get deleteAccountStep2Body =>
      'Это действие необратимо. Удалить аккаунт и все облачные данные навсегда?';

  @override
  String get deleteAccountConfirmButton => 'Да, удалить навсегда';

  @override
  String get accountDeletedMessage =>
      'Аккаунт и облачные данные удалены навсегда.';

  @override
  String get reloginRequiredTitle => 'Требуется повторный вход';

  @override
  String get authErrUserNotFound => 'Аккаунт с этой почтой не найден.';

  @override
  String get authErrWrongPassword => 'Неверный пароль.';

  @override
  String get authErrInvalidCredential => 'Неверная почта или пароль.';

  @override
  String get authErrInvalidEmail => 'Неверный формат эл. почты.';

  @override
  String get authErrEmailInUse => 'Эта почта уже зарегистрирована.';

  @override
  String get authErrWeakPassword =>
      'Слишком простой пароль. Минимум 6 символов.';

  @override
  String get authErrNetwork => 'Ошибка сети. Проверьте подключение.';

  @override
  String get authErrRequiresRecentLogin =>
      'Для безопасности выйдите и войдите снова перед удалением аккаунта.';

  @override
  String get authErrTooManyRequests =>
      'Слишком много попыток. Попробуйте позже.';

  @override
  String get authErrUserDisabled => 'Этот аккаунт отключён.';

  @override
  String get authErrAccountExistsDifferent =>
      'Эта почта привязана к другому способу входа.';

  @override
  String get authErrOperationNotAllowed => 'Этот способ входа отключён.';

  @override
  String get authErrFirebaseUnavailable => 'Сервис аккаунтов недоступен.';

  @override
  String get authErrUnknown => 'Ошибка авторизации. Попробуйте ещё раз.';

  @override
  String get widgetTitle => 'Zettask · Сегодня';

  @override
  String get widgetEmptyText => 'Все задачи на сегодня выполнены.';

  @override
  String get repeatingTasksAndFollowingDeleted =>
      'Повторяющаяся задача и следующие удалены';

  @override
  String get noProjectTasksTitle => 'В этом проекте пока нет задач';

  @override
  String noProjectTasksSubtitle(String project) {
    return 'Нажмите +, чтобы добавить задачу в «$project».';
  }

  @override
  String get addTaskToProjectTooltip => 'Добавить задачу в проект';

  @override
  String get noTagsSubtitle =>
      'Нажмите +, чтобы создать цветные теги для задач и заметок.';

  @override
  String get tagOptionsTooltip => 'Параметры тега';

  @override
  String get deleteTag => 'Удалить тег';

  @override
  String get addTagTooltip => 'Добавить тег';

  @override
  String get noTasksWithTag => 'Задач с этим тегом пока нет.';

  @override
  String get addTaskWithTagTooltip => 'Добавить задачу с тегом';

  @override
  String get tagNameHint => 'напр. Работа, Личное, Срочно';

  @override
  String get tagColorLabel => 'Цвет тега';

  @override
  String get createTag => 'Создать тег';

  @override
  String tagDeletedNamed(String name) {
    return 'Тег «$name» удалён';
  }

  @override
  String get noTemplatesSubtitle =>
      'Сохраняйте шаблоны частых задач и чек-листов для быстрого создания.';

  @override
  String get templateOptionsTooltip => 'Параметры шаблона';

  @override
  String get deleteTemplate => 'Удалить шаблон';

  @override
  String get createTemplateTooltip => 'Создать шаблон';

  @override
  String templateDeletedNamed(String name) {
    return 'Шаблон «$name» удалён';
  }

  @override
  String get templateNameHint => 'напр. Еженедельный релиз';

  @override
  String get defaultTaskTitleLabel => 'Название задачи по умолчанию';

  @override
  String get defaultTaskTitleHint => 'напр. Подготовить релиз';

  @override
  String get timeOptionalLabel => 'Время (необязательно)';

  @override
  String get clearTimeTooltip => 'Очистить время';

  @override
  String get projectOptionalLabel => 'Проект (необязательно)';

  @override
  String get tagOptionalLabel => 'Тег (необязательно)';

  @override
  String get defaultSubtasksLabel => 'Подзадачи по умолчанию';

  @override
  String get addTemplateSubtaskHint => 'Добавить подзадачу шаблона...';

  @override
  String get saveTemplate => 'Сохранить шаблон';

  @override
  String subtasksTotalCount(int count) {
    return '$count подзадач';
  }

  @override
  String get useTemplateButton => 'Использовать шаблон';

  @override
  String get pickTemplateTitle => 'Выбрать шаблон';

  @override
  String get repeatingTaskDeleted => 'Повторяющаяся задача удалена';

  @override
  String get noRepeatingTasksSubtitle =>
      'Нажмите +, чтобы создать ежедневные, еженедельные или ежемесячные рутины.';

  @override
  String get addRepeatingTaskTooltip => 'Добавить повторяющуюся задачу';

  @override
  String get editRepeatingTask => 'Изменить повторяющуюся задачу';

  @override
  String get newRepeatingTask => 'Новая повторяющаяся задача';

  @override
  String get deleteTaskTooltip => 'Удалить задачу';

  @override
  String get scheduleLabel => 'Расписание';

  @override
  String get startAndTimeLabel => 'Начало и время';

  @override
  String get dateRequiredForTime => 'Нужна дата';

  @override
  String get clearDateTooltip => 'Очистить дату';

  @override
  String get pickTimeFirstReminder =>
      'Сначала выберите время, чтобы включить напоминания.';

  @override
  String get notificationPermissionDenied =>
      'Уведомления отключены. Включите их в настройках устройства.';

  @override
  String get pickDateFirstRepeat =>
      'Сначала выберите дату для настройки повторения.';

  @override
  String get subtasksLabel => 'Подзадачи';

  @override
  String subtasksWithCount(int count) {
    return 'Подзадачи ($count)';
  }

  @override
  String get removeSubtaskTooltip => 'Удалить подзадачу';

  @override
  String get addSubtaskTooltip => 'Добавить подзадачу';

  @override
  String get moveAllOverdueMoved =>
      'Все просроченные задачи перенесены на сегодня';

  @override
  String get moveAllShort => 'Перенести все';

  @override
  String get noOverdueTasksSubtitle => 'Все задачи за прошлые дни выполнены.';

  @override
  String get repeatingDeletePrompt => 'Что вы хотите удалить?';

  @override
  String get repeatingEditPrompt => 'Что вы хотите изменить?';

  @override
  String get repeatingDeleteSingleSub => 'Удалить только этот раз';

  @override
  String get repeatingEditSingleSub => 'Изменить только этот раз';

  @override
  String get repeatingDeleteFollowingSub => 'Удалить этот и все следующие разы';

  @override
  String get repeatingEditFollowingSub => 'Применить к этому и всем следующим';

  @override
  String get deviceCalendarTitle => 'Календарь устройства';

  @override
  String get selectCalendarsLabel => 'Выберите календари';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '$selected/$total активно';
  }

  @override
  String get showCalendarEventsTitle => 'Показывать события календаря';

  @override
  String get showCalendarEventsSubtitle =>
      'События устройства отображаются хронологически только для чтения.';

  @override
  String get calendarPermDeniedPermanentTitle =>
      'Доступ к календарю запрещён навсегда';

  @override
  String get calendarPermRequiredTitle => 'Нужен доступ к чтению календаря';

  @override
  String get calendarPermDeniedPermanentDesc =>
      'Включите доступ к календарю в Настройках и нажмите Проверить снова.';

  @override
  String get calendarPermRequiredDesc =>
      'Zettask запрашивает только чтение календаря для показа событий в ленте.';

  @override
  String get openSettingsButton => 'Открыть настройки';

  @override
  String get checkAgainButton => 'Проверить снова';

  @override
  String get noCalendarsFound => 'На устройстве не найдено календарей.';

  @override
  String get eventDetailTitle => 'Детали события';

  @override
  String get eventNotesLabel => 'Заметки';

  @override
  String get calendarEventReadOnlyBanner =>
      'Событие из календаря устройства (только чтение).';

  @override
  String get markUncompletedSemantics => 'Отметить невыполненной';

  @override
  String get markCompletedSemantics => 'Отметить выполненной';

  @override
  String get deleteNoteTooltip => 'Удалить заметку';

  @override
  String repeatMonthlyDay(int day) {
    return 'Каждый месяц · $day числа';
  }

  @override
  String get last30DaysSubtitle => 'За 30 дней';

  @override
  String get allTimeSubtitle => 'За всё время';

  @override
  String get taskCancelled => 'Задача отмечена как отменённая';

  @override
  String get taskRestored => 'Задача снова активна';

  @override
  String get cancelledStatusLabel => 'Отменена';

  @override
  String get restoreTaskLabel => 'Восстановить';

  @override
  String get markCancelledSemantics => 'Отметить отменённой';

  @override
  String get calendarPermFallbackHint =>
      'Если запрос разрешения не появился, откройте Настройки приложения и включите доступ к Календарю вручную.';

  @override
  String get calendarBadgeLabel => 'Календарь';

  @override
  String get calendarSourceLabel => 'Календарь';

  @override
  String get calendarLocationLabel => 'Место';

  @override
  String get calendarReadOnlyInfo =>
      'Синхронизировано из календаря устройства. Эта запись доступна только для чтения и не редактируется в Zettask.';

  @override
  String get proBrandTitle => 'Zettask Pro';

  @override
  String get proBadge => 'PRO';

  @override
  String get proPaywallSubtitle =>
      'Облачная синхронизация, календари, блокировка приложения и OLED-темы.';

  @override
  String proActiveBannerTitle(String plan) {
    return 'Активна — $plan';
  }

  @override
  String get proActiveBannerSubtitle => 'Спасибо за поддержку Zettask.';

  @override
  String get proUpgradeBannerSubtitle =>
      'Тема AMOLED, свои акценты, стили виджета и другое';

  @override
  String get proBenefitCloudSync =>
      'Облачная синхронизация и несколько устройств';

  @override
  String get proBenefitCalendar => 'Интеграция календаря и праздники';

  @override
  String get proBenefitAppLock =>
      'Биометрическая блокировка и скрытие в недавних';

  @override
  String get proBenefitProjectsCsv => 'Безлимитные проекты и экспорт CSV';

  @override
  String get proBenefitCustomization =>
      'AMOLED чистый черный, акценты и стили виджета';

  @override
  String get proPlanMonthlyTitle => 'Месяц';

  @override
  String get proPlanMonthlyPrice => '\$1.99 / мес';

  @override
  String get proPlanYearlyTitle => 'Год';

  @override
  String get proPlanYearlyPrice => '\$12.99 / год';

  @override
  String get proPlanYearlyBadge => 'Выгоднее';

  @override
  String get proPlanYearlySavings => 'Экономия ~43%';

  @override
  String get proPlanLifetimeTitle => 'Навсегда';

  @override
  String get proPlanLifetimePrice => '\$29.99';

  @override
  String get proPlanLifetimeBadge => 'Разовый платеж';

  @override
  String get proContinueButton => 'Продолжить';

  @override
  String get proAlreadyActiveButton => 'Zettask Pro активна';

  @override
  String get proRestorePurchasesButton => 'Восстановить покупки';

  @override
  String get proLegalFootnote =>
      'Подписка продлевается автоматически, если ее не отменить. Отмена доступна в любое время в Google Play.';

  @override
  String get proStoreUnavailableMessage =>
      'Оплата Google Play пока недоступна на этом устройстве. Повторите попытку позже.';

  @override
  String get proPurchaseSuccessMessage => 'Zettask Pro активирована.';

  @override
  String get proRestoreSuccessMessage => 'Покупка Zettask Pro восстановлена.';

  @override
  String get proRestoreEmptyMessage =>
      'Активных покупок Zettask Pro для этого аккаунта не найдено.';

  @override
  String get proPurchaseFailedMessage =>
      'Не удалось завершить покупку. Попробуйте еще раз.';

  @override
  String get debugProSimulationLabel => 'Режим разработчика: симуляция Pro';

  @override
  String get amoledPureBlackTitle => 'AMOLED чистый черный';

  @override
  String get amoledPureBlackSubtitle =>
      'Чисто черный фон #000000 для OLED-экранов';

  @override
  String get customAccentSection => 'Пользовательский акцентный цвет';

  @override
  String get accentMonochrome => 'Монохром';

  @override
  String get accentSage => 'Шалфей';

  @override
  String get accentIndigo => 'Индиго';

  @override
  String get accentTerracotta => 'Терракота';

  @override
  String get accentAmber => 'Янтарь';

  @override
  String get widgetStyleSection => 'Стиль виджета главного экрана';

  @override
  String get widgetStyleStandard => 'Стандартный';

  @override
  String get widgetStyleAmoled => 'AMOLED';

  @override
  String get widgetStyleTranslucent => 'Полупрозрачный';

  @override
  String get proContextUnlimitedProjects =>
      'В бесплатном тарифе доступно до 3 проектов. Оформите Zettask Pro для безлимитных проектов.';

  @override
  String get proContextCalendarSync =>
      'Синхронизация календаря и праздники доступны в Zettask Pro.';

  @override
  String get proContextAppLock =>
      'Биометрическая блокировка и скрытие в недавних доступны в Zettask Pro.';

  @override
  String get proContextCsvExport =>
      'Экспорт задач и заметок в CSV доступен в Zettask Pro.';

  @override
  String get proContextCloudSync =>
      'Облачная синхронизация между устройствами доступна в Zettask Pro.';

  @override
  String get proContextCustomThemes =>
      'AMOLED чистый черный и свои цвета акцента доступны в Zettask Pro.';

  @override
  String get proContextWidgetStyles =>
      'Стили виджета AMOLED и полупрозрачный доступны в Zettask Pro.';

  @override
  String get cloudSyncPausedShort =>
      'Синхронизация на паузе · Локальные данные в безопасности';

  @override
  String get cloudSyncPausedTitle => 'Облачная синхронизация на паузе';

  @override
  String get cloudSyncPausedBody =>
      'Подписка Zettask Pro неактивна. Локальные задачи и заметки остаются в безопасности на устройстве.';

  @override
  String get resumeSyncWithProButton => 'Возобновить с Pro';

  @override
  String get onboardingSkip => 'Пропустить';

  @override
  String get onboardingNext => 'Далее';

  @override
  String get onboardingGetStarted => 'Начать';

  @override
  String get onboardingSlide1Title => 'Задачи без лишнего шума';

  @override
  String get onboardingSlide1Body =>
      'Добавляйте дела за секунды, разбивайте на подзадачи и отмечайте выполнение одним касанием.';

  @override
  String get onboardingSlide2Title => 'Четкий таймлайн и проекты';

  @override
  String get onboardingSlide2Body =>
      'Смотрите расписание по часам, группируйте задачи в проекты и получайте локальные напоминания вовремя.';

  @override
  String get onboardingSlide3Title => 'Быстро, офлайн и приватно';

  @override
  String get onboardingSlide3Body =>
      'Все данные хранятся локально на вашем устройстве. Аккаунт не требуется, работает без интернета.';

  @override
  String get appGuideTitle => 'Гид по приложению';

  @override
  String get appGuideSubtitle => 'Повторить краткое знакомство с Zettask';

  @override
  String get dynamicColorTitle => 'Material You (Цвет обоев)';

  @override
  String get dynamicColorSubtitle =>
      'Подбирать акцентные цвета под обои устройства (Android 12+)';
}
