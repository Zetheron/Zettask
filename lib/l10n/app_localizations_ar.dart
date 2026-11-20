// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => 'الجدول الزمني';

  @override
  String get navBoard => 'اللوحة';

  @override
  String get navUnplanned => 'غير مجدولة';

  @override
  String get navMore => 'المزيد';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get close => 'إغلاق';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get undo => 'تراجع';

  @override
  String get back => 'رجوع';

  @override
  String get retry => 'حاول مجدداً';

  @override
  String get clear => 'مسح';

  @override
  String get all => 'الكل';

  @override
  String get or => 'أو';

  @override
  String get continueAction => 'متابعة';

  @override
  String get understand => 'فهمت';

  @override
  String get useAction => 'استخدام';

  @override
  String get today => 'اليوم';

  @override
  String get tomorrow => 'غداً';

  @override
  String get yesterday => 'أمس';

  @override
  String get toDo => 'للتنفيذ';

  @override
  String get overdue => 'متأخرة';

  @override
  String get unplanned => 'غير مجدولة';

  @override
  String get allDay => 'طوال اليوم';

  @override
  String get scheduled => 'مجدولة';

  @override
  String get addTaskToday => 'إضافة مهمة لليوم';

  @override
  String get addTask => 'إضافة مهمة';

  @override
  String get noTasksForDate => 'لا توجد مهام لهذا التاريخ.';

  @override
  String get savedToUnplanned => 'تم الحفظ في غير المجدولة';

  @override
  String get savedToUnplannedNoDate => 'تم الحفظ في غير المجدولة (بدون تاريخ)';

  @override
  String scheduledForDate(String date) {
    return 'تمت الجدولة ليوم $date';
  }

  @override
  String taskScheduledForDate(String date) {
    return 'تمت جدولة المهمة ليوم $date';
  }

  @override
  String get taskDeleted => 'تم حذف المهمة';

  @override
  String get searchTasksTooltip => 'بحث في المهام';

  @override
  String get timelineOptionsTooltip => 'خيارات الجدول الزمني';

  @override
  String get addTaskTooltip => 'إضافة مهمة';

  @override
  String get completedLabel => 'مكتملة';

  @override
  String get uncompleteLabel => 'إلغاء الإكمال';

  @override
  String subtasksCount(int done, int total) {
    return '$done/$total مهام فرعية';
  }

  @override
  String get repeatingTaskLabel => 'مهمة متكررة';

  @override
  String get quickAddHint => 'أضف مهمة جديدة...';

  @override
  String get expandTooltip => 'توسيع';

  @override
  String get saveTaskTooltip => 'حفظ المهمة';

  @override
  String get newTask => 'مهمة جديدة';

  @override
  String get editTask => 'تعديل المهمة';

  @override
  String get taskTitleLabel => 'عنوان المهمة';

  @override
  String get taskTitleHint => 'مثال: مراجعة ملاحظات الاجتماع';

  @override
  String get taskTitleRequired => 'عنوان المهمة مطلوب';

  @override
  String get descriptionLabel => 'الوصف';

  @override
  String get descriptionHint => 'أضف ملاحظات أو تفاصيل...';

  @override
  String get pickDate => 'اختيار التاريخ';

  @override
  String get pickOnCalendar => 'اختيار من التقويم...';

  @override
  String get noDateUnplanned => 'بدون تاريخ (غير مجدولة)';

  @override
  String get noDate => 'بدون تاريخ';

  @override
  String get taskTime => 'وقت المهمة';

  @override
  String get changeTime => 'تغيير الوقت';

  @override
  String get clearTimeAllDay => 'إزالة الوقت (طوال اليوم)';

  @override
  String get timeLabel => 'الوقت';

  @override
  String get reminderLabel => 'التذكير';

  @override
  String get noReminder => 'بدون تذكير';

  @override
  String get atTime => 'في الوقت المحدد';

  @override
  String get minutesBefore10 => 'قبل 10 دقائق';

  @override
  String get minutesBefore30 => 'قبل 30 دقيقة';

  @override
  String get hourBefore1 => 'قبل ساعة';

  @override
  String get reminderShort10m => '10 د';

  @override
  String get reminderShort30m => '30 د';

  @override
  String get reminderShort1h => '1 س';

  @override
  String get projectLabel => 'المشروع';

  @override
  String get noProject => 'بدون مشروع';

  @override
  String get tagLabel => 'الوسم';

  @override
  String get noTag => 'بدون وسم';

  @override
  String get priorityLabel => 'الأولوية';

  @override
  String get priorityLow => 'منخفضة';

  @override
  String get priorityMedium => 'متوسطة';

  @override
  String get priorityHigh => 'عالية';

  @override
  String get saveTask => 'حفظ المهمة';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get checklistLabel => 'قائمة التحقق';

  @override
  String get addChecklistHint => 'إضافة عنصر للقائمة...';

  @override
  String get repeatLabel => 'التكرار';

  @override
  String get noRepeat => 'لا تتكرر';

  @override
  String get repeatDaily => 'يومياً';

  @override
  String get repeatWeekly => 'أسبوعياً';

  @override
  String get repeatMonthly => 'شهرياً';

  @override
  String get colorLabel => 'اللون';

  @override
  String get timelineOptionsTitle => 'خيارات الجدول الزمني';

  @override
  String get viewModeLabel => 'وضع العرض';

  @override
  String get modeTimeline => 'وضع الجدول الزمني';

  @override
  String get modeDaily => 'الوضع اليومي';

  @override
  String get firstDayOfWeek => 'بداية الأسبوع';

  @override
  String get monday => 'الإثنين';

  @override
  String get sunday => 'الأحد';

  @override
  String get firstDayMondayOrder => 'إث · ثل · أر · خم · جم · سب · أح';

  @override
  String get firstDaySundayOrder => 'أح · إث · ثل · أر · خم · جم · سب';

  @override
  String get showCompletedTasks => 'إظهار المهام المكتملة';

  @override
  String get showCompletedTasksSubtitle =>
      'أخفِ المهام المنجزة للتركيز على المهام النشطة.';

  @override
  String get showCompletedWorkspaceSubtitle =>
      'إظهار أو إخفاء المهام المكتملة.';

  @override
  String get overdueTasksTitle => 'المهام المتأخرة';

  @override
  String get noOverdueTasks => 'لا توجد مهام متأخرة';

  @override
  String get moveToToday => 'نقل إلى اليوم';

  @override
  String get moveAllToToday => 'نقل الكل إلى اليوم';

  @override
  String get searchTasksHint => 'ابحث عن المهام...';

  @override
  String get searchTasksEmpty => 'اكتب للبحث في المهام أو الأوصاف أو القوائم.';

  @override
  String searchNoResults(String query) {
    return 'لا توجد مهام تطابق \"$query\".';
  }

  @override
  String get calendarEventReadOnly => 'حدث تقويم · للقراءة فقط';

  @override
  String get prevWeekTooltip => 'الأسبوع السابق';

  @override
  String get nextWeekTooltip => 'الأسبوع التالي';

  @override
  String get boardTitle => 'اللوحة';

  @override
  String get allProjects => 'كل المشاريع';

  @override
  String get searchProjectHint => 'ابحث عن مشروع...';

  @override
  String get searchProjectTooltip => 'بحث في المشاريع';

  @override
  String get closeSearchTooltip => 'إغلاق البحث';

  @override
  String get createProject => 'إنشاء مشروع';

  @override
  String get editProject => 'تعديل المشروع';

  @override
  String get deleteProject => 'حذف المشروع';

  @override
  String get projectOptionsTooltip => 'خيارات المشروع';

  @override
  String projectDeleted(String name) {
    return 'تم حذف المشروع \"$name\"';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return '$done/$total مكتمل';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return '$done/$total مهام مكتملة';
  }

  @override
  String get projectNotFound => 'المشروع غير موجود';

  @override
  String get noProjectsYet => 'لا توجد مشاريع بعد';

  @override
  String projectSearchEmpty(String query) {
    return 'لا يوجد مشروع يطابق \"$query\".';
  }

  @override
  String get noProjectsSubtitle =>
      'اضغط على زر المجلد بالأسفل لإنشاء أول مشروع.';

  @override
  String get newProject => 'مشروع جديد';

  @override
  String get projectNameLabel => 'اسم المشروع';

  @override
  String get projectNameHint => 'مثال: إطلاق Zettask';

  @override
  String get projectNameRequired => 'اسم المشروع مطلوب';

  @override
  String get projectColorLabel => 'لون المشروع';

  @override
  String get unplannedTitle => 'غير مجدولة';

  @override
  String activeCountLabel(int count) {
    return '$count نشطة';
  }

  @override
  String get noUnplannedTitle => 'لا توجد مهام غير مجدولة';

  @override
  String get noUnplannedSubtitle => 'اضغط + لتدوين مهمة بدون تاريخ.';

  @override
  String get addUnplannedTooltip => 'إضافة مهمة غير مجدولة';

  @override
  String get workspaceTitle => 'مساحة العمل';

  @override
  String get organizeSection => 'التنظيم';

  @override
  String get automationSection => 'الأتمتة';

  @override
  String get insightsSection => 'الإحصاءات والتخصيص';

  @override
  String get settingsInfoSection => 'الإعدادات والمعلومات';

  @override
  String get tagsTitle => 'الوسوم';

  @override
  String get tagsSubtitleEmpty => 'تصنيفات ملونة للمهام والملاحظات';

  @override
  String tagsCountSubtitle(int count) {
    return '$count وسوم محفوظة';
  }

  @override
  String get newTag => 'وسم جديد';

  @override
  String get editTag => 'تعديل الوسم';

  @override
  String get tagNameLabel => 'اسم الوسم';

  @override
  String get tagNameRequired => 'اسم الوسم مطلوب';

  @override
  String get tagDeleted => 'تم حذف الوسم';

  @override
  String get noTagsYet => 'لا توجد وسوم بعد';

  @override
  String tagTasksCount(int count) {
    return '$count مهام';
  }

  @override
  String get templatesTitle => 'القوالب';

  @override
  String get templatesSubtitleEmpty =>
      'احفظ هياكل المهام والقوائم القابلة لإعادة الاستخدام';

  @override
  String templatesCountSubtitle(int count) {
    return '$count قوالب جاهزة';
  }

  @override
  String get newTemplate => 'قالب جديد';

  @override
  String get editTemplate => 'تعديل القالب';

  @override
  String get templateNameLabel => 'اسم القالب';

  @override
  String get templateNameRequired => 'اسم القالب مطلوب';

  @override
  String get templateDeleted => 'تم حذف القالب';

  @override
  String get noTemplatesYet => 'لا توجد قوالب بعد';

  @override
  String get taskFromTemplateSaved => 'تم حفظ المهمة من القالب';

  @override
  String get notesTitle => 'الملاحظات';

  @override
  String get notesSubtitleEmpty => 'ملاحظات سريعة بدون تاريخ';

  @override
  String notesCountSubtitle(int count) {
    return '$count ملاحظات محفوظة';
  }

  @override
  String get newNote => 'ملاحظة جديدة';

  @override
  String get editNote => 'تعديل الملاحظة';

  @override
  String get noteTitleLabel => 'عنوان الملاحظة';

  @override
  String get noteTitleHint => 'مثال: ملخص الاجتماع';

  @override
  String get noteTitleRequired => 'عنوان الملاحظة مطلوب';

  @override
  String get noteContentLabel => 'محتوى الملاحظة';

  @override
  String get noteContentHint => 'اكتب ملاحظتك هنا...';

  @override
  String get noteDeleted => 'تم حذف الملاحظة';

  @override
  String get searchNotesHint => 'ابحث في الملاحظات...';

  @override
  String get noteNotFound => 'الملاحظة غير موجودة';

  @override
  String get noNotesYet => 'لا توجد ملاحظات بعد';

  @override
  String noteSearchEmpty(String query) {
    return 'لا توجد ملاحظة تطابق \"$query\".';
  }

  @override
  String get noNotesSubtitle => 'اضغط + لكتابة ملاحظة سريعة.';

  @override
  String get saveNote => 'حفظ الملاحظة';

  @override
  String get repeatingTasksTitle => 'المهام المتكررة';

  @override
  String get repeatingTasksSubtitleEmpty =>
      'إدارة الروتين اليومي والأسبوعي والشهري';

  @override
  String repeatingActiveCount(int count) {
    return '$count روتين نشط';
  }

  @override
  String get noRepeatingTasks => 'لا توجد مهام متكررة بعد';

  @override
  String get repeatingActionTitle => 'هذه مهمة متكررة';

  @override
  String get repeatingThisOnly => 'هذه المهمة فقط';

  @override
  String get repeatingThisAndFollowing => 'هذه المهمة وجميع المهام التالية';

  @override
  String get last7DaysUpper => 'آخر 7 أيام';

  @override
  String weeklySummary(int tasks, int checklists) {
    return '$tasks مهام، بالإضافة إلى $checklists عناصر قائمة';
  }

  @override
  String get statsTitle => 'الإحصاءات';

  @override
  String get range7Days => '7 أيام';

  @override
  String get range30Days => '30 يوماً';

  @override
  String get completedToday => 'أُنجز اليوم';

  @override
  String get last7DaysLabel => 'آخر 7 أيام';

  @override
  String get last30DaysLabel => 'آخر 30 يوماً';

  @override
  String get allTimeLabel => 'كل الأوقات';

  @override
  String get completionRateLabel => 'معدل الإنجاز';

  @override
  String get activity7Days => 'نشاط آخر 7 أيام';

  @override
  String get activity30Days => 'نشاط آخر 30 يوماً';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks مهام · $checklists عناصر';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return 'إجمالي $days يوماً: $tasks مهام و$checklists عناصر قائمة';
  }

  @override
  String get completedByPriority => 'المكتمل حسب الأولوية';

  @override
  String get progressByProject => 'التقدم حسب المشروع';

  @override
  String get breakdownByTag => 'التفصيل حسب الوسم';

  @override
  String get habits30Days => 'العادات · 30 يوماً';

  @override
  String get noProjectsCreated => 'لم يتم إنشاء مشاريع بعد.';

  @override
  String get noTagsCreated => 'لم يتم إنشاء وسوم بعد.';

  @override
  String get noActiveHabits => 'لا توجد عادات نشطة بعد.';

  @override
  String completedCountLabel(int count) {
    return '$count مكتمل';
  }

  @override
  String tagBreakdownTrailing(int done, int total) {
    return '$done/$total مكتمل';
  }

  @override
  String habitCompletedRatio(String summary, int done, int scheduled) {
    return '$summary · $done/$scheduled مكتمل';
  }

  @override
  String statsSubtitle(int completed, int percent) {
    return '$completed مكتمل · $percent% معدل الإنجاز';
  }

  @override
  String get themeTitle => 'المظهر';

  @override
  String get themeAndColorsTitle => 'المظهر والألوان';

  @override
  String get livePreviewSection => 'معاينة مباشرة';

  @override
  String get appearanceModeSection => 'وضع المظهر';

  @override
  String get colorPaletteSection => 'لوحة الألوان';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeSystemLight => 'النظام (فاتح)';

  @override
  String get themeSystemDark => 'النظام (داكن)';

  @override
  String get presetDefault => 'الافتراضي';

  @override
  String get presetDefaultDesc => 'نيلي وأردوازي';

  @override
  String get presetOcean => 'محيط';

  @override
  String get presetOceanDesc => 'أزرق هادئ';

  @override
  String get presetForest => 'غابة';

  @override
  String get presetForestDesc => 'أخضر زمردي';

  @override
  String get presetTerracotta => 'تيراكوتا';

  @override
  String get presetTerracottaDesc => 'برتقالي دافئ';

  @override
  String get presetPlum => 'برقوقي';

  @override
  String get presetPlumDesc => 'بنفسجي هادئ';

  @override
  String get presetMonochrome => 'أحادي اللون';

  @override
  String get presetMonochromeDesc => 'رمادي فحمي وأسود';

  @override
  String get previewActiveTask => 'مراجعة تصميم الواجهة';

  @override
  String get previewCompletedTask => 'مزامنة الجدول الأسبوعي';

  @override
  String get languageTitle => 'اللغة';

  @override
  String get deviceLanguageOption => 'لغة الجهاز (إن كانت مدعومة)';

  @override
  String get appLockTitle => 'قفل التطبيق';

  @override
  String get appLockSubtitle => 'البصمة أو الوجه أو رمز الجهاز';

  @override
  String get appLockLockedTitle => 'تطبيق Zettask مقفل';

  @override
  String get appLockLockedSubtitle =>
      'استخدم البصمة أو الوجه أو رمز PIN لفتح مهامك.';

  @override
  String get unlockButton => 'فتح القفل';

  @override
  String get verifyingButton => 'جاري التحقق...';

  @override
  String get appLockUnsupportedError =>
      'لم يتم تفعيل البصمة أو قفل الشاشة على هذا الجهاز.';

  @override
  String get appLockCancelledError => 'تم إلغاء التحقق أو فشل.';

  @override
  String get appLockUnlockFailedError =>
      'فشل التحقق. اضغط فتح القفل للمحاولة مجدداً.';

  @override
  String get calendarSyncTitle => 'مزامنة التقويم';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return 'مفعّلة · $count تقاويم';
  }

  @override
  String get calendarSyncInactiveSubtitle =>
      'معطلة · عرض أحداث الجهاز للقراءة فقط';

  @override
  String get grantCalendarPermission => 'منح إذن التقويم';

  @override
  String get exportCsvTitle => 'تصدير CSV';

  @override
  String get exportCsvSubtitle => 'مشاركة المهام أو الملاحظات كملفات CSV';

  @override
  String get exportDataCsvTitle => 'تصدير بيانات CSV';

  @override
  String get exportTasksTitle => 'تصدير المهام';

  @override
  String get exportTasksSubtitle =>
      'جميع المهام المجدولة وغير المجدولة والمشاريع';

  @override
  String get exportNotesTitle => 'تصدير الملاحظات';

  @override
  String get exportNotesSubtitle => 'جميع الملاحظات السريعة';

  @override
  String get exportBothTitle => 'تصدير الكل';

  @override
  String get exportBothSubtitle => 'ملفات CSV للمهام والملاحظات معاً';

  @override
  String get aboutPrivacyTitle => 'حول التطبيق والخصوصية';

  @override
  String aboutPrivacySubtitle(String version) {
    return 'الإصدار $version · محلي أولاً وسحابي اختياري';
  }

  @override
  String get aboutTitle => 'حول Zettask';

  @override
  String versionLabel(String version) {
    return 'الإصدار $version';
  }

  @override
  String get privacySyncTitle => 'الخصوصية والمزامنة';

  @override
  String get privacySyncDescription =>
      'تُحفظ بياناتك محلياً على جهازك افتراضياً. المزامنة السحابية عبر Firebase اختيارية عند تسجيل الدخول، ويمكنك حذف حسابك وبياناتك السحابية نهائياً في أي وقت.';

  @override
  String get privacyPolicyLabel => 'سياسة الخصوصية';

  @override
  String get privacyLinkCopied => 'تم نسخ رابط سياسة الخصوصية';

  @override
  String get accountAndSyncTitle => 'الحساب والمزامنة';

  @override
  String get signInToZettask => 'تسجيل الدخول إلى Zettask';

  @override
  String get accountBannerSubtitle =>
      'اختياري · النسخ الاحتياطي والمزامنة السحابية';

  @override
  String get authWelcomeTitle => 'احفظ تقدمك ومهامك';

  @override
  String get authWelcomeSubtitle =>
      'انسخ جداولك ومشاريعك وملاحظاتك تلقائياً إلى السحابة. يمكنك دائماً استخدام Zettask محلياً بدون حساب.';

  @override
  String get createNewAccount => 'إنشاء حساب جديد';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get continueWithGoogle => 'المتابعة باستخدام Google';

  @override
  String get authTermsNotice =>
      'بالمتابعة فإنك توافق على الشروط وسياسة الخصوصية لـ Zettask.';

  @override
  String get signInToAccountTitle => 'تسجيل الدخول إلى Zettask';

  @override
  String get signInToAccountSubtitle =>
      'سيتم دمج البيانات المحلية مع نسختك السحابية.';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get emailHint => 'name@email.com';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب.';

  @override
  String get emailInvalid => 'صيغة البريد الإلكتروني غير صحيحة.';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get passwordNewHint => '6 أحرف على الأقل';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة.';

  @override
  String get passwordTooShort => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل.';

  @override
  String get forgotPassword => 'نسيت؟';

  @override
  String get enterValidEmailFirst => 'أدخل بريداً إلكترونياً صالحاً أولاً.';

  @override
  String passwordResetSent(String email) {
    return 'تم إرسال رابط إعادة التعيين إلى $email.';
  }

  @override
  String get showPasswordTooltip => 'إظهار كلمة المرور';

  @override
  String get hidePasswordTooltip => 'إخفاء كلمة المرور';

  @override
  String get noAccountPrompt => 'ليس لديك حساب؟';

  @override
  String get createAccountLink => 'إنشاء حساب';

  @override
  String get createAccountTitle => 'إنشاء حساب';

  @override
  String get createAccountSubtitle =>
      'احتفظ بنسخة احتياطية من جميع مهامك وملاحظاتك في السحابة.';

  @override
  String get haveAccountPrompt => 'لديك حساب بالفعل؟';

  @override
  String signedInVia(String provider) {
    return 'تم الدخول عبر $provider';
  }

  @override
  String get syncNowButton => 'مزامنة الآن';

  @override
  String get syncingLabel => 'جاري المزامنة...';

  @override
  String get syncDoneMessage => 'اكتملت المزامنة.';

  @override
  String get syncFailedMessage => 'فشلت المزامنة. تحقق من اتصال الإنترنت.';

  @override
  String get syncStatusIdle => 'لم تتم المزامنة بعد';

  @override
  String get syncStatusSyncing => 'جاري المزامنة...';

  @override
  String get syncStatusSynced => 'متزامن';

  @override
  String get syncStatusError => 'فشل المزامنة';

  @override
  String lastSyncedPrefix(String time) {
    return 'آخر مزامنة: $time';
  }

  @override
  String get neverSynced => 'لم تتم المزامنة مطلقاً';

  @override
  String get signOutButton => 'تسجيل الخروج';

  @override
  String get signedOutMessage =>
      'تم تسجيل الخروج. تبقى بياناتك المحلية محفوظة على جهازك.';

  @override
  String get deleteAccountButton => 'حذف الحساب';

  @override
  String get deleteAccountStep1Title => 'حذف الحساب؟';

  @override
  String get deleteAccountStep1Body =>
      'سيتم حذف جميع بياناتك السحابية وحسابك نهائياً. تبقى البيانات المحلية على جهازك دون تغيير.';

  @override
  String get deleteAccountStep2Title => 'تأكيد الحذف النهائي';

  @override
  String get deleteAccountStep2Body =>
      'لا يمكن التراجع عن هذا الإجراء. هل أنت متأكد من حذف الحساب وجميع البيانات السحابية الآن؟';

  @override
  String get deleteAccountConfirmButton => 'نعم، احذف نهائياً';

  @override
  String get accountDeletedMessage =>
      'تم حذف الحساب وجميع البيانات السحابية نهائياً.';

  @override
  String get reloginRequiredTitle => 'يلزم إعادة تسجيل الدخول';

  @override
  String get authErrUserNotFound => 'لا يوجد حساب مسجل بهذا البريد الإلكتروني.';

  @override
  String get authErrWrongPassword => 'كلمة المرور غير صحيحة.';

  @override
  String get authErrInvalidCredential =>
      'البريد الإلكتروني أو كلمة المرور غير صالحة.';

  @override
  String get authErrInvalidEmail => 'صيغة البريد الإلكتروني غير صحيحة.';

  @override
  String get authErrEmailInUse => 'هذا البريد الإلكتروني مستخدم في حساب آخر.';

  @override
  String get authErrWeakPassword =>
      'كلمة المرور ضعيفة. استخدم 6 أحرف على الأقل.';

  @override
  String get authErrNetwork => 'مشكلة في الاتصال. تحقق من شبكة الإنترنت.';

  @override
  String get authErrRequiresRecentLogin =>
      'لأسباب أمنية، سجل الخروج ثم أعد الدخول قبل حذف الحساب.';

  @override
  String get authErrTooManyRequests => 'محاولات كثيرة جداً. حاول لاحقاً.';

  @override
  String get authErrUserDisabled => 'تم تعطيل هذا الحساب.';

  @override
  String get authErrAccountExistsDifferent =>
      'هذا البريد مرتبط بطريقة تسجيل دخول أخرى.';

  @override
  String get authErrOperationNotAllowed => 'طريقة تسجيل الدخول هذه غير مفعلة.';

  @override
  String get authErrFirebaseUnavailable => 'خدمة الحساب غير متوفرة حالياً.';

  @override
  String get authErrUnknown => 'حدث خطأ أثناء المصادقة. حاول مجدداً.';

  @override
  String get widgetTitle => 'Zettask · اليوم';

  @override
  String get widgetEmptyText => 'اكتملت جميع مهام اليوم.';

  @override
  String get repeatingTasksAndFollowingDeleted =>
      'تم حذف المهمة المتكررة والمواعيد التالية';

  @override
  String get noProjectTasksTitle => 'لا توجد مهام في هذا المشروع بعد';

  @override
  String noProjectTasksSubtitle(String project) {
    return 'اضغط + لإضافة مهمة إلى $project.';
  }

  @override
  String get addTaskToProjectTooltip => 'إضافة مهمة للمشروع';

  @override
  String get noTagsSubtitle => 'اضغط + لإنشاء وسوم ملونة للمهام والملاحظات.';

  @override
  String get tagOptionsTooltip => 'خيارات الوسم';

  @override
  String get deleteTag => 'حذف الوسم';

  @override
  String get addTagTooltip => 'إضافة وسم';

  @override
  String get noTasksWithTag => 'لا توجد مهام بهذا الوسم بعد.';

  @override
  String get addTaskWithTagTooltip => 'إضافة مهمة بوسم';

  @override
  String get tagNameHint => 'مثال: عمل، شخصي، عاجل';

  @override
  String get tagColorLabel => 'لون الوسم';

  @override
  String get createTag => 'إنشاء وسم';

  @override
  String tagDeletedNamed(String name) {
    return 'تم حذف الوسم \"$name\"';
  }

  @override
  String get noTemplatesSubtitle =>
      'احفظ هياكل المهام والقوائم المتكررة لإنشائها بشكل أسرع.';

  @override
  String get templateOptionsTooltip => 'خيارات القالب';

  @override
  String get deleteTemplate => 'حذف القالب';

  @override
  String get createTemplateTooltip => 'إنشاء قالب';

  @override
  String templateDeletedNamed(String name) {
    return 'تم حذف القالب \"$name\"';
  }

  @override
  String get templateNameHint => 'مثال: إصدار أسبوعي';

  @override
  String get defaultTaskTitleLabel => 'عنوان المهمة الافتراضي';

  @override
  String get defaultTaskTitleHint => 'مثال: تجهيز إصدار الإنتاج';

  @override
  String get timeOptionalLabel => 'الوقت (اختياري)';

  @override
  String get clearTimeTooltip => 'مسح الوقت';

  @override
  String get projectOptionalLabel => 'المشروع (اختياري)';

  @override
  String get tagOptionalLabel => 'الوسم (اختياري)';

  @override
  String get defaultSubtasksLabel => 'المهام الفرعية الافتراضية';

  @override
  String get addTemplateSubtaskHint => 'أضف مهمة فرعية للقالب...';

  @override
  String get saveTemplate => 'حفظ القالب';

  @override
  String subtasksTotalCount(int count) {
    return '$count مهام فرعية';
  }

  @override
  String get useTemplateButton => 'استخدام قالب';

  @override
  String get pickTemplateTitle => 'اختر قالباً';

  @override
  String get repeatingTaskDeleted => 'تم حذف المهمة المتكررة';

  @override
  String get noRepeatingTasksSubtitle =>
      'اضغط + لإنشاء روتين يومي أو أسبوعي أو شهري.';

  @override
  String get addRepeatingTaskTooltip => 'إضافة مهمة متكررة';

  @override
  String get editRepeatingTask => 'تعديل مهمة متكررة';

  @override
  String get newRepeatingTask => 'مهمة متكررة جديدة';

  @override
  String get deleteTaskTooltip => 'حذف المهمة';

  @override
  String get scheduleLabel => 'الجدول';

  @override
  String get startAndTimeLabel => 'البداية والوقت';

  @override
  String get dateRequiredForTime => 'يلزم تاريخ';

  @override
  String get clearDateTooltip => 'مسح التاريخ';

  @override
  String get pickTimeFirstReminder => 'اختر وقتاً أولاً لتفعيل التذكيرات.';

  @override
  String get notificationPermissionDenied =>
      'إذن الإشعارات غير مفعّل. فعّله من إعدادات الجهاز لظهور التذكيرات.';

  @override
  String get pickDateFirstRepeat => 'اختر تاريخاً أولاً لضبط التكرار.';

  @override
  String get subtasksLabel => 'المهام الفرعية';

  @override
  String subtasksWithCount(int count) {
    return 'المهام الفرعية ($count)';
  }

  @override
  String get removeSubtaskTooltip => 'حذف المهمة الفرعية';

  @override
  String get addSubtaskTooltip => 'إضافة مهمة فرعية';

  @override
  String get moveAllOverdueMoved => 'تم نقل جميع المهام المتأخرة إلى اليوم';

  @override
  String get moveAllShort => 'نقل الكل';

  @override
  String get noOverdueTasksSubtitle => 'جميع المهام من الأيام السابقة مكتملة.';

  @override
  String get repeatingDeletePrompt => 'ماذا تريد أن تحذف؟';

  @override
  String get repeatingEditPrompt => 'ماذا تريد أن تعدّل؟';

  @override
  String get repeatingDeleteSingleSub => 'حذف هذا الموعد فقط';

  @override
  String get repeatingEditSingleSub => 'تعديل هذا الموعد فقط';

  @override
  String get repeatingDeleteFollowingSub =>
      'حذف هذا الموعد وجميع المواعيد القادمة';

  @override
  String get repeatingEditFollowingSub =>
      'تطبيق على هذا الموعد وجميع المواعيد القادمة';

  @override
  String get deviceCalendarTitle => 'تقويم الجهاز';

  @override
  String get selectCalendarsLabel => 'اختر التقاويم';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '$selected/$total نشط';
  }

  @override
  String get showCalendarEventsTitle => 'عرض أحداث التقويم';

  @override
  String get showCalendarEventsSubtitle =>
      'تظهر أحداث الجهاز بترتيب زمني للقراءة فقط.';

  @override
  String get calendarPermDeniedPermanentTitle => 'تم رفض إذن التقويم نهائياً';

  @override
  String get calendarPermRequiredTitle => 'مطلوب إذن قراءة التقويم';

  @override
  String get calendarPermDeniedPermanentDesc =>
      'فعّل إذن قراءة التقويم من إعدادات الجهاز، ثم اضغط فحص مجدداً.';

  @override
  String get calendarPermRequiredDesc =>
      'يطلب Zettask إذن القراءة فقط لعرض أحداثك في الجدول الزمني.';

  @override
  String get openSettingsButton => 'فتح الإعدادات';

  @override
  String get checkAgainButton => 'فحص مجدداً';

  @override
  String get noCalendarsFound => 'لم يتم العثور على تقاويم في هذا الجهاز.';

  @override
  String get eventDetailTitle => 'تفاصيل الحدث';

  @override
  String get eventNotesLabel => 'ملاحظات';

  @override
  String get calendarEventReadOnlyBanner =>
      'حدث من تقويم الجهاز (للقراءة فقط).';

  @override
  String get markUncompletedSemantics => 'تحديد كغير مكتملة';

  @override
  String get markCompletedSemantics => 'تحديد كمكتملة';

  @override
  String get deleteNoteTooltip => 'حذف الملاحظة';

  @override
  String repeatMonthlyDay(int day) {
    return 'كل شهر · يوم $day';
  }

  @override
  String get last30DaysSubtitle => 'آخر 30 يوماً';

  @override
  String get allTimeSubtitle => 'كل الوقت';

  @override
  String get taskCancelled => 'تم تحديد المهمة كملغاة';

  @override
  String get taskRestored => 'تمت إعادة تفعيل المهمة';

  @override
  String get cancelledStatusLabel => 'ملغاة';

  @override
  String get restoreTaskLabel => 'استعادة';

  @override
  String get markCancelledSemantics => 'تحديد كملغاة';

  @override
  String get calendarPermFallbackHint =>
      'إذا لم تظهر نافذة الإذن، افتح إعدادات التطبيق لتفعيل إذن التقويم يدوياً.';

  @override
  String get calendarBadgeLabel => 'التقويم';

  @override
  String get calendarSourceLabel => 'التقويم';

  @override
  String get calendarLocationLabel => 'الموقع';

  @override
  String get calendarReadOnlyInfo =>
      'تمت المزامنة من تقويم الجهاز. هذا العنصر للقراءة فقط ولا يمكن تعديله في Zettask.';
}
