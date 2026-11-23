// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => 'ציר זמן';

  @override
  String get navBoard => 'לוח';

  @override
  String get navUnplanned => 'לא מתוכנן';

  @override
  String get navMore => 'עוד';

  @override
  String get save => 'שמור';

  @override
  String get cancel => 'ביטול';

  @override
  String get close => 'סגור';

  @override
  String get delete => 'מחק';

  @override
  String get edit => 'ערוך';

  @override
  String get undo => 'בטל';

  @override
  String get back => 'חזור';

  @override
  String get retry => 'נסה שוב';

  @override
  String get clear => 'נקה';

  @override
  String get all => 'הכל';

  @override
  String get or => 'או';

  @override
  String get continueAction => 'המשך';

  @override
  String get understand => 'הבנתי';

  @override
  String get useAction => 'השתמש';

  @override
  String get today => 'היום';

  @override
  String get tomorrow => 'מחר';

  @override
  String get yesterday => 'אתמול';

  @override
  String get toDo => 'לביצוע';

  @override
  String get overdue => 'באיחור';

  @override
  String get unplanned => 'לא מתוכנן';

  @override
  String get allDay => 'כל היום';

  @override
  String get scheduled => 'מתוזמן';

  @override
  String get addTaskToday => 'הוסף משימה להיום';

  @override
  String get addTask => 'הוסף משימה';

  @override
  String get noTasksForDate => 'אין משימות לתאריך זה.';

  @override
  String get savedToUnplanned => 'נשמר בלא מתוכנן';

  @override
  String get savedToUnplannedNoDate => 'נשמר בלא מתוכנן (ללא תאריך)';

  @override
  String scheduledForDate(String date) {
    return 'תוזמן ל-$date';
  }

  @override
  String taskScheduledForDate(String date) {
    return 'המשימה תוזמנה ל-$date';
  }

  @override
  String get taskDeleted => 'המשימה נמחקה';

  @override
  String get searchTasksTooltip => 'חיפוש משימות';

  @override
  String get timelineOptionsTooltip => 'אפשרויות ציר זמן';

  @override
  String get addTaskTooltip => 'הוסף משימה';

  @override
  String get completedLabel => 'הושלם';

  @override
  String get uncompleteLabel => 'סמן כפעיל';

  @override
  String subtasksCount(int done, int total) {
    return '$done/$total תתי-משימות';
  }

  @override
  String get repeatingTaskLabel => 'משימה חוזרת';

  @override
  String get quickAddHint => 'הוסף משימה חדשה...';

  @override
  String get expandTooltip => 'הרחב';

  @override
  String get saveTaskTooltip => 'שמור משימה';

  @override
  String get newTask => 'משימה חדשה';

  @override
  String get editTask => 'ערוך משימה';

  @override
  String get taskTitleLabel => 'כותרת המשימה';

  @override
  String get taskTitleHint => 'לדוגמה: סקירת הערות ספרינט';

  @override
  String get taskTitleRequired => 'כותרת המשימה נדרשת';

  @override
  String get descriptionLabel => 'תיאור';

  @override
  String get descriptionHint => 'הוסף הערות או הקשר...';

  @override
  String get pickDate => 'בחר תאריך';

  @override
  String get pickOnCalendar => 'בחר בלוח השנה...';

  @override
  String get noDateUnplanned => 'ללא תאריך (לא מתוכנן)';

  @override
  String get noDate => 'ללא תאריך';

  @override
  String get taskTime => 'שעת המשימה';

  @override
  String get changeTime => 'שנה שעה';

  @override
  String get clearTimeAllDay => 'נקה שעה (כל היום)';

  @override
  String get timeLabel => 'שעה';

  @override
  String get reminderLabel => 'תזכורת';

  @override
  String get noReminder => 'ללא תזכורת';

  @override
  String get atTime => 'בזמן';

  @override
  String get minutesBefore10 => '10 דקות לפני';

  @override
  String get minutesBefore30 => '30 דקות לפני';

  @override
  String get hourBefore1 => 'שעה לפני';

  @override
  String get reminderShort10m => '10 דק\'';

  @override
  String get reminderShort30m => '30 דק\'';

  @override
  String get reminderShort1h => 'שעה';

  @override
  String get projectLabel => 'פרויקט';

  @override
  String get noProject => 'ללא פרויקט';

  @override
  String get tagLabel => 'תגית';

  @override
  String get noTag => 'ללא תגית';

  @override
  String get priorityLabel => 'עדיפות';

  @override
  String get priorityLow => 'נמוכה';

  @override
  String get priorityMedium => 'בינונית';

  @override
  String get priorityHigh => 'גבוהה';

  @override
  String get saveTask => 'שמור משימה';

  @override
  String get saveChanges => 'שמור שינויים';

  @override
  String get checklistLabel => 'רשימת משנה';

  @override
  String get addChecklistHint => 'הוסף פריט לרשימה...';

  @override
  String get repeatLabel => 'חזרה';

  @override
  String get noRepeat => 'ללא חזרה';

  @override
  String get repeatDaily => 'כל יום';

  @override
  String get repeatWeekly => 'כל שבוע';

  @override
  String get repeatMonthly => 'כל חודש';

  @override
  String get colorLabel => 'צבע';

  @override
  String get timelineOptionsTitle => 'אפשרויות ציר זמן';

  @override
  String get viewModeLabel => 'מצב תצוגה';

  @override
  String get modeTimeline => 'מצב ציר זמן';

  @override
  String get modeDaily => 'מצב יומי';

  @override
  String get firstDayOfWeek => 'יום תחילת השבוע';

  @override
  String get monday => 'שני';

  @override
  String get sunday => 'ראשון';

  @override
  String get firstDayMondayOrder => 'ב\' · ג\' · ד\' · ה\' · ו\' · ש\' · א\'';

  @override
  String get firstDaySundayOrder => 'א\' · ב\' · ג\' · ד\' · ה\' · ו\' · ש\'';

  @override
  String get showCompletedTasks => 'הצג משימות שהושלמו';

  @override
  String get showCompletedTasksSubtitle =>
      'הסתר משימות שסומנו כדי להתמקד בפעילות.';

  @override
  String get showCompletedWorkspaceSubtitle => 'הצג או הסתר משימות שהושלמו.';

  @override
  String get overdueTasksTitle => 'משימות באיחור';

  @override
  String get noOverdueTasks => 'אין משימות באיחור';

  @override
  String get moveToToday => 'העבר להיום';

  @override
  String get moveAllToToday => 'העבר הכל להיום';

  @override
  String get searchTasksHint => 'חפש משימות...';

  @override
  String get searchTasksEmpty => 'הקלד כדי לחפש משימות, תיאורים או רשימות.';

  @override
  String searchNoResults(String query) {
    return 'לא נמצאו משימות התואמות ל-\"$query\".';
  }

  @override
  String get calendarEventReadOnly => 'אירוע יומן · לקריאה בלבד';

  @override
  String get prevWeekTooltip => 'שבוע קודם';

  @override
  String get nextWeekTooltip => 'שבוע הבא';

  @override
  String get boardTitle => 'לוח';

  @override
  String get allProjects => 'כל הפרויקטים';

  @override
  String get searchProjectHint => 'חפש שם פרויקט...';

  @override
  String get searchProjectTooltip => 'חיפוש פרויקטים';

  @override
  String get closeSearchTooltip => 'סגור חיפוש';

  @override
  String get createProject => 'צור פרויקט';

  @override
  String get editProject => 'ערוך פרויקט';

  @override
  String get deleteProject => 'מחק פרויקט';

  @override
  String get projectOptionsTooltip => 'אפשרויות פרויקט';

  @override
  String projectDeleted(String name) {
    return 'הפרויקט \"$name\" נמחק';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return '$done/$total הושלמו';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return '$done/$total משימות הושלמו';
  }

  @override
  String get projectNotFound => 'הפרויקט לא נמצא';

  @override
  String get noProjectsYet => 'אין פרויקטים עדיין';

  @override
  String projectSearchEmpty(String query) {
    return 'אין פרויקט התואם ל-\"$query\".';
  }

  @override
  String get noProjectsSubtitle =>
      'לחץ על כפתור התיקייה למטה ליצירת הפרויקט הראשון.';

  @override
  String get newProject => 'פרויקט חדש';

  @override
  String get projectNameLabel => 'שם הפרויקט';

  @override
  String get projectNameHint => 'לדוגמה: השקת Zettask';

  @override
  String get projectNameRequired => 'שם הפרויקט נדרש';

  @override
  String get projectColorLabel => 'צבע הפרויקט';

  @override
  String get unplannedTitle => 'לא מתוכנן';

  @override
  String activeCountLabel(int count) {
    return '$count פעילות';
  }

  @override
  String get noUnplannedTitle => 'אין משימות לא מתוכננות';

  @override
  String get noUnplannedSubtitle => 'לחץ + כדי להוסיף משימה ללא תאריך.';

  @override
  String get addUnplannedTooltip => 'הוסף משימה לא מתוכננת';

  @override
  String get workspaceTitle => 'סביבת עבודה';

  @override
  String get organizeSection => 'ארגון';

  @override
  String get automationSection => 'אוטומציה';

  @override
  String get insightsSection => 'תובנות והתאמה אישית';

  @override
  String get settingsInfoSection => 'הגדרות ומידע';

  @override
  String get tagsTitle => 'תגיות';

  @override
  String get tagsSubtitleEmpty => 'תוויות צבע למשימות והערות';

  @override
  String tagsCountSubtitle(int count) {
    return '$count תגיות שמורות';
  }

  @override
  String get newTag => 'תגית חדשה';

  @override
  String get editTag => 'ערוך תגית';

  @override
  String get tagNameLabel => 'שם תגית';

  @override
  String get tagNameRequired => 'שם התגית נדרש';

  @override
  String get tagDeleted => 'התגית נמחקה';

  @override
  String get noTagsYet => 'אין תגיות עדיין';

  @override
  String tagTasksCount(int count) {
    return '$count משימות';
  }

  @override
  String get templatesTitle => 'תבניות';

  @override
  String get templatesSubtitleEmpty => 'שמור מבני משימות ורשימות לשימוש חוזר';

  @override
  String templatesCountSubtitle(int count) {
    return '$count תבניות מוכנות';
  }

  @override
  String get newTemplate => 'תבנית חדשה';

  @override
  String get editTemplate => 'ערוך תבנית';

  @override
  String get templateNameLabel => 'שם תבנית';

  @override
  String get templateNameRequired => 'שם התבנית נדרש';

  @override
  String get templateDeleted => 'התבנית נמחקה';

  @override
  String get noTemplatesYet => 'אין תבניות עדיין';

  @override
  String get taskFromTemplateSaved => 'משימה מהתבנית נשמרה';

  @override
  String get notesTitle => 'הערות';

  @override
  String get notesSubtitleEmpty => 'הערות מהירות ללא תאריך';

  @override
  String notesCountSubtitle(int count) {
    return '$count הערות שמורות';
  }

  @override
  String get newNote => 'הערה חדשה';

  @override
  String get editNote => 'ערוך הערה';

  @override
  String get noteTitleLabel => 'כותרת ההערה';

  @override
  String get noteTitleHint => 'לדוגמה: סיכום פגישה';

  @override
  String get noteTitleRequired => 'כותרת ההערה נדרשת';

  @override
  String get noteContentLabel => 'תוכן ההערה';

  @override
  String get noteContentHint => 'כתוב את ההערה כאן...';

  @override
  String get noteDeleted => 'ההערה נמחקה';

  @override
  String get searchNotesHint => 'חפש הערות...';

  @override
  String get noteNotFound => 'ההערה לא נמצאה';

  @override
  String get noNotesYet => 'אין הערות עדיין';

  @override
  String noteSearchEmpty(String query) {
    return 'אין הערה התואמת ל-\"$query\".';
  }

  @override
  String get noNotesSubtitle => 'לחץ + כדי לכתוב הערה מהירה.';

  @override
  String get saveNote => 'שמור הערה';

  @override
  String get repeatingTasksTitle => 'משימות חוזרות';

  @override
  String get repeatingTasksSubtitleEmpty =>
      'נהל שגרות יומיות, שבועיות וחודשיות';

  @override
  String repeatingActiveCount(int count) {
    return '$count שגרות פעילות';
  }

  @override
  String get noRepeatingTasks => 'אין משימות חוזרות עדיין';

  @override
  String get repeatingActionTitle => 'זוהי משימה חוזרת';

  @override
  String get repeatingThisOnly => 'משימה זו בלבד';

  @override
  String get repeatingThisAndFollowing => 'משימה זו וכל הבאות אחריה';

  @override
  String get last7DaysUpper => '7 הימים האחרונים';

  @override
  String weeklySummary(int tasks, int checklists) {
    return '$tasks משימות, פלוס $checklists פריטי רשימה';
  }

  @override
  String get statsTitle => 'סטטיסטיקה';

  @override
  String get range7Days => '7 ימים';

  @override
  String get range30Days => '30 ימים';

  @override
  String get completedToday => 'הושלם היום';

  @override
  String get last7DaysLabel => '7 ימים אחרונים';

  @override
  String get last30DaysLabel => '30 ימים אחרונים';

  @override
  String get allTimeLabel => 'כל הזמנים';

  @override
  String get completionRateLabel => 'שיעור השלמה';

  @override
  String get activity7Days => 'פעילות ב-7 הימים האחרונים';

  @override
  String get activity30Days => 'פעילות ב-30 הימים האחרונים';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks משימות · $checklists פריטים';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return 'סה\"כ ב-$days ימים: $tasks משימות ו-$checklists פריטי רשימה';
  }

  @override
  String get completedByPriority => 'הושלמו לפי עדיפות';

  @override
  String get progressByProject => 'התקדמות לפי פרויקט';

  @override
  String get breakdownByTag => 'פירוט לפי תגית';

  @override
  String get habits30Days => 'הרגלים · 30 ימים';

  @override
  String get noProjectsCreated => 'עדיין לא נוצרו פרויקטים.';

  @override
  String get noTagsCreated => 'עדיין לא נוצרו תגיות.';

  @override
  String get noActiveHabits => 'אין שגרות פעילות עדיין.';

  @override
  String completedCountLabel(int count) {
    return '$count הושלמו';
  }

  @override
  String tagBreakdownTrailing(int done, int total) {
    return '$done/$total הושלמו';
  }

  @override
  String habitCompletedRatio(String summary, int done, int scheduled) {
    return '$summary · $done/$scheduled הושלמו';
  }

  @override
  String statsSubtitle(int completed, int percent) {
    return '$completed הושלמו · $percent% שיעור השלמה';
  }

  @override
  String get themeTitle => 'ערכת נושא';

  @override
  String get themeAndColorsTitle => 'ערכת נושא וצבעים';

  @override
  String get livePreviewSection => 'תצוגה מקדימה';

  @override
  String get appearanceModeSection => 'מצב תצוגה';

  @override
  String get colorPaletteSection => 'פלטת צבעים';

  @override
  String get themeLight => 'בהיר';

  @override
  String get themeDark => 'כהה';

  @override
  String get themeSystem => 'מערכת';

  @override
  String get themeSystemLight => 'מערכת (בהיר)';

  @override
  String get themeSystemDark => 'מערכת (כהה)';

  @override
  String get presetDefault => 'ברירת מחדל';

  @override
  String get presetDefaultDesc => 'אינדיגו וצפחה';

  @override
  String get presetOcean => 'אוקיינוס';

  @override
  String get presetOceanDesc => 'כחול רגוע';

  @override
  String get presetForest => 'יער';

  @override
  String get presetForestDesc => 'ירוק מרווה ואזמרגד';

  @override
  String get presetTerracotta => 'טרקוטה';

  @override
  String get presetTerracottaDesc => 'כתום חם';

  @override
  String get presetPlum => 'שזיף';

  @override
  String get presetPlumDesc => 'סגול מעודן';

  @override
  String get presetMonochrome => 'מונוכרום';

  @override
  String get presetMonochromeDesc => 'פחם ושחור';

  @override
  String get previewActiveTask => 'סקירת עיצוב הממשק';

  @override
  String get previewCompletedTask => 'סנכרון לוח זמנים שבועי';

  @override
  String get languageTitle => 'שפה';

  @override
  String get deviceLanguageOption => 'שפת המכשיר (אם נתמכת)';

  @override
  String get appLockTitle => 'נעילת אפליקציה';

  @override
  String get appLockSubtitle => 'טביעת אצבע, זיהוי פנים או קוד PIN';

  @override
  String get appLockLockedTitle => 'Zettask נעולה';

  @override
  String get appLockLockedSubtitle =>
      'השתמש בטביעת אצבע, זיהוי פנים או קוד PIN כדי להמשיך.';

  @override
  String get unlockButton => 'פתח נעילה';

  @override
  String get verifyingButton => 'מאמת...';

  @override
  String get appLockUnsupportedError =>
      'במכשיר זה לא מופעל זיהוי ביומטרי או קוד נעילה.';

  @override
  String get appLockCancelledError => 'האימות בוטל או נכשל.';

  @override
  String get appLockUnlockFailedError =>
      'האימות נכשל. הקש פתח נעילה לניסיון נוסף.';

  @override
  String get calendarSyncTitle => 'סנכרון יומן';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return 'פעיל · $count יומנים';
  }

  @override
  String get calendarSyncInactiveSubtitle =>
      'כבוי · הצגת אירועי מכשיר לקריאה בלבד';

  @override
  String get grantCalendarPermission => 'אפשר גישה ליומן';

  @override
  String get exportCsvTitle => 'ייצוא CSV';

  @override
  String get exportCsvSubtitle => 'שתף משימות או הערות כקובצי CSV';

  @override
  String get exportDataCsvTitle => 'ייצוא נתוני CSV';

  @override
  String get exportTasksTitle => 'ייצוא משימות';

  @override
  String get exportTasksSubtitle =>
      'כל המשימות המתוזמנות, הלא מתוכננות והפרויקטים';

  @override
  String get exportNotesTitle => 'ייצוא הערות';

  @override
  String get exportNotesSubtitle => 'כל ההערות המהירות';

  @override
  String get exportBothTitle => 'ייצוא שניהם';

  @override
  String get exportBothSubtitle => 'קובצי CSV של משימות והערות יחד';

  @override
  String get aboutPrivacyTitle => 'אודות ומדיניות פרטיות';

  @override
  String aboutPrivacySubtitle(String version) {
    return 'גרסה $version · מקומי תחילה וענן אופציונלי';
  }

  @override
  String get aboutTitle => 'אודות Zettask';

  @override
  String versionLabel(String version) {
    return 'גרסה $version';
  }

  @override
  String get privacySyncTitle => 'פרטיות וסנכרון';

  @override
  String get privacySyncDescription =>
      'כברירת מחדל הנתונים נשמרים מקומית במכשיר. סנכרון ענן ב-Firebase הוא אופציונלי לאחר התחברות, וניתן למחוק את החשבון ונתוני הענן לצמיתות בכל עת.';

  @override
  String get privacyPolicyLabel => 'מדיניות פרטיות';

  @override
  String get privacyLinkCopied => 'קישור מדיניות הפרטיות הועתק';

  @override
  String get accountAndSyncTitle => 'חשבון וסנכרון';

  @override
  String get signInToZettask => 'התחבר לחשבון Zettask';

  @override
  String get accountBannerSubtitle => 'אופציונלי · גיבוי וסנכרון לענן';

  @override
  String get authWelcomeTitle => 'שמור את ההתקדמות והמשימות שלך';

  @override
  String get authWelcomeSubtitle =>
      'גבה משימות, פרויקטים והערות אוטומטית לענן. תמיד ניתן להשתמש ב-Zettask מקומית ללא חשבון.';

  @override
  String get createNewAccount => 'צור חשבון חדש';

  @override
  String get signIn => 'התחבר';

  @override
  String get continueWithGoogle => 'המשך עם Google';

  @override
  String get authTermsNotice =>
      'בהמשך השימוש הנך מסכים לתנאי השימוש ומדיניות הפרטיות של Zettask.';

  @override
  String get signInToAccountTitle => 'התחברות ל-Zettask';

  @override
  String get signInToAccountSubtitle =>
      'הנתונים המקומיים ימוזגו עם הגיבוי בענן.';

  @override
  String get emailLabel => 'דוא\"ל';

  @override
  String get emailHint => 'name@email.com';

  @override
  String get emailRequired => 'נא להזין כתובת דוא\"ל.';

  @override
  String get emailInvalid => 'כתובת דוא\"ל לא תקינה.';

  @override
  String get passwordLabel => 'סיסמה';

  @override
  String get passwordHint => 'הזן סיסמה';

  @override
  String get passwordNewHint => 'לפחות 6 תווים';

  @override
  String get passwordRequired => 'נא להזין סיסמה.';

  @override
  String get passwordTooShort => 'הסיסמה חייבת להכיל לפחות 6 תווים.';

  @override
  String get forgotPassword => 'שכחת?';

  @override
  String get enterValidEmailFirst => 'הזן כתובת דוא\"ל תקינה תחילה.';

  @override
  String passwordResetSent(String email) {
    return 'קישור לאיפוס סיסמה נשלח אל $email.';
  }

  @override
  String get showPasswordTooltip => 'הצג סיסמה';

  @override
  String get hidePasswordTooltip => 'הסתר סיסמה';

  @override
  String get noAccountPrompt => 'אין לך חשבון?';

  @override
  String get createAccountLink => 'צור חשבון';

  @override
  String get createAccountTitle => 'יצירת חשבון';

  @override
  String get createAccountSubtitle => 'גבה את כל המשימות, השגרות וההערות לענן.';

  @override
  String get haveAccountPrompt => 'כבר יש לך חשבון?';

  @override
  String signedInVia(String provider) {
    return 'מחובר דרך $provider';
  }

  @override
  String get syncNowButton => 'סנכרן עכשיו';

  @override
  String get syncingLabel => 'מסנכרן...';

  @override
  String get syncDoneMessage => 'הסנכרון הושלם.';

  @override
  String get syncFailedMessage => 'הסנכרון נכשל. בדוק את חיבור האינטרנט.';

  @override
  String get syncStatusIdle => 'טרם סונכרן';

  @override
  String get syncStatusSyncing => 'מסנכרן...';

  @override
  String get syncStatusSynced => 'מסונכרן';

  @override
  String get syncStatusError => 'שגיאת סנכרון';

  @override
  String lastSyncedPrefix(String time) {
    return 'סנכרון אחרון: $time';
  }

  @override
  String get neverSynced => 'לא סונכרן מעולם';

  @override
  String get signOutButton => 'התנתק';

  @override
  String get signedOutMessage =>
      'התנתקת בהצלחה. הנתונים המקומיים נשמרו במכשיר.';

  @override
  String get deleteAccountButton => 'מחק חשבון';

  @override
  String get deleteAccountStep1Title => 'למחוק את החשבון?';

  @override
  String get deleteAccountStep1Body =>
      'כל הגיבויים בענן והחשבון שלך יימחקו לצמיתות. הנתונים המקומיים במכשיר יישארו שמורים.';

  @override
  String get deleteAccountStep2Title => 'אישור מחיקה לצמיתות';

  @override
  String get deleteAccountStep2Body =>
      'לא ניתן לבטל פעולה זו. האם למחוק לצמיתות את החשבון וכל נתוני הענן כעת?';

  @override
  String get deleteAccountConfirmButton => 'כן, מחק לצמיתות';

  @override
  String get accountDeletedMessage => 'החשבון וכל נתוני הענן נמחקו לצמיתות.';

  @override
  String get reloginRequiredTitle => 'נדרשת התחברות מחדש';

  @override
  String get authErrUserNotFound => 'לא נמצא חשבון עם כתובת דוא\"ל זו.';

  @override
  String get authErrWrongPassword => 'הסיסמה שגויה.';

  @override
  String get authErrInvalidCredential => 'דוא\"ל או סיסמה אינם תקינים.';

  @override
  String get authErrInvalidEmail => 'פורמט דוא\"ל לא תקין.';

  @override
  String get authErrEmailInUse => 'כתובת דוא\"ל זו כבר רשומה.';

  @override
  String get authErrWeakPassword => 'הסיסמה חלשה מדי. השתמש ב-6 תווים לפחות.';

  @override
  String get authErrNetwork => 'בעיית רשת. בדוק את החיבור לאינטרנט.';

  @override
  String get authErrRequiresRecentLogin =>
      'מטעמי אבטחה, התנתק והתחבר מחדש לפני מחיקת החשבון.';

  @override
  String get authErrTooManyRequests =>
      'ניסיונות רבים מדי. נסה שוב בעוד זמן קצר.';

  @override
  String get authErrUserDisabled => 'חשבון זה הושבת.';

  @override
  String get authErrAccountExistsDifferent =>
      'כתובת זו משויכת לשיטת התחברות אחרת.';

  @override
  String get authErrOperationNotAllowed => 'שיטת התחברות זו אינה פעילה.';

  @override
  String get authErrFirebaseUnavailable => 'שירות החשבונות אינו זמין כעת.';

  @override
  String get authErrUnknown => 'שגיאת אימות. נסה שוב.';

  @override
  String get widgetTitle => 'Zettask · היום';

  @override
  String get widgetEmptyText => 'כל המשימות להיום הושלמו.';

  @override
  String get repeatingTasksAndFollowingDeleted =>
      'המשימה החוזרת והמועדים הבאים נמחקו';

  @override
  String get noProjectTasksTitle => 'אין עדיין משימות בפרויקט זה';

  @override
  String noProjectTasksSubtitle(String project) {
    return 'הקש + כדי להוסיף משימה אל $project.';
  }

  @override
  String get addTaskToProjectTooltip => 'הוסף משימה לפרויקט';

  @override
  String get noTagsSubtitle => 'הקש + כדי ליצור תגיות צבע למשימות והערות.';

  @override
  String get tagOptionsTooltip => 'אפשרויות תגית';

  @override
  String get deleteTag => 'מחק תגית';

  @override
  String get addTagTooltip => 'הוסף תגית';

  @override
  String get noTasksWithTag => 'אין עדיין משימות עם תגית זו.';

  @override
  String get addTaskWithTagTooltip => 'הוסף משימה עם תגית';

  @override
  String get tagNameHint => 'למשל: עבודה, אישי, דחוף';

  @override
  String get tagColorLabel => 'צבע תגית';

  @override
  String get createTag => 'צור תגית';

  @override
  String tagDeletedNamed(String name) {
    return 'התגית \"$name\" נמחקה';
  }

  @override
  String get noTemplatesSubtitle =>
      'שמור תבניות משימות ורשימות שימושיות ליצירה מהירה.';

  @override
  String get templateOptionsTooltip => 'אפשרויות תבנית';

  @override
  String get deleteTemplate => 'מחק תבנית';

  @override
  String get createTemplateTooltip => 'צור תבנית';

  @override
  String templateDeletedNamed(String name) {
    return 'התבנית \"$name\" נמחקה';
  }

  @override
  String get templateNameHint => 'למשל: שחרור שבועי';

  @override
  String get defaultTaskTitleLabel => 'כותרת משימה ברירת מחדל';

  @override
  String get defaultTaskTitleHint => 'למשל: הכנת גרסת ייצור';

  @override
  String get timeOptionalLabel => 'שעה (אופציונלי)';

  @override
  String get clearTimeTooltip => 'נקה שעה';

  @override
  String get projectOptionalLabel => 'פרויקט (אופציונלי)';

  @override
  String get tagOptionalLabel => 'תגית (אופציונלי)';

  @override
  String get defaultSubtasksLabel => 'תתי-משימות ברירת מחדל';

  @override
  String get addTemplateSubtaskHint => 'הוסף תת-משימה לתבנית...';

  @override
  String get saveTemplate => 'שמור תבנית';

  @override
  String subtasksTotalCount(int count) {
    return '$count תתי-משימות';
  }

  @override
  String get useTemplateButton => 'השתמש בתבנית';

  @override
  String get pickTemplateTitle => 'בחר תבנית';

  @override
  String get repeatingTaskDeleted => 'המשימה החוזרת נמחקה';

  @override
  String get noRepeatingTasksSubtitle =>
      'הקש + ליצירת שגרות יומיות, שבועיות או חודשיות.';

  @override
  String get addRepeatingTaskTooltip => 'הוסף משימה חוזרת';

  @override
  String get editRepeatingTask => 'ערוך משימה חוזרת';

  @override
  String get newRepeatingTask => 'משימה חוזרת חדשה';

  @override
  String get deleteTaskTooltip => 'מחק משימה';

  @override
  String get scheduleLabel => 'תזמון';

  @override
  String get startAndTimeLabel => 'התחלה ושעה';

  @override
  String get dateRequiredForTime => 'נדרש תאריך';

  @override
  String get clearDateTooltip => 'נקה תאריך';

  @override
  String get pickTimeFirstReminder => 'בחר שעה תחילה כדי להפעיל תזכורות.';

  @override
  String get notificationPermissionDenied =>
      'הרשאת ההתראות כבויה. הפעל אותה בהגדרות המכשיר.';

  @override
  String get pickDateFirstRepeat => 'בחר תאריך תחילה כדי להגדיר חזרה.';

  @override
  String get subtasksLabel => 'תתי-משימות';

  @override
  String subtasksWithCount(int count) {
    return 'תתי-משימות ($count)';
  }

  @override
  String get removeSubtaskTooltip => 'הסר תת-משימה';

  @override
  String get addSubtaskTooltip => 'הוסף תת-משימה';

  @override
  String get moveAllOverdueMoved => 'כל המשימות באיחור הועברו להיום';

  @override
  String get moveAllShort => 'העבר הכל';

  @override
  String get noOverdueTasksSubtitle => 'כל המשימות מימים קודמים הושלמו.';

  @override
  String get repeatingDeletePrompt => 'מה ברצונך למחוק?';

  @override
  String get repeatingEditPrompt => 'מה ברצונך לשנות?';

  @override
  String get repeatingDeleteSingleSub => 'מחק רק מועד זה';

  @override
  String get repeatingEditSingleSub => 'ערוך רק מועד זה';

  @override
  String get repeatingDeleteFollowingSub => 'מחק מועד זה ואת כל הבאים';

  @override
  String get repeatingEditFollowingSub => 'החל על מועד זה ועל כל הבאים';

  @override
  String get deviceCalendarTitle => 'יומן המכשיר';

  @override
  String get selectCalendarsLabel => 'בחר יומנים';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '$selected/$total פעילים';
  }

  @override
  String get showCalendarEventsTitle => 'הצג אירועי יומן';

  @override
  String get showCalendarEventsSubtitle =>
      'אירועי המכשיר מוצגים כרונולוגית לקריאה בלבד.';

  @override
  String get calendarPermDeniedPermanentTitle => 'הרשאת היומן נדחתה לצמיתות';

  @override
  String get calendarPermRequiredTitle => 'נדרשת הרשאת קריאה ליומן';

  @override
  String get calendarPermDeniedPermanentDesc =>
      'הפעל הרשאת קריאת יומן בהגדרות המכשיר והקש בדוק שוב.';

  @override
  String get calendarPermRequiredDesc =>
      'Zettask מבקשת הרשאת קריאה בלבד כדי להציג אירועים בציר הזמן.';

  @override
  String get openSettingsButton => 'פתח הגדרות';

  @override
  String get checkAgainButton => 'בדוק שוב';

  @override
  String get noCalendarsFound => 'לא נמצאו יומנים במכשיר זה.';

  @override
  String get eventDetailTitle => 'פרטי אירוע';

  @override
  String get eventNotesLabel => 'הערות';

  @override
  String get calendarEventReadOnlyBanner => 'אירוע מיומן המכשיר (לקריאה בלבד).';

  @override
  String get markUncompletedSemantics => 'סמן כלא הושלם';

  @override
  String get markCompletedSemantics => 'סמן כהושלם';

  @override
  String get deleteNoteTooltip => 'מחק הערה';

  @override
  String repeatMonthlyDay(int day) {
    return 'כל חודש · יום $day';
  }

  @override
  String get last30DaysSubtitle => '30 הימים האחרונים';

  @override
  String get allTimeSubtitle => 'כל הזמן';

  @override
  String get taskCancelled => 'המשימה סומנה כמבוטלת';

  @override
  String get taskRestored => 'המשימה הוחזרה לפעילה';

  @override
  String get cancelledStatusLabel => 'בוטלה';

  @override
  String get restoreTaskLabel => 'שחזר';

  @override
  String get markCancelledSemantics => 'סמן כמבוטלת';

  @override
  String get calendarPermFallbackHint =>
      'אם חלון ההרשאה לא הופיע, פתח את הגדרות האפליקציה כדי להפעיל גישה ליומן ידנית.';

  @override
  String get calendarBadgeLabel => 'יומן';

  @override
  String get calendarSourceLabel => 'יומן';

  @override
  String get calendarLocationLabel => 'מיקום';

  @override
  String get calendarReadOnlyInfo =>
      'מסונכרן מיומן המכשיר. פריט זה הוא לקריאה בלבד ולא ניתן לערוך אותו ב-Zettask.';

  @override
  String get proBrandTitle => 'Zettask Pro';

  @override
  String get proBadge => 'PRO';

  @override
  String get proPaywallSubtitle =>
      'סנכרון ענן, לוחות שנה, נעילת אפליקציה וערכות OLED בתוכנית אחת.';

  @override
  String proActiveBannerTitle(String plan) {
    return 'פעיל — $plan';
  }

  @override
  String get proActiveBannerSubtitle => 'תודה על התמיכה ב-Zettask.';

  @override
  String get proUpgradeBannerSubtitle =>
      'ערכת AMOLED, צבעי הדגשה מותאמים, סגנונות ווידג\'ט ועוד';

  @override
  String get proBenefitCloudSync => 'סנכרון ענן וריבוי מכשירים';

  @override
  String get proBenefitCalendar => 'שילוב לוח שנה וחגים לאומיים';

  @override
  String get proBenefitAppLock => 'נעילה ביומטרית ופרטיות באפליקציות אחרונות';

  @override
  String get proBenefitProjectsCsv => 'פרויקטים ללא הגבלה וייצוא CSV';

  @override
  String get proBenefitCustomization =>
      'AMOLED שחור טהור, צבעי הדגשה וסגנונות ווידג\'ט';

  @override
  String get proPlanMonthlyTitle => 'חודשי';

  @override
  String get proPlanMonthlyPrice => '\$1.99 / חודש';

  @override
  String get proPlanYearlyTitle => 'שנתי';

  @override
  String get proPlanYearlyPrice => '\$12.99 / שנה';

  @override
  String get proPlanYearlyBadge => 'המשתלם ביותר';

  @override
  String get proPlanYearlySavings => 'חיסכון של ~43%';

  @override
  String get proPlanLifetimeTitle => 'לכל החיים';

  @override
  String get proPlanLifetimePrice => '\$29.99';

  @override
  String get proPlanLifetimeBadge => 'תשלום חד-פעמי';

  @override
  String get proContinueButton => 'המשך';

  @override
  String get proAlreadyActiveButton => 'Zettask Pro פעיל';

  @override
  String get proRestorePurchasesButton => 'שחזור רכישות';

  @override
  String get proLegalFootnote =>
      'המינויים מתחדשים אוטומטית אלא אם בוטלו. ניתן לבטל בכל עת ב-Google Play.';

  @override
  String get proStoreUnavailableMessage =>
      'חיוב Google Play אינו זמין כרגע במכשיר זה. נסה שוב מאוחר יותר.';

  @override
  String get proPurchaseSuccessMessage => 'Zettask Pro פעיל כעת.';

  @override
  String get proRestoreSuccessMessage => 'רכישת Zettask Pro שלך שוחזרה.';

  @override
  String get proRestoreEmptyMessage =>
      'לא נמצאה רכישת Zettask Pro פעילה בחשבון זה.';

  @override
  String get proPurchaseFailedMessage =>
      'לא ניתן להשלים את הרכישה כרגע. נסה שוב.';

  @override
  String get debugProSimulationLabel => 'מצב מפתח: הדמיית Pro';

  @override
  String get amoledPureBlackTitle => 'AMOLED שחור טהור';

  @override
  String get amoledPureBlackSubtitle =>
      'רקע שחור טהור #000000 לחיסכון בסוללת OLED';

  @override
  String get customAccentSection => 'צבע הדגשה מותאם';

  @override
  String get accentMonochrome => 'מונוכרום';

  @override
  String get accentSage => 'מרווה';

  @override
  String get accentIndigo => 'אינדיגו';

  @override
  String get accentTerracotta => 'טרקוטה';

  @override
  String get accentAmber => 'ענבר';

  @override
  String get widgetStyleSection => 'סגנון ווידג\'ט מסך הבית';

  @override
  String get widgetStyleStandard => 'רגיל';

  @override
  String get widgetStyleAmoled => 'AMOLED';

  @override
  String get widgetStyleTranslucent => 'שקוף למחצה';

  @override
  String get proContextUnlimitedProjects =>
      'התוכנית החינמית כוללת עד 3 פרויקטים. שדרג ל-Zettask Pro לפרויקטים ללא הגבלה.';

  @override
  String get proContextCalendarSync =>
      'סנכרון לוח שנה וחגים לאומיים כלול ב-Zettask Pro.';

  @override
  String get proContextAppLock =>
      'נעילה ביומטרית ופרטיות באפליקציות אחרונות כלולים ב-Zettask Pro.';

  @override
  String get proContextCsvExport =>
      'ייצוא משימות והערות ל-CSV כלול ב-Zettask Pro.';

  @override
  String get proContextCloudSync =>
      'סנכרון ענן בין מכשירים כלול ב-Zettask Pro.';

  @override
  String get proContextCustomThemes =>
      'AMOLED שחור טהור וצבעי הדגשה מותאמים כלולים ב-Zettask Pro.';

  @override
  String get proContextWidgetStyles =>
      'סגנונות ווידג\'ט AMOLED ושקוף כלולים ב-Zettask Pro.';

  @override
  String get cloudSyncPausedShort =>
      'סנכרון ענן מושהה · הנתונים המקומיים בטוחים';

  @override
  String get cloudSyncPausedTitle => 'סנכרון ענן מושהה';

  @override
  String get cloudSyncPausedBody =>
      'מנוי Zettask Pro שלך אינו פעיל. המשימות וההערות המקומיות נשארות שמורות במכשיר זה.';

  @override
  String get resumeSyncWithProButton => 'חדש סנכרון עם Pro';

  @override
  String get onboardingSkip => 'דלג';

  @override
  String get onboardingNext => 'הבא';

  @override
  String get onboardingGetStarted => 'התחל עכשיו';

  @override
  String get onboardingSlide1Title => 'רשום משימות בלי הסחות דעת';

  @override
  String get onboardingSlide1Body =>
      'הוסף משימות יומיות בשניות, פרק לרשימות משנה וסמן כהושלם בהקשה אחת.';

  @override
  String get onboardingSlide2Title => 'ציר זמן ופרויקטים מסודרים';

  @override
  String get onboardingSlide2Body =>
      'צפה ביום שלך לפי סדר השעות, ארגן משימות בפרויקטים ועמוד בזמנים עם תזכורות מקומיות.';

  @override
  String get onboardingSlide3Title => 'מהיר, אופליין ופרטי';

  @override
  String get onboardingSlide3Body =>
      'הנתונים נשמרים קודם כל מקומית במכשיר שלך. בלי צורך בחשבון ומוכן גם ללא אינטרנט.';

  @override
  String get appGuideTitle => 'מדריך האפליקציה';

  @override
  String get appGuideSubtitle => 'הפעל מחדש את ההיכרות הקצרה עם Zettask';

  @override
  String get dynamicColorTitle => 'Material You (צבע טפט)';

  @override
  String get dynamicColorSubtitle =>
      'התאמת צבעי הדגשה לטפט המכשיר שלך (Android 12+)';

  @override
  String get subtaskMarkedCancelled => 'משימת המשנה בוטלה';

  @override
  String get subtaskCancelledBadge => 'בוטלה';

  @override
  String get cancelSubtaskTooltip => 'בטל משימת משנה';

  @override
  String get restoreSubtaskTooltip => 'שחזר משימת משנה';

  @override
  String get notificationActionComplete => 'הושלם';

  @override
  String get notificationActionSnooze => 'נודניק';

  @override
  String get notificationActionDismiss => 'סגור';

  @override
  String notificationSubtasksMore(int count) {
    return '+$count נוספות';
  }

  @override
  String notificationSubtasksSummary(int completed, int total) {
    return '$completed/$total הושלמו';
  }
}
