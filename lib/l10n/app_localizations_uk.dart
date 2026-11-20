// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => 'Стрічка';

  @override
  String get navBoard => 'Дошка';

  @override
  String get navUnplanned => 'Без дати';

  @override
  String get navMore => 'Ще';

  @override
  String get save => 'Зберегти';

  @override
  String get cancel => 'Скасувати';

  @override
  String get close => 'Закрити';

  @override
  String get delete => 'Видалити';

  @override
  String get edit => 'Редагувати';

  @override
  String get undo => 'Скасувати';

  @override
  String get back => 'Назад';

  @override
  String get retry => 'Спробувати знову';

  @override
  String get clear => 'Очистити';

  @override
  String get all => 'Усі';

  @override
  String get or => 'або';

  @override
  String get continueAction => 'Продовжити';

  @override
  String get understand => 'Зрозуміло';

  @override
  String get useAction => 'Використати';

  @override
  String get today => 'Сьогодні';

  @override
  String get tomorrow => 'Завтра';

  @override
  String get yesterday => 'Учора';

  @override
  String get toDo => 'До виконання';

  @override
  String get overdue => 'Прострочені';

  @override
  String get unplanned => 'Без дати';

  @override
  String get allDay => 'Весь день';

  @override
  String get scheduled => 'Заплановані';

  @override
  String get addTaskToday => 'Додати завдання на сьогодні';

  @override
  String get addTask => 'Додати завдання';

  @override
  String get noTasksForDate => 'На цю дату завдань немає.';

  @override
  String get savedToUnplanned => 'Збережено в Без дати';

  @override
  String get savedToUnplannedNoDate => 'Збережено в Без дати (без дати)';

  @override
  String scheduledForDate(String date) {
    return 'Заплановано на $date';
  }

  @override
  String taskScheduledForDate(String date) {
    return 'Завдання заплановано на $date';
  }

  @override
  String get taskDeleted => 'Завдання видалено';

  @override
  String get searchTasksTooltip => 'Пошук завдань';

  @override
  String get timelineOptionsTooltip => 'Параметри стрічки';

  @override
  String get addTaskTooltip => 'Додати завдання';

  @override
  String get completedLabel => 'Готово';

  @override
  String get uncompleteLabel => 'Позначити активним';

  @override
  String subtasksCount(int done, int total) {
    return '$done/$total підзавдань';
  }

  @override
  String get repeatingTaskLabel => 'Повторюване завдання';

  @override
  String get quickAddHint => 'Додати нове завдання...';

  @override
  String get expandTooltip => 'Розгорнути';

  @override
  String get saveTaskTooltip => 'Зберегти завдання';

  @override
  String get newTask => 'Нове завдання';

  @override
  String get editTask => 'Редагувати завдання';

  @override
  String get taskTitleLabel => 'Назва завдання';

  @override
  String get taskTitleHint => 'Напр.: Переглянути нотатки спринту';

  @override
  String get taskTitleRequired => 'Введіть назву завдання';

  @override
  String get descriptionLabel => 'Опис';

  @override
  String get descriptionHint => 'Додайте нотатки або деталі...';

  @override
  String get pickDate => 'Обрати дату';

  @override
  String get pickOnCalendar => 'Обрати в календарі...';

  @override
  String get noDateUnplanned => 'Без дати (Не заплановано)';

  @override
  String get noDate => 'Без дати';

  @override
  String get taskTime => 'Час завдання';

  @override
  String get changeTime => 'Змінити час';

  @override
  String get clearTimeAllDay => 'Прибрати час (Весь день)';

  @override
  String get timeLabel => 'Час';

  @override
  String get reminderLabel => 'Нагадування';

  @override
  String get noReminder => 'Без нагадування';

  @override
  String get atTime => 'Вчасно';

  @override
  String get minutesBefore10 => 'За 10 хв';

  @override
  String get minutesBefore30 => 'За 30 хв';

  @override
  String get hourBefore1 => 'За 1 годину';

  @override
  String get reminderShort10m => '10 хв';

  @override
  String get reminderShort30m => '30 хв';

  @override
  String get reminderShort1h => '1 год';

  @override
  String get projectLabel => 'Проєкт';

  @override
  String get noProject => 'Без проєкту';

  @override
  String get tagLabel => 'Тег';

  @override
  String get noTag => 'Без тегу';

  @override
  String get priorityLabel => 'Пріоритет';

  @override
  String get priorityLow => 'Низький';

  @override
  String get priorityMedium => 'Середній';

  @override
  String get priorityHigh => 'Високий';

  @override
  String get saveTask => 'Зберегти завдання';

  @override
  String get saveChanges => 'Зберегти зміни';

  @override
  String get checklistLabel => 'Чек-лист';

  @override
  String get addChecklistHint => 'Додати пункт...';

  @override
  String get repeatLabel => 'Повтор';

  @override
  String get noRepeat => 'Не повторюється';

  @override
  String get repeatDaily => 'Щодня';

  @override
  String get repeatWeekly => 'Щотижня';

  @override
  String get repeatMonthly => 'Щомісяця';

  @override
  String get colorLabel => 'Колір';

  @override
  String get timelineOptionsTitle => 'Параметри стрічки';

  @override
  String get viewModeLabel => 'Режим перегляду';

  @override
  String get modeTimeline => 'Режим стрічки';

  @override
  String get modeDaily => 'Денний режим';

  @override
  String get firstDayOfWeek => 'Початок тижня';

  @override
  String get monday => 'Понеділок';

  @override
  String get sunday => 'Неділя';

  @override
  String get firstDayMondayOrder => 'Пн · Вт · Ср · Чт · Пт · Сб · Нд';

  @override
  String get firstDaySundayOrder => 'Нд · Пн · Вт · Ср · Чт · Пт · Сб';

  @override
  String get showCompletedTasks => 'Показувати виконані';

  @override
  String get showCompletedTasksSubtitle =>
      'Приховуйте завершені завдання, щоб тримати фокус.';

  @override
  String get showCompletedWorkspaceSubtitle =>
      'Показувати або приховувати виконані завдання.';

  @override
  String get overdueTasksTitle => 'Прострочені завдання';

  @override
  String get noOverdueTasks => 'Немає прострочених завдань';

  @override
  String get moveToToday => 'Перенести на сьогодні';

  @override
  String get moveAllToToday => 'Перенести всі на сьогодні';

  @override
  String get searchTasksHint => 'Пошук завдань...';

  @override
  String get searchTasksEmpty =>
      'Введіть запит для пошуку завдань, описів або списків.';

  @override
  String searchNoResults(String query) {
    return 'Немає завдань для «$query».';
  }

  @override
  String get calendarEventReadOnly => 'Подія календаря · лише читання';

  @override
  String get prevWeekTooltip => 'Попередній тиждень';

  @override
  String get nextWeekTooltip => 'Наступний тиждень';

  @override
  String get boardTitle => 'Дошка';

  @override
  String get allProjects => 'Усі проєкти';

  @override
  String get searchProjectHint => 'Пошук проєкту...';

  @override
  String get searchProjectTooltip => 'Пошук проєктів';

  @override
  String get closeSearchTooltip => 'Закрити пошук';

  @override
  String get createProject => 'Створити проєкт';

  @override
  String get editProject => 'Редагувати проєкт';

  @override
  String get deleteProject => 'Видалити проєкт';

  @override
  String get projectOptionsTooltip => 'Параметри проєкту';

  @override
  String projectDeleted(String name) {
    return 'Проєкт «$name» видалено';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return '$done/$total готово';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return 'Виконано $done/$total';
  }

  @override
  String get projectNotFound => 'Проєкт не знайдено';

  @override
  String get noProjectsYet => 'Проєктів ще немає';

  @override
  String projectSearchEmpty(String query) {
    return 'Немає проєктів для «$query».';
  }

  @override
  String get noProjectsSubtitle =>
      'Натисніть на папку внизу, щоб створити перший проєкт.';

  @override
  String get newProject => 'Новий проєкт';

  @override
  String get projectNameLabel => 'Назва проєкту';

  @override
  String get projectNameHint => 'Напр.: Запуск Zettask';

  @override
  String get projectNameRequired => 'Введіть назву проєкту';

  @override
  String get projectColorLabel => 'Колір проєкту';

  @override
  String get unplannedTitle => 'Без дати';

  @override
  String activeCountLabel(int count) {
    return '$count активних';
  }

  @override
  String get noUnplannedTitle => 'Немає завдань без дати';

  @override
  String get noUnplannedSubtitle =>
      'Натисніть +, щоб додати завдання без дати.';

  @override
  String get addUnplannedTooltip => 'Додати завдання без дати';

  @override
  String get workspaceTitle => 'Робочий простір';

  @override
  String get organizeSection => 'Організація';

  @override
  String get automationSection => 'Автоматизація';

  @override
  String get insightsSection => 'Статистика й тема';

  @override
  String get settingsInfoSection => 'Налаштування та інфо';

  @override
  String get tagsTitle => 'Теги';

  @override
  String get tagsSubtitleEmpty => 'Кольорові мітки для завдань і нотаток';

  @override
  String tagsCountSubtitle(int count) {
    return 'Збережено тегів: $count';
  }

  @override
  String get newTag => 'Новий тег';

  @override
  String get editTag => 'Редагувати тег';

  @override
  String get tagNameLabel => 'Назва тегу';

  @override
  String get tagNameRequired => 'Введіть назву тегу';

  @override
  String get tagDeleted => 'Тег видалено';

  @override
  String get noTagsYet => 'Тегів ще немає';

  @override
  String tagTasksCount(int count) {
    return '$count завдань';
  }

  @override
  String get templatesTitle => 'Шаблони';

  @override
  String get templatesSubtitleEmpty =>
      'Зберігайте шаблони завдань і чек-листів';

  @override
  String templatesCountSubtitle(int count) {
    return 'Готово шаблонів: $count';
  }

  @override
  String get newTemplate => 'Новий шаблон';

  @override
  String get editTemplate => 'Редагувати шаблон';

  @override
  String get templateNameLabel => 'Назва шаблону';

  @override
  String get templateNameRequired => 'Введіть назву шаблону';

  @override
  String get templateDeleted => 'Шаблон видалено';

  @override
  String get noTemplatesYet => 'Шаблонів ще немає';

  @override
  String get taskFromTemplateSaved => 'Завдання із шаблону збережено';

  @override
  String get notesTitle => 'Нотатки';

  @override
  String get notesSubtitleEmpty => 'Швидкі нотатки без дати';

  @override
  String notesCountSubtitle(int count) {
    return 'Збережено нотаток: $count';
  }

  @override
  String get newNote => 'Нова нотатка';

  @override
  String get editNote => 'Редагувати нотатку';

  @override
  String get noteTitleLabel => 'Заголовок';

  @override
  String get noteTitleHint => 'Напр.: Підсумки зустрічі';

  @override
  String get noteTitleRequired => 'Введіть заголовок';

  @override
  String get noteContentLabel => 'Вміст';

  @override
  String get noteContentHint => 'Напишіть нотатку тут...';

  @override
  String get noteDeleted => 'Нотатку видалено';

  @override
  String get searchNotesHint => 'Пошук нотаток...';

  @override
  String get noteNotFound => 'Нотатку не знайдено';

  @override
  String get noNotesYet => 'Нотаток ще немає';

  @override
  String noteSearchEmpty(String query) {
    return 'Немає нотаток для «$query».';
  }

  @override
  String get noNotesSubtitle => 'Натисніть +, щоб створити швидку нотатку.';

  @override
  String get saveNote => 'Зберегти нотатку';

  @override
  String get repeatingTasksTitle => 'Повторювані завдання';

  @override
  String get repeatingTasksSubtitleEmpty =>
      'Щоденні, щотижневі та щомісячні рутини';

  @override
  String repeatingActiveCount(int count) {
    return 'Активних рутин: $count';
  }

  @override
  String get noRepeatingTasks => 'Повторюваних завдань немає';

  @override
  String get repeatingActionTitle => 'Це повторюване завдання';

  @override
  String get repeatingThisOnly => 'Лише це завдання';

  @override
  String get repeatingThisAndFollowing => 'Це та всі наступні';

  @override
  String get last7DaysUpper => 'ОСТАННІ 7 ДНІВ';

  @override
  String weeklySummary(int tasks, int checklists) {
    return '$tasks завдань і $checklists пунктів чек-листа';
  }

  @override
  String get statsTitle => 'Статистика';

  @override
  String get range7Days => '7 днів';

  @override
  String get range30Days => '30 днів';

  @override
  String get completedToday => 'За сьогодні';

  @override
  String get last7DaysLabel => 'За 7 днів';

  @override
  String get last30DaysLabel => 'За 30 днів';

  @override
  String get allTimeLabel => 'За весь час';

  @override
  String get completionRateLabel => 'Рівень виконання';

  @override
  String get activity7Days => 'Активність за 7 днів';

  @override
  String get activity30Days => 'Активність за 30 днів';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks завдань · $checklists пунктів';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return 'Усього за $days дн.: $tasks завдань і $checklists пунктів';
  }

  @override
  String get completedByPriority => 'Виконано за пріоритетом';

  @override
  String get progressByProject => 'Прогрес за проєктами';

  @override
  String get breakdownByTag => 'Деталізація за тегами';

  @override
  String get habits30Days => 'Звички · 30 днів';

  @override
  String get noProjectsCreated => 'Проєкти ще не створені.';

  @override
  String get noTagsCreated => 'Теги ще не створені.';

  @override
  String get noActiveHabits => 'Немає активних рутин.';

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
    return 'Виконано $completed · $percent%';
  }

  @override
  String get themeTitle => 'Тема';

  @override
  String get themeAndColorsTitle => 'Тема і кольори';

  @override
  String get livePreviewSection => 'Попередній перегляд';

  @override
  String get appearanceModeSection => 'Оформлення';

  @override
  String get colorPaletteSection => 'Палітра кольорів';

  @override
  String get themeLight => 'Світла';

  @override
  String get themeDark => 'Темна';

  @override
  String get themeSystem => 'Система';

  @override
  String get themeSystemLight => 'Система (Світла)';

  @override
  String get themeSystemDark => 'Система (Темна)';

  @override
  String get presetDefault => 'Типова';

  @override
  String get presetDefaultDesc => 'Індиго й сланець';

  @override
  String get presetOcean => 'Океан';

  @override
  String get presetOceanDesc => 'Спокійний синій';

  @override
  String get presetForest => 'Ліс';

  @override
  String get presetForestDesc => 'Шавлія та смарагд';

  @override
  String get presetTerracotta => 'Теракота';

  @override
  String get presetTerracottaDesc => 'Теплий помаранчевий';

  @override
  String get presetPlum => 'Слива';

  @override
  String get presetPlumDesc => 'М\'який фіолетовий';

  @override
  String get presetMonochrome => 'Монохром';

  @override
  String get presetMonochromeDesc => 'Графіт і чорний';

  @override
  String get previewActiveTask => 'Перевірити дизайн інтерфейсу';

  @override
  String get previewCompletedTask => 'Синхронізувати тижневий план';

  @override
  String get languageTitle => 'Мова';

  @override
  String get deviceLanguageOption => 'Мова пристрою (якщо підтримується)';

  @override
  String get appLockTitle => 'Блокування додатка';

  @override
  String get appLockSubtitle => 'Відбиток, обличчя або PIN пристрою';

  @override
  String get appLockLockedTitle => 'Zettask заблоковано';

  @override
  String get appLockLockedSubtitle =>
      'Використовуйте відбиток, обличчя або PIN-код пристрою.';

  @override
  String get unlockButton => 'Розблокувати';

  @override
  String get verifyingButton => 'Перевірка...';

  @override
  String get appLockUnsupportedError =>
      'На пристрої не налаштовано біометрію або PIN-код.';

  @override
  String get appLockCancelledError => 'Перевірку скасовано або не пройдено.';

  @override
  String get appLockUnlockFailedError =>
      'Помилка перевірки. Натисніть «Розблокувати».';

  @override
  String get calendarSyncTitle => 'Синхронізація календаря';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return 'Увімк · календарів: $count';
  }

  @override
  String get calendarSyncInactiveSubtitle => 'Вимк · події лише для читання';

  @override
  String get grantCalendarPermission => 'Надати доступ до календаря';

  @override
  String get exportCsvTitle => 'Експорт CSV';

  @override
  String get exportCsvSubtitle => 'Поділитися завданнями або нотатками в CSV';

  @override
  String get exportDataCsvTitle => 'Експорт даних CSV';

  @override
  String get exportTasksTitle => 'Експорт завдань';

  @override
  String get exportTasksSubtitle =>
      'Усі заплановані, без дати й проєктні завдання';

  @override
  String get exportNotesTitle => 'Експорт нотаток';

  @override
  String get exportNotesSubtitle => 'Усі швидкі нотатки';

  @override
  String get exportBothTitle => 'Експортувати все';

  @override
  String get exportBothSubtitle => 'Файли CSV завдань і нотаток разом';

  @override
  String get aboutPrivacyTitle => 'Про додаток і приватність';

  @override
  String aboutPrivacySubtitle(String version) {
    return 'Версія $version · Офлайн і опційна хмара';
  }

  @override
  String get aboutTitle => 'Про Zettask';

  @override
  String versionLabel(String version) {
    return 'Версія $version';
  }

  @override
  String get privacySyncTitle => 'Приватність і синхронізація';

  @override
  String get privacySyncDescription =>
      'Типово дані зберігаються локально. Хмарна синхронізація Firebase є опційною після входу, а обліковий запис і хмарні дані можна видалити назавжди в будь-який момент.';

  @override
  String get privacyPolicyLabel => 'Політика конфіденційності';

  @override
  String get privacyLinkCopied => 'Посилання скопійовано';

  @override
  String get accountAndSyncTitle => 'Обліковий запис і синхронізація';

  @override
  String get signInToZettask => 'Увійти в Zettask';

  @override
  String get accountBannerSubtitle => 'Опційно · резервне копіювання у хмару';

  @override
  String get authWelcomeTitle => 'Збережіть прогрес і завдання';

  @override
  String get authWelcomeSubtitle =>
      'Автоматично зберігайте розклад, проєкти та нотатки у хмарі. Ви можете користуватися Zettask локально без облікового запису.';

  @override
  String get createNewAccount => 'Створити обліковий запис';

  @override
  String get signIn => 'Увійти';

  @override
  String get continueWithGoogle => 'Продовжити з Google';

  @override
  String get authTermsNotice =>
      'Продовжуючи, ви погоджуєтеся з Умовами та Політикою конфіденційності Zettask.';

  @override
  String get signInToAccountTitle => 'Вхід у Zettask';

  @override
  String get signInToAccountSubtitle =>
      'Локальні дані об\'єднаються з хмарною копією.';

  @override
  String get emailLabel => 'Ел. пошта';

  @override
  String get emailHint => 'name@email.com';

  @override
  String get emailRequired => 'Введіть ел. пошту.';

  @override
  String get emailInvalid => 'Некоректний формат ел. пошти.';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get passwordHint => 'Введіть пароль';

  @override
  String get passwordNewHint => 'Мінімум 6 символів';

  @override
  String get passwordRequired => 'Введіть пароль.';

  @override
  String get passwordTooShort => 'Пароль має містити щонайменше 6 символів.';

  @override
  String get forgotPassword => 'Забули?';

  @override
  String get enterValidEmailFirst => 'Спочатку введіть коректну ел. пошту.';

  @override
  String passwordResetSent(String email) {
    return 'Посилання для скидання надіслано на $email.';
  }

  @override
  String get showPasswordTooltip => 'Показати пароль';

  @override
  String get hidePasswordTooltip => 'Приховати пароль';

  @override
  String get noAccountPrompt => 'Немає облікового запису?';

  @override
  String get createAccountLink => 'Створити';

  @override
  String get createAccountTitle => 'Створити обліковий запис';

  @override
  String get createAccountSubtitle =>
      'Зберігайте резервну копію всіх завдань, рутин і нотаток у хмарі.';

  @override
  String get haveAccountPrompt => 'Уже маєте обліковий запис?';

  @override
  String signedInVia(String provider) {
    return 'Вхід через $provider';
  }

  @override
  String get syncNowButton => 'Синхронізувати зараз';

  @override
  String get syncingLabel => 'Синхронізація...';

  @override
  String get syncDoneMessage => 'Синхронізацію завершено.';

  @override
  String get syncFailedMessage => 'Помилка синхронізації. Перевірте інтернет.';

  @override
  String get syncStatusIdle => 'Ще не синхронізовано';

  @override
  String get syncStatusSyncing => 'Синхронізація...';

  @override
  String get syncStatusSynced => 'Синхронізовано';

  @override
  String get syncStatusError => 'Помилка синхронізації';

  @override
  String lastSyncedPrefix(String time) {
    return 'Остання: $time';
  }

  @override
  String get neverSynced => 'Ніколи не синхронізувалося';

  @override
  String get signOutButton => 'Вийти';

  @override
  String get signedOutMessage =>
      'Ви вийшли. Локальні дані залишилися на пристрої.';

  @override
  String get deleteAccountButton => 'Видалити обліковий запис';

  @override
  String get deleteAccountStep1Title => 'Видалити обліковий запис?';

  @override
  String get deleteAccountStep1Body =>
      'Усі хмарні дані й обліковий запис буде видалено назавжди. Локальні дані на пристрої збережуться.';

  @override
  String get deleteAccountStep2Title => 'Підтвердіть остаточне видалення';

  @override
  String get deleteAccountStep2Body =>
      'Цю дію неможливо скасувати. Видалити обліковий запис і всі хмарні дані назавжди?';

  @override
  String get deleteAccountConfirmButton => 'Так, видалити назавжди';

  @override
  String get accountDeletedMessage =>
      'Обліковий запис і хмарні дані видалено назавжди.';

  @override
  String get reloginRequiredTitle => 'Потрібен повторний вхід';

  @override
  String get authErrUserNotFound =>
      'Обліковий запис із цією поштою не знайдено.';

  @override
  String get authErrWrongPassword => 'Невірний пароль.';

  @override
  String get authErrInvalidCredential => 'Невірна пошта або пароль.';

  @override
  String get authErrInvalidEmail => 'Некоректний формат ел. пошти.';

  @override
  String get authErrEmailInUse => 'Цю пошту вже зареєстровано.';

  @override
  String get authErrWeakPassword =>
      'Пароль занадто слабкий. Мінімум 6 символів.';

  @override
  String get authErrNetwork => 'Помилка мережі. Перевірте з\'єднання.';

  @override
  String get authErrRequiresRecentLogin =>
      'Задля безпеки вийдіть і увійдіть знову перед видаленням.';

  @override
  String get authErrTooManyRequests => 'Забагато спроб. Спробуйте пізніше.';

  @override
  String get authErrUserDisabled => 'Цей обліковий запис вимкнено.';

  @override
  String get authErrAccountExistsDifferent =>
      'Ця пошта прив\'язана до іншого способу входу.';

  @override
  String get authErrOperationNotAllowed => 'Цей спосіб входу вимкнено.';

  @override
  String get authErrFirebaseUnavailable =>
      'Сервіс облікових записів недоступний.';

  @override
  String get authErrUnknown => 'Помилка автентифікації. Спробуйте ще раз.';

  @override
  String get widgetTitle => 'Zettask · Сьогодні';

  @override
  String get widgetEmptyText => 'Усі завдання на сьогодні виконано.';

  @override
  String get repeatingTasksAndFollowingDeleted =>
      'Повторюване завдання та наступні видалено';

  @override
  String get noProjectTasksTitle => 'У цьому проєкті ще немає завдань';

  @override
  String noProjectTasksSubtitle(String project) {
    return 'Натисніть +, щоб додати завдання до «$project».';
  }

  @override
  String get addTaskToProjectTooltip => 'Додати завдання до проєкту';

  @override
  String get noTagsSubtitle =>
      'Натисніть +, щоб створити кольорові теги для завдань і нотаток.';

  @override
  String get tagOptionsTooltip => 'Параметри тегу';

  @override
  String get deleteTag => 'Видалити тег';

  @override
  String get addTagTooltip => 'Додати тег';

  @override
  String get noTasksWithTag => 'Завдань із цим тегом ще немає.';

  @override
  String get addTaskWithTagTooltip => 'Додати завдання з тегом';

  @override
  String get tagNameHint => 'напр. Робота, Особисте, Терміново';

  @override
  String get tagColorLabel => 'Колір тегу';

  @override
  String get createTag => 'Створити тег';

  @override
  String tagDeletedNamed(String name) {
    return 'Тег «$name» видалено';
  }

  @override
  String get noTemplatesSubtitle =>
      'Зберігайте шаблони частих завдань і чеклістів для швидкого створення.';

  @override
  String get templateOptionsTooltip => 'Параметри шаблону';

  @override
  String get deleteTemplate => 'Видалити шаблон';

  @override
  String get createTemplateTooltip => 'Створити шаблон';

  @override
  String templateDeletedNamed(String name) {
    return 'Шаблон «$name» видалено';
  }

  @override
  String get templateNameHint => 'напр. Щотижневий реліз';

  @override
  String get defaultTaskTitleLabel => 'Назва завдання за замовчуванням';

  @override
  String get defaultTaskTitleHint => 'напр. Підготувати реліз';

  @override
  String get timeOptionalLabel => 'Час (необов\'язково)';

  @override
  String get clearTimeTooltip => 'Очистити час';

  @override
  String get projectOptionalLabel => 'Проєкт (необов\'язково)';

  @override
  String get tagOptionalLabel => 'Тег (необов\'язково)';

  @override
  String get defaultSubtasksLabel => 'Підзавдання за замовчуванням';

  @override
  String get addTemplateSubtaskHint => 'Додати підзавдання шаблону...';

  @override
  String get saveTemplate => 'Зберегти шаблон';

  @override
  String subtasksTotalCount(int count) {
    return '$count підзавдань';
  }

  @override
  String get useTemplateButton => 'Використати шаблон';

  @override
  String get pickTemplateTitle => 'Вибрати шаблон';

  @override
  String get repeatingTaskDeleted => 'Повторюване завдання видалено';

  @override
  String get noRepeatingTasksSubtitle =>
      'Натисніть +, щоб створити щоденні, щотижневі або щомісячні рутини.';

  @override
  String get addRepeatingTaskTooltip => 'Додати повторюване завдання';

  @override
  String get editRepeatingTask => 'Редагувати повторюване завдання';

  @override
  String get newRepeatingTask => 'Нове повторюване завдання';

  @override
  String get deleteTaskTooltip => 'Видалити завдання';

  @override
  String get scheduleLabel => 'Розклад';

  @override
  String get startAndTimeLabel => 'Початок і час';

  @override
  String get dateRequiredForTime => 'Потрібна дата';

  @override
  String get clearDateTooltip => 'Очистити дату';

  @override
  String get pickTimeFirstReminder =>
      'Спочатку виберіть час, щоб увімкнути нагадування.';

  @override
  String get notificationPermissionDenied =>
      'Сповіщення вимкнено. Увімкніть їх у налаштуваннях пристрою.';

  @override
  String get pickDateFirstRepeat =>
      'Спочатку виберіть дату для налаштування повторення.';

  @override
  String get subtasksLabel => 'Підзавдання';

  @override
  String subtasksWithCount(int count) {
    return 'Підзавдання ($count)';
  }

  @override
  String get removeSubtaskTooltip => 'Видалити підзавдання';

  @override
  String get addSubtaskTooltip => 'Додати підзавдання';

  @override
  String get moveAllOverdueMoved =>
      'Усі прострочені завдання перенесено на сьогодні';

  @override
  String get moveAllShort => 'Перенести всі';

  @override
  String get noOverdueTasksSubtitle =>
      'Усі завдання за попередні дні виконано.';

  @override
  String get repeatingDeletePrompt => 'Що ви хочете видалити?';

  @override
  String get repeatingEditPrompt => 'Що ви хочете змінити?';

  @override
  String get repeatingDeleteSingleSub => 'Видалити лише цей раз';

  @override
  String get repeatingEditSingleSub => 'Змінити лише цей раз';

  @override
  String get repeatingDeleteFollowingSub => 'Видалити цей та всі наступні рази';

  @override
  String get repeatingEditFollowingSub =>
      'Застосувати до цього та всіх наступних';

  @override
  String get deviceCalendarTitle => 'Календар пристрою';

  @override
  String get selectCalendarsLabel => 'Виберіть календарі';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '$selected/$total активно';
  }

  @override
  String get showCalendarEventsTitle => 'Показувати події календаря';

  @override
  String get showCalendarEventsSubtitle =>
      'Події пристрою відображаються хронологічно лише для читання.';

  @override
  String get calendarPermDeniedPermanentTitle =>
      'Доступ до календаря заборонено назавжди';

  @override
  String get calendarPermRequiredTitle =>
      'Потрібен доступ на читання календаря';

  @override
  String get calendarPermDeniedPermanentDesc =>
      'Увімкніть доступ до календаря в Налаштуваннях і натисніть Перевірити знову.';

  @override
  String get calendarPermRequiredDesc =>
      'Zettask запитує лише читання календаря для показу подій у стрічці.';

  @override
  String get openSettingsButton => 'Відкрити налаштування';

  @override
  String get checkAgainButton => 'Перевірити знову';

  @override
  String get noCalendarsFound => 'На цьому пристрої не знайдено календарів.';

  @override
  String get eventDetailTitle => 'Деталі події';

  @override
  String get eventNotesLabel => 'Нотатки';

  @override
  String get calendarEventReadOnlyBanner =>
      'Подія з календаря пристрою (лише читання).';

  @override
  String get markUncompletedSemantics => 'Позначити невиконаним';

  @override
  String get markCompletedSemantics => 'Позначити виконаним';

  @override
  String get deleteNoteTooltip => 'Видалити нотатку';

  @override
  String repeatMonthlyDay(int day) {
    return 'Щомісяця · $day числа';
  }

  @override
  String get last30DaysSubtitle => 'За 30 днів';

  @override
  String get allTimeSubtitle => 'За весь час';

  @override
  String get taskCancelled => 'Завдання позначено як скасоване';

  @override
  String get taskRestored => 'Завдання знову активне';

  @override
  String get cancelledStatusLabel => 'Скасовано';

  @override
  String get restoreTaskLabel => 'Відновити';

  @override
  String get markCancelledSemantics => 'Позначити скасованим';

  @override
  String get calendarPermFallbackHint =>
      'Якщо запит дозволу не з’явився, відкрийте Налаштування додатку та увімкніть доступ до Календаря вручну.';

  @override
  String get calendarBadgeLabel => 'Календар';

  @override
  String get calendarSourceLabel => 'Календар';

  @override
  String get calendarLocationLabel => 'Місце';

  @override
  String get calendarReadOnlyInfo =>
      'Синхронізовано з календаря пристрою. Цей запис доступний лише для читання та не редагується в Zettask.';

  @override
  String get proBrandTitle => 'Zettask Pro';

  @override
  String get proBadge => 'PRO';

  @override
  String get proPaywallSubtitle =>
      'Хмарна синхронізація, календарі, блокування додатку та OLED-теми.';

  @override
  String proActiveBannerTitle(String plan) {
    return 'Активна — $plan';
  }

  @override
  String get proActiveBannerSubtitle => 'Дякуємо за підтримку Zettask.';

  @override
  String get proUpgradeBannerSubtitle =>
      'Тема AMOLED, власні акценти, стилі віджета та інше';

  @override
  String get proBenefitCloudSync => 'Хмарна синхронізація та кілька пристроїв';

  @override
  String get proBenefitCalendar => 'Інтеграція календаря та державні свята';

  @override
  String get proBenefitAppLock =>
      'Біометричне блокування та приватність у недавніх';

  @override
  String get proBenefitProjectsCsv => 'Необмежені проєкти та експорт CSV';

  @override
  String get proBenefitCustomization =>
      'AMOLED чистий чорний, кольори акценту та стилі віджета';

  @override
  String get proPlanMonthlyTitle => 'Місячний';

  @override
  String get proPlanMonthlyPrice => '\$1.99 / міс';

  @override
  String get proPlanYearlyTitle => 'Річний';

  @override
  String get proPlanYearlyPrice => '\$12.99 / рік';

  @override
  String get proPlanYearlyBadge => 'Найвигідніше';

  @override
  String get proPlanYearlySavings => 'Економія ~43%';

  @override
  String get proPlanLifetimeTitle => 'Назавжди';

  @override
  String get proPlanLifetimePrice => '\$29.99';

  @override
  String get proPlanLifetimeBadge => 'Разовий платіж';

  @override
  String get proContinueButton => 'Продовжити';

  @override
  String get proAlreadyActiveButton => 'Zettask Pro активна';

  @override
  String get proRestorePurchasesButton => 'Відновити покупки';

  @override
  String get proLegalFootnote =>
      'Підписка подовжується автоматично, якщо її не скасувати. Скасуйте будь-коли в Google Play.';

  @override
  String get proStoreUnavailableMessage =>
      'Оплата Google Play наразі недоступна на цьому пристрої. Спробуйте пізніше.';

  @override
  String get proPurchaseSuccessMessage => 'Zettask Pro активовано.';

  @override
  String get proRestoreSuccessMessage => 'Покупку Zettask Pro відновлено.';

  @override
  String get proRestoreEmptyMessage =>
      'Активних покупок Zettask Pro для цього облікового запису не знайдено.';

  @override
  String get proPurchaseFailedMessage =>
      'Не вдалося завершити покупку зараз. Спробуйте ще раз.';

  @override
  String get debugProSimulationLabel => 'Режим розробника: симуляція Pro';

  @override
  String get amoledPureBlackTitle => 'AMOLED чистий чорний';

  @override
  String get amoledPureBlackSubtitle =>
      'Чисто чорний фон #000000 для OLED-екранів';

  @override
  String get customAccentSection => 'Власний колір акценту';

  @override
  String get accentMonochrome => 'Монохром';

  @override
  String get accentSage => 'Шавлія';

  @override
  String get accentIndigo => 'Індиго';

  @override
  String get accentTerracotta => 'Теракота';

  @override
  String get accentAmber => 'Бурштин';

  @override
  String get widgetStyleSection => 'Стиль віджета головного екрана';

  @override
  String get widgetStyleStandard => 'Стандартний';

  @override
  String get widgetStyleAmoled => 'AMOLED';

  @override
  String get widgetStyleTranslucent => 'Напівпрозорий';

  @override
  String get proContextUnlimitedProjects =>
      'У безкоштовному тарифі доступно до 3 проєктів. Перейдіть на Zettask Pro для необмежених проєктів.';

  @override
  String get proContextCalendarSync =>
      'Синхронізація календаря та державні свята доступні в Zettask Pro.';

  @override
  String get proContextAppLock =>
      'Біометричне блокування та приватність у недавніх доступні в Zettask Pro.';

  @override
  String get proContextCsvExport =>
      'Експорт завдань і нотаток у CSV доступний у Zettask Pro.';

  @override
  String get proContextCloudSync =>
      'Хмарна синхронізація між пристроями доступна в Zettask Pro.';

  @override
  String get proContextCustomThemes =>
      'AMOLED чистий чорний і власні кольори акценту доступні в Zettask Pro.';

  @override
  String get proContextWidgetStyles =>
      'Стилі віджета AMOLED і напівпрозорий доступні в Zettask Pro.';

  @override
  String get cloudSyncPausedShort =>
      'Синхронізацію призупинено · Локальні дані в безпеці';

  @override
  String get cloudSyncPausedTitle => 'Хмарну синхронізацію призупинено';

  @override
  String get cloudSyncPausedBody =>
      'Підписка Zettask Pro неактивна. Локальні завдання та нотатки залишаються в безпеці на цьому пристрої.';

  @override
  String get resumeSyncWithProButton => 'Відновити з Pro';
}
