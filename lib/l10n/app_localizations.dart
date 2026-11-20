import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_he.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('he'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ru'),
    Locale('uk'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Zettask'**
  String get appName;

  /// No description provided for @navTimeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get navTimeline;

  /// No description provided for @navBoard.
  ///
  /// In en, this message translates to:
  /// **'Board'**
  String get navBoard;

  /// No description provided for @navUnplanned.
  ///
  /// In en, this message translates to:
  /// **'Unplanned'**
  String get navUnplanned;

  /// No description provided for @navMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMore;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get retry;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @understand.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get understand;

  /// No description provided for @useAction.
  ///
  /// In en, this message translates to:
  /// **'Use'**
  String get useAction;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @toDo.
  ///
  /// In en, this message translates to:
  /// **'To Do'**
  String get toDo;

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// No description provided for @unplanned.
  ///
  /// In en, this message translates to:
  /// **'Unplanned'**
  String get unplanned;

  /// No description provided for @allDay.
  ///
  /// In en, this message translates to:
  /// **'All Day'**
  String get allDay;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @addTaskToday.
  ///
  /// In en, this message translates to:
  /// **'Add task for today'**
  String get addTaskToday;

  /// No description provided for @addTask.
  ///
  /// In en, this message translates to:
  /// **'Add task'**
  String get addTask;

  /// No description provided for @noTasksForDate.
  ///
  /// In en, this message translates to:
  /// **'No tasks for this date.'**
  String get noTasksForDate;

  /// No description provided for @savedToUnplanned.
  ///
  /// In en, this message translates to:
  /// **'Saved to Unplanned'**
  String get savedToUnplanned;

  /// No description provided for @savedToUnplannedNoDate.
  ///
  /// In en, this message translates to:
  /// **'Saved to Unplanned (no date)'**
  String get savedToUnplannedNoDate;

  /// No description provided for @scheduledForDate.
  ///
  /// In en, this message translates to:
  /// **'Scheduled for {date}'**
  String scheduledForDate(String date);

  /// No description provided for @taskScheduledForDate.
  ///
  /// In en, this message translates to:
  /// **'Task scheduled for {date}'**
  String taskScheduledForDate(String date);

  /// No description provided for @taskDeleted.
  ///
  /// In en, this message translates to:
  /// **'Task deleted'**
  String get taskDeleted;

  /// No description provided for @searchTasksTooltip.
  ///
  /// In en, this message translates to:
  /// **'Search tasks'**
  String get searchTasksTooltip;

  /// No description provided for @timelineOptionsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Timeline options'**
  String get timelineOptionsTooltip;

  /// No description provided for @addTaskTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTaskTooltip;

  /// No description provided for @completedLabel.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get completedLabel;

  /// No description provided for @uncompleteLabel.
  ///
  /// In en, this message translates to:
  /// **'Mark active'**
  String get uncompleteLabel;

  /// No description provided for @subtasksCount.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} subtasks'**
  String subtasksCount(int done, int total);

  /// No description provided for @repeatingTaskLabel.
  ///
  /// In en, this message translates to:
  /// **'Repeating task'**
  String get repeatingTaskLabel;

  /// No description provided for @quickAddHint.
  ///
  /// In en, this message translates to:
  /// **'Add a new task...'**
  String get quickAddHint;

  /// No description provided for @expandTooltip.
  ///
  /// In en, this message translates to:
  /// **'Expand'**
  String get expandTooltip;

  /// No description provided for @saveTaskTooltip.
  ///
  /// In en, this message translates to:
  /// **'Save task'**
  String get saveTaskTooltip;

  /// No description provided for @newTask.
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get newTask;

  /// No description provided for @editTask.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get editTask;

  /// No description provided for @taskTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Task title'**
  String get taskTitleLabel;

  /// No description provided for @taskTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Review sprint notes'**
  String get taskTitleHint;

  /// No description provided for @taskTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Task title is required'**
  String get taskTitleRequired;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Add notes or context...'**
  String get descriptionHint;

  /// No description provided for @pickDate.
  ///
  /// In en, this message translates to:
  /// **'Pick Date'**
  String get pickDate;

  /// No description provided for @pickOnCalendar.
  ///
  /// In en, this message translates to:
  /// **'Pick on calendar...'**
  String get pickOnCalendar;

  /// No description provided for @noDateUnplanned.
  ///
  /// In en, this message translates to:
  /// **'No date (Unplanned)'**
  String get noDateUnplanned;

  /// No description provided for @noDate.
  ///
  /// In en, this message translates to:
  /// **'No date'**
  String get noDate;

  /// No description provided for @taskTime.
  ///
  /// In en, this message translates to:
  /// **'Task Time'**
  String get taskTime;

  /// No description provided for @changeTime.
  ///
  /// In en, this message translates to:
  /// **'Change time'**
  String get changeTime;

  /// No description provided for @clearTimeAllDay.
  ///
  /// In en, this message translates to:
  /// **'Clear time (All Day)'**
  String get clearTimeAllDay;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeLabel;

  /// No description provided for @reminderLabel.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get reminderLabel;

  /// No description provided for @noReminder.
  ///
  /// In en, this message translates to:
  /// **'No reminder'**
  String get noReminder;

  /// No description provided for @atTime.
  ///
  /// In en, this message translates to:
  /// **'On time'**
  String get atTime;

  /// No description provided for @minutesBefore10.
  ///
  /// In en, this message translates to:
  /// **'10 min before'**
  String get minutesBefore10;

  /// No description provided for @minutesBefore30.
  ///
  /// In en, this message translates to:
  /// **'30 min before'**
  String get minutesBefore30;

  /// No description provided for @hourBefore1.
  ///
  /// In en, this message translates to:
  /// **'1 hour before'**
  String get hourBefore1;

  /// No description provided for @reminderShort10m.
  ///
  /// In en, this message translates to:
  /// **'10m'**
  String get reminderShort10m;

  /// No description provided for @reminderShort30m.
  ///
  /// In en, this message translates to:
  /// **'30m'**
  String get reminderShort30m;

  /// No description provided for @reminderShort1h.
  ///
  /// In en, this message translates to:
  /// **'1h'**
  String get reminderShort1h;

  /// No description provided for @projectLabel.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get projectLabel;

  /// No description provided for @noProject.
  ///
  /// In en, this message translates to:
  /// **'No project'**
  String get noProject;

  /// No description provided for @tagLabel.
  ///
  /// In en, this message translates to:
  /// **'Tag'**
  String get tagLabel;

  /// No description provided for @noTag.
  ///
  /// In en, this message translates to:
  /// **'No tag'**
  String get noTag;

  /// No description provided for @priorityLabel.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priorityLabel;

  /// No description provided for @priorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get priorityLow;

  /// No description provided for @priorityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get priorityMedium;

  /// No description provided for @priorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get priorityHigh;

  /// No description provided for @saveTask.
  ///
  /// In en, this message translates to:
  /// **'Save Task'**
  String get saveTask;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @checklistLabel.
  ///
  /// In en, this message translates to:
  /// **'Checklist'**
  String get checklistLabel;

  /// No description provided for @addChecklistHint.
  ///
  /// In en, this message translates to:
  /// **'Add checklist item...'**
  String get addChecklistHint;

  /// No description provided for @repeatLabel.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get repeatLabel;

  /// No description provided for @noRepeat.
  ///
  /// In en, this message translates to:
  /// **'Does not repeat'**
  String get noRepeat;

  /// No description provided for @repeatDaily.
  ///
  /// In en, this message translates to:
  /// **'Every day'**
  String get repeatDaily;

  /// No description provided for @repeatWeekly.
  ///
  /// In en, this message translates to:
  /// **'Every week'**
  String get repeatWeekly;

  /// No description provided for @repeatMonthly.
  ///
  /// In en, this message translates to:
  /// **'Every month'**
  String get repeatMonthly;

  /// No description provided for @colorLabel.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get colorLabel;

  /// No description provided for @timelineOptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Timeline Options'**
  String get timelineOptionsTitle;

  /// No description provided for @viewModeLabel.
  ///
  /// In en, this message translates to:
  /// **'View Mode'**
  String get viewModeLabel;

  /// No description provided for @modeTimeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline Mode'**
  String get modeTimeline;

  /// No description provided for @modeDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily Mode'**
  String get modeDaily;

  /// No description provided for @firstDayOfWeek.
  ///
  /// In en, this message translates to:
  /// **'Start of Week'**
  String get firstDayOfWeek;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @firstDayMondayOrder.
  ///
  /// In en, this message translates to:
  /// **'Mon · Tue · Wed · Thu · Fri · Sat · Sun'**
  String get firstDayMondayOrder;

  /// No description provided for @firstDaySundayOrder.
  ///
  /// In en, this message translates to:
  /// **'Sun · Mon · Tue · Wed · Thu · Fri · Sat'**
  String get firstDaySundayOrder;

  /// No description provided for @showCompletedTasks.
  ///
  /// In en, this message translates to:
  /// **'Show completed tasks'**
  String get showCompletedTasks;

  /// No description provided for @showCompletedTasksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hide checked tasks to stay focused on active ones.'**
  String get showCompletedTasksSubtitle;

  /// No description provided for @showCompletedWorkspaceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show or hide completed tasks.'**
  String get showCompletedWorkspaceSubtitle;

  /// No description provided for @overdueTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Overdue Tasks'**
  String get overdueTasksTitle;

  /// No description provided for @noOverdueTasks.
  ///
  /// In en, this message translates to:
  /// **'No overdue tasks'**
  String get noOverdueTasks;

  /// No description provided for @moveToToday.
  ///
  /// In en, this message translates to:
  /// **'Move to Today'**
  String get moveToToday;

  /// No description provided for @moveAllToToday.
  ///
  /// In en, this message translates to:
  /// **'Move all to Today'**
  String get moveAllToToday;

  /// No description provided for @searchTasksHint.
  ///
  /// In en, this message translates to:
  /// **'Search tasks...'**
  String get searchTasksHint;

  /// No description provided for @searchTasksEmpty.
  ///
  /// In en, this message translates to:
  /// **'Type to search tasks, descriptions, or checklists.'**
  String get searchTasksEmpty;

  /// No description provided for @searchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No tasks match \"{query}\".'**
  String searchNoResults(String query);

  /// No description provided for @calendarEventReadOnly.
  ///
  /// In en, this message translates to:
  /// **'Calendar event · read-only'**
  String get calendarEventReadOnly;

  /// No description provided for @prevWeekTooltip.
  ///
  /// In en, this message translates to:
  /// **'Previous week'**
  String get prevWeekTooltip;

  /// No description provided for @nextWeekTooltip.
  ///
  /// In en, this message translates to:
  /// **'Next week'**
  String get nextWeekTooltip;

  /// No description provided for @boardTitle.
  ///
  /// In en, this message translates to:
  /// **'Board'**
  String get boardTitle;

  /// No description provided for @allProjects.
  ///
  /// In en, this message translates to:
  /// **'All Projects'**
  String get allProjects;

  /// No description provided for @searchProjectHint.
  ///
  /// In en, this message translates to:
  /// **'Search project name...'**
  String get searchProjectHint;

  /// No description provided for @searchProjectTooltip.
  ///
  /// In en, this message translates to:
  /// **'Search projects'**
  String get searchProjectTooltip;

  /// No description provided for @closeSearchTooltip.
  ///
  /// In en, this message translates to:
  /// **'Close search'**
  String get closeSearchTooltip;

  /// No description provided for @createProject.
  ///
  /// In en, this message translates to:
  /// **'Create Project'**
  String get createProject;

  /// No description provided for @editProject.
  ///
  /// In en, this message translates to:
  /// **'Edit project'**
  String get editProject;

  /// No description provided for @deleteProject.
  ///
  /// In en, this message translates to:
  /// **'Delete project'**
  String get deleteProject;

  /// No description provided for @projectOptionsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Project options'**
  String get projectOptionsTooltip;

  /// No description provided for @projectDeleted.
  ///
  /// In en, this message translates to:
  /// **'Project \"{name}\" deleted'**
  String projectDeleted(String name);

  /// No description provided for @projectsCompletedRatio.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} done'**
  String projectsCompletedRatio(int done, int total);

  /// No description provided for @projectTasksCompletedRatio.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} tasks done'**
  String projectTasksCompletedRatio(int done, int total);

  /// No description provided for @projectNotFound.
  ///
  /// In en, this message translates to:
  /// **'Project not found'**
  String get projectNotFound;

  /// No description provided for @noProjectsYet.
  ///
  /// In en, this message translates to:
  /// **'No projects yet'**
  String get noProjectsYet;

  /// No description provided for @projectSearchEmpty.
  ///
  /// In en, this message translates to:
  /// **'No project matches \"{query}\".'**
  String projectSearchEmpty(String query);

  /// No description provided for @noProjectsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap the folder button below to create your first project.'**
  String get noProjectsSubtitle;

  /// No description provided for @newProject.
  ///
  /// In en, this message translates to:
  /// **'New Project'**
  String get newProject;

  /// No description provided for @projectNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Project name'**
  String get projectNameLabel;

  /// No description provided for @projectNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Zettask Launch'**
  String get projectNameHint;

  /// No description provided for @projectNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Project name is required'**
  String get projectNameRequired;

  /// No description provided for @projectColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Project Color'**
  String get projectColorLabel;

  /// No description provided for @unplannedTitle.
  ///
  /// In en, this message translates to:
  /// **'Unplanned'**
  String get unplannedTitle;

  /// No description provided for @activeCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} active'**
  String activeCountLabel(int count);

  /// No description provided for @noUnplannedTitle.
  ///
  /// In en, this message translates to:
  /// **'No unplanned tasks yet'**
  String get noUnplannedTitle;

  /// No description provided for @noUnplannedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap + to capture tasks without a date.'**
  String get noUnplannedSubtitle;

  /// No description provided for @addUnplannedTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add Unplanned Task'**
  String get addUnplannedTooltip;

  /// No description provided for @workspaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Workspace'**
  String get workspaceTitle;

  /// No description provided for @organizeSection.
  ///
  /// In en, this message translates to:
  /// **'Organize'**
  String get organizeSection;

  /// No description provided for @automationSection.
  ///
  /// In en, this message translates to:
  /// **'Automation'**
  String get automationSection;

  /// No description provided for @insightsSection.
  ///
  /// In en, this message translates to:
  /// **'Insights & Personalization'**
  String get insightsSection;

  /// No description provided for @settingsInfoSection.
  ///
  /// In en, this message translates to:
  /// **'Settings & Info'**
  String get settingsInfoSection;

  /// No description provided for @tagsTitle.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tagsTitle;

  /// No description provided for @tagsSubtitleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Color labels for tasks and notes'**
  String get tagsSubtitleEmpty;

  /// No description provided for @tagsCountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count} tags saved'**
  String tagsCountSubtitle(int count);

  /// No description provided for @newTag.
  ///
  /// In en, this message translates to:
  /// **'New Tag'**
  String get newTag;

  /// No description provided for @editTag.
  ///
  /// In en, this message translates to:
  /// **'Edit Tag'**
  String get editTag;

  /// No description provided for @tagNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Tag name'**
  String get tagNameLabel;

  /// No description provided for @tagNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Tag name is required'**
  String get tagNameRequired;

  /// No description provided for @tagDeleted.
  ///
  /// In en, this message translates to:
  /// **'Tag deleted'**
  String get tagDeleted;

  /// No description provided for @noTagsYet.
  ///
  /// In en, this message translates to:
  /// **'No tags yet'**
  String get noTagsYet;

  /// No description provided for @tagTasksCount.
  ///
  /// In en, this message translates to:
  /// **'{count} tasks'**
  String tagTasksCount(int count);

  /// No description provided for @templatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Templates'**
  String get templatesTitle;

  /// No description provided for @templatesSubtitleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Save reusable task and checklist structures'**
  String get templatesSubtitleEmpty;

  /// No description provided for @templatesCountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count} templates ready'**
  String templatesCountSubtitle(int count);

  /// No description provided for @newTemplate.
  ///
  /// In en, this message translates to:
  /// **'New Template'**
  String get newTemplate;

  /// No description provided for @editTemplate.
  ///
  /// In en, this message translates to:
  /// **'Edit Template'**
  String get editTemplate;

  /// No description provided for @templateNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Template name'**
  String get templateNameLabel;

  /// No description provided for @templateNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Template name is required'**
  String get templateNameRequired;

  /// No description provided for @templateDeleted.
  ///
  /// In en, this message translates to:
  /// **'Template deleted'**
  String get templateDeleted;

  /// No description provided for @noTemplatesYet.
  ///
  /// In en, this message translates to:
  /// **'No templates yet'**
  String get noTemplatesYet;

  /// No description provided for @taskFromTemplateSaved.
  ///
  /// In en, this message translates to:
  /// **'Task from template saved'**
  String get taskFromTemplateSaved;

  /// No description provided for @notesTitle.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notesTitle;

  /// No description provided for @notesSubtitleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Quick undated notes'**
  String get notesSubtitleEmpty;

  /// No description provided for @notesCountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count} notes saved'**
  String notesCountSubtitle(int count);

  /// No description provided for @newNote.
  ///
  /// In en, this message translates to:
  /// **'New Note'**
  String get newNote;

  /// No description provided for @editNote.
  ///
  /// In en, this message translates to:
  /// **'Edit Note'**
  String get editNote;

  /// No description provided for @noteTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Note title'**
  String get noteTitleLabel;

  /// No description provided for @noteTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Meeting summary'**
  String get noteTitleHint;

  /// No description provided for @noteTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Note title is required'**
  String get noteTitleRequired;

  /// No description provided for @noteContentLabel.
  ///
  /// In en, this message translates to:
  /// **'Note content'**
  String get noteContentLabel;

  /// No description provided for @noteContentHint.
  ///
  /// In en, this message translates to:
  /// **'Write your note here...'**
  String get noteContentHint;

  /// No description provided for @noteDeleted.
  ///
  /// In en, this message translates to:
  /// **'Note deleted'**
  String get noteDeleted;

  /// No description provided for @searchNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Search notes...'**
  String get searchNotesHint;

  /// No description provided for @noteNotFound.
  ///
  /// In en, this message translates to:
  /// **'Note not found'**
  String get noteNotFound;

  /// No description provided for @noNotesYet.
  ///
  /// In en, this message translates to:
  /// **'No notes yet'**
  String get noNotesYet;

  /// No description provided for @noteSearchEmpty.
  ///
  /// In en, this message translates to:
  /// **'No note matches \"{query}\".'**
  String noteSearchEmpty(String query);

  /// No description provided for @noNotesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap + to jot down an undated note.'**
  String get noNotesSubtitle;

  /// No description provided for @saveNote.
  ///
  /// In en, this message translates to:
  /// **'Save Note'**
  String get saveNote;

  /// No description provided for @repeatingTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Repeating Tasks'**
  String get repeatingTasksTitle;

  /// No description provided for @repeatingTasksSubtitleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Manage daily, weekly, and monthly routines'**
  String get repeatingTasksSubtitleEmpty;

  /// No description provided for @repeatingActiveCount.
  ///
  /// In en, this message translates to:
  /// **'{count} active routines'**
  String repeatingActiveCount(int count);

  /// No description provided for @noRepeatingTasks.
  ///
  /// In en, this message translates to:
  /// **'No repeating tasks yet'**
  String get noRepeatingTasks;

  /// No description provided for @repeatingActionTitle.
  ///
  /// In en, this message translates to:
  /// **'This is a repeating task'**
  String get repeatingActionTitle;

  /// No description provided for @repeatingThisOnly.
  ///
  /// In en, this message translates to:
  /// **'Only this task'**
  String get repeatingThisOnly;

  /// No description provided for @repeatingThisAndFollowing.
  ///
  /// In en, this message translates to:
  /// **'This and all following tasks'**
  String get repeatingThisAndFollowing;

  /// No description provided for @last7DaysUpper.
  ///
  /// In en, this message translates to:
  /// **'LAST 7 DAYS'**
  String get last7DaysUpper;

  /// No description provided for @weeklySummary.
  ///
  /// In en, this message translates to:
  /// **'{tasks} tasks, plus {checklists} checklist items'**
  String weeklySummary(int tasks, int checklists);

  /// No description provided for @statsTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statsTitle;

  /// No description provided for @range7Days.
  ///
  /// In en, this message translates to:
  /// **'7 Days'**
  String get range7Days;

  /// No description provided for @range30Days.
  ///
  /// In en, this message translates to:
  /// **'30 Days'**
  String get range30Days;

  /// No description provided for @completedToday.
  ///
  /// In en, this message translates to:
  /// **'Done Today'**
  String get completedToday;

  /// No description provided for @last7DaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Last 7 Days'**
  String get last7DaysLabel;

  /// No description provided for @last30DaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Last 30 Days'**
  String get last30DaysLabel;

  /// No description provided for @allTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get allTimeLabel;

  /// No description provided for @completionRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Completion Rate'**
  String get completionRateLabel;

  /// No description provided for @activity7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 Days Activity'**
  String get activity7Days;

  /// No description provided for @activity30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 Days Activity'**
  String get activity30Days;

  /// No description provided for @dayDetailSummary.
  ///
  /// In en, this message translates to:
  /// **'{tasks} tasks · {checklists} checklists'**
  String dayDetailSummary(int tasks, int checklists);

  /// No description provided for @totalRangeSummary.
  ///
  /// In en, this message translates to:
  /// **'Total {days} days: {tasks} tasks, plus {checklists} checklist items'**
  String totalRangeSummary(int days, int tasks, int checklists);

  /// No description provided for @completedByPriority.
  ///
  /// In en, this message translates to:
  /// **'Completed by Priority'**
  String get completedByPriority;

  /// No description provided for @progressByProject.
  ///
  /// In en, this message translates to:
  /// **'Progress by Project'**
  String get progressByProject;

  /// No description provided for @breakdownByTag.
  ///
  /// In en, this message translates to:
  /// **'Breakdown by Tag'**
  String get breakdownByTag;

  /// No description provided for @habits30Days.
  ///
  /// In en, this message translates to:
  /// **'Habits · 30 Days'**
  String get habits30Days;

  /// No description provided for @noProjectsCreated.
  ///
  /// In en, this message translates to:
  /// **'No projects created yet.'**
  String get noProjectsCreated;

  /// No description provided for @noTagsCreated.
  ///
  /// In en, this message translates to:
  /// **'No tags created yet.'**
  String get noTagsCreated;

  /// No description provided for @noActiveHabits.
  ///
  /// In en, this message translates to:
  /// **'No active routines yet.'**
  String get noActiveHabits;

  /// No description provided for @completedCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} done'**
  String completedCountLabel(int count);

  /// No description provided for @tagBreakdownTrailing.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} done'**
  String tagBreakdownTrailing(int done, int total);

  /// No description provided for @habitCompletedRatio.
  ///
  /// In en, this message translates to:
  /// **'{summary} · {done}/{scheduled} done'**
  String habitCompletedRatio(String summary, int done, int scheduled);

  /// No description provided for @statsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{completed} completed · {percent}% completion rate'**
  String statsSubtitle(int completed, int percent);

  /// No description provided for @themeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeTitle;

  /// No description provided for @themeAndColorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme & Colors'**
  String get themeAndColorsTitle;

  /// No description provided for @livePreviewSection.
  ///
  /// In en, this message translates to:
  /// **'Live Preview'**
  String get livePreviewSection;

  /// No description provided for @appearanceModeSection.
  ///
  /// In en, this message translates to:
  /// **'Appearance Mode'**
  String get appearanceModeSection;

  /// No description provided for @colorPaletteSection.
  ///
  /// In en, this message translates to:
  /// **'Color Palette'**
  String get colorPaletteSection;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeSystemLight.
  ///
  /// In en, this message translates to:
  /// **'System (Light)'**
  String get themeSystemLight;

  /// No description provided for @themeSystemDark.
  ///
  /// In en, this message translates to:
  /// **'System (Dark)'**
  String get themeSystemDark;

  /// No description provided for @presetDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get presetDefault;

  /// No description provided for @presetDefaultDesc.
  ///
  /// In en, this message translates to:
  /// **'Indigo & slate'**
  String get presetDefaultDesc;

  /// No description provided for @presetOcean.
  ///
  /// In en, this message translates to:
  /// **'Ocean'**
  String get presetOcean;

  /// No description provided for @presetOceanDesc.
  ///
  /// In en, this message translates to:
  /// **'Calm blue'**
  String get presetOceanDesc;

  /// No description provided for @presetForest.
  ///
  /// In en, this message translates to:
  /// **'Forest'**
  String get presetForest;

  /// No description provided for @presetForestDesc.
  ///
  /// In en, this message translates to:
  /// **'Sage & emerald'**
  String get presetForestDesc;

  /// No description provided for @presetTerracotta.
  ///
  /// In en, this message translates to:
  /// **'Terracotta'**
  String get presetTerracotta;

  /// No description provided for @presetTerracottaDesc.
  ///
  /// In en, this message translates to:
  /// **'Warm clay orange'**
  String get presetTerracottaDesc;

  /// No description provided for @presetPlum.
  ///
  /// In en, this message translates to:
  /// **'Plum'**
  String get presetPlum;

  /// No description provided for @presetPlumDesc.
  ///
  /// In en, this message translates to:
  /// **'Muted purple'**
  String get presetPlumDesc;

  /// No description provided for @presetMonochrome.
  ///
  /// In en, this message translates to:
  /// **'Monochrome'**
  String get presetMonochrome;

  /// No description provided for @presetMonochromeDesc.
  ///
  /// In en, this message translates to:
  /// **'Charcoal & black'**
  String get presetMonochromeDesc;

  /// No description provided for @previewActiveTask.
  ///
  /// In en, this message translates to:
  /// **'Review interface design'**
  String get previewActiveTask;

  /// No description provided for @previewCompletedTask.
  ///
  /// In en, this message translates to:
  /// **'Sync weekly schedule'**
  String get previewCompletedTask;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @deviceLanguageOption.
  ///
  /// In en, this message translates to:
  /// **'Device language (if supported)'**
  String get deviceLanguageOption;

  /// No description provided for @appLockTitle.
  ///
  /// In en, this message translates to:
  /// **'App Lock'**
  String get appLockTitle;

  /// No description provided for @appLockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint, face, or device PIN'**
  String get appLockSubtitle;

  /// No description provided for @appLockLockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Zettask Locked'**
  String get appLockLockedTitle;

  /// No description provided for @appLockLockedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use fingerprint, face, or device PIN to access your tasks.'**
  String get appLockLockedSubtitle;

  /// No description provided for @unlockButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlockButton;

  /// No description provided for @verifyingButton.
  ///
  /// In en, this message translates to:
  /// **'Verifying...'**
  String get verifyingButton;

  /// No description provided for @appLockUnsupportedError.
  ///
  /// In en, this message translates to:
  /// **'Device has no biometrics or screen lock PIN enabled.'**
  String get appLockUnsupportedError;

  /// No description provided for @appLockCancelledError.
  ///
  /// In en, this message translates to:
  /// **'Verification cancelled or failed.'**
  String get appLockCancelledError;

  /// No description provided for @appLockUnlockFailedError.
  ///
  /// In en, this message translates to:
  /// **'Authentication cancelled or failed. Tap Unlock to try again.'**
  String get appLockUnlockFailedError;

  /// No description provided for @calendarSyncTitle.
  ///
  /// In en, this message translates to:
  /// **'Calendar Sync'**
  String get calendarSyncTitle;

  /// No description provided for @calendarSyncActiveSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Active · {count} calendars'**
  String calendarSyncActiveSubtitle(int count);

  /// No description provided for @calendarSyncInactiveSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Off · display device events read-only'**
  String get calendarSyncInactiveSubtitle;

  /// No description provided for @grantCalendarPermission.
  ///
  /// In en, this message translates to:
  /// **'Grant Calendar Permission'**
  String get grantCalendarPermission;

  /// No description provided for @exportCsvTitle.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get exportCsvTitle;

  /// No description provided for @exportCsvSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share tasks or notes as CSV files'**
  String get exportCsvSubtitle;

  /// No description provided for @exportDataCsvTitle.
  ///
  /// In en, this message translates to:
  /// **'Export CSV Data'**
  String get exportDataCsvTitle;

  /// No description provided for @exportTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Tasks'**
  String get exportTasksTitle;

  /// No description provided for @exportTasksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All scheduled, unplanned, and project tasks'**
  String get exportTasksSubtitle;

  /// No description provided for @exportNotesTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Notes'**
  String get exportNotesTitle;

  /// No description provided for @exportNotesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All quick notes in Notes'**
  String get exportNotesSubtitle;

  /// No description provided for @exportBothTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Both'**
  String get exportBothTitle;

  /// No description provided for @exportBothSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tasks and notes CSV files together'**
  String get exportBothSubtitle;

  /// No description provided for @aboutPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'About & Privacy Policy'**
  String get aboutPrivacyTitle;

  /// No description provided for @aboutPrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Version {version} · Offline-first & optional cloud'**
  String aboutPrivacySubtitle(String version);

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About Zettask'**
  String get aboutTitle;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionLabel(String version);

  /// No description provided for @privacySyncTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Sync'**
  String get privacySyncTitle;

  /// No description provided for @privacySyncDescription.
  ///
  /// In en, this message translates to:
  /// **'By default your data stays locally on this device. Firebase cloud sync is optional when signed in, and you can permanently delete your account and cloud data at any time.'**
  String get privacySyncDescription;

  /// No description provided for @privacyPolicyLabel.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyLabel;

  /// No description provided for @privacyLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy link copied'**
  String get privacyLinkCopied;

  /// No description provided for @accountAndSyncTitle.
  ///
  /// In en, this message translates to:
  /// **'Account & Sync'**
  String get accountAndSyncTitle;

  /// No description provided for @signInToZettask.
  ///
  /// In en, this message translates to:
  /// **'Sign in to Zettask Account'**
  String get signInToZettask;

  /// No description provided for @accountBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Optional · back up & sync data to cloud'**
  String get accountBannerSubtitle;

  /// No description provided for @authWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep your progress and tasks'**
  String get authWelcomeTitle;

  /// No description provided for @authWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Back up schedules, projects, and notes automatically to the cloud. You can still use Zettask locally without an account.'**
  String get authWelcomeSubtitle;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create new account'**
  String get createNewAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @authTermsNotice.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to Zettask Terms & Privacy Policy.'**
  String get authTermsNotice;

  /// No description provided for @signInToAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to Zettask'**
  String get signInToAccountTitle;

  /// No description provided for @signInToAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Local data will be merged with your cloud backup.'**
  String get signInToAccountSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'name@email.com'**
  String get emailHint;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required.'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format.'**
  String get emailInvalid;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get passwordHint;

  /// No description provided for @passwordNewHint.
  ///
  /// In en, this message translates to:
  /// **'At least 6 characters'**
  String get passwordNewHint;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required.'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get passwordTooShort;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot?'**
  String get forgotPassword;

  /// No description provided for @enterValidEmailFirst.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address first.'**
  String get enterValidEmailFirst;

  /// No description provided for @passwordResetSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent to {email}.'**
  String passwordResetSent(String email);

  /// No description provided for @showPasswordTooltip.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPasswordTooltip;

  /// No description provided for @hidePasswordTooltip.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePasswordTooltip;

  /// No description provided for @noAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccountPrompt;

  /// No description provided for @createAccountLink.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccountLink;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountTitle;

  /// No description provided for @createAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Back up all tasks, routines, and notes to the cloud.'**
  String get createAccountSubtitle;

  /// No description provided for @haveAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccountPrompt;

  /// No description provided for @signedInVia.
  ///
  /// In en, this message translates to:
  /// **'Signed in via {provider}'**
  String signedInVia(String provider);

  /// No description provided for @syncNowButton.
  ///
  /// In en, this message translates to:
  /// **'Sync now'**
  String get syncNowButton;

  /// No description provided for @syncingLabel.
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get syncingLabel;

  /// No description provided for @syncDoneMessage.
  ///
  /// In en, this message translates to:
  /// **'Sync completed.'**
  String get syncDoneMessage;

  /// No description provided for @syncFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to sync data. Check your internet connection.'**
  String get syncFailedMessage;

  /// No description provided for @syncStatusIdle.
  ///
  /// In en, this message translates to:
  /// **'Not synced yet'**
  String get syncStatusIdle;

  /// No description provided for @syncStatusSyncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get syncStatusSyncing;

  /// No description provided for @syncStatusSynced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get syncStatusSynced;

  /// No description provided for @syncStatusError.
  ///
  /// In en, this message translates to:
  /// **'Sync failed'**
  String get syncStatusError;

  /// No description provided for @lastSyncedPrefix.
  ///
  /// In en, this message translates to:
  /// **'Last synced: {time}'**
  String lastSyncedPrefix(String time);

  /// No description provided for @neverSynced.
  ///
  /// In en, this message translates to:
  /// **'Never synced'**
  String get neverSynced;

  /// No description provided for @signOutButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOutButton;

  /// No description provided for @signedOutMessage.
  ///
  /// In en, this message translates to:
  /// **'Signed out. Local data remains on your device.'**
  String get signedOutMessage;

  /// No description provided for @deleteAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountButton;

  /// No description provided for @deleteAccountStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Delete Account?'**
  String get deleteAccountStep1Title;

  /// No description provided for @deleteAccountStep1Body.
  ///
  /// In en, this message translates to:
  /// **'All cloud backups (tasks, routines, projects, tags, notes, and templates) and your account will be permanently deleted. Local data on this device remains intact.'**
  String get deleteAccountStep1Body;

  /// No description provided for @deleteAccountStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Confirm Permanent Deletion'**
  String get deleteAccountStep2Title;

  /// No description provided for @deleteAccountStep2Body.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. Are you sure you want to permanently delete your account and all cloud data now?'**
  String get deleteAccountStep2Body;

  /// No description provided for @deleteAccountConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete Permanently'**
  String get deleteAccountConfirmButton;

  /// No description provided for @accountDeletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Account and all cloud data permanently deleted.'**
  String get accountDeletedMessage;

  /// No description provided for @reloginRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Re-login Required'**
  String get reloginRequiredTitle;

  /// No description provided for @authErrUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No account found for this email.'**
  String get authErrUserNotFound;

  /// No description provided for @authErrWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get authErrWrongPassword;

  /// No description provided for @authErrInvalidCredential.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get authErrInvalidCredential;

  /// No description provided for @authErrInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format.'**
  String get authErrInvalidEmail;

  /// No description provided for @authErrEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered to another account.'**
  String get authErrEmailInUse;

  /// No description provided for @authErrWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak. Use at least 6 characters.'**
  String get authErrWeakPassword;

  /// No description provided for @authErrNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network issue. Please check your internet connection.'**
  String get authErrNetwork;

  /// No description provided for @authErrRequiresRecentLogin.
  ///
  /// In en, this message translates to:
  /// **'For security, sign out and sign back in before deleting your account.'**
  String get authErrRequiresRecentLogin;

  /// No description provided for @authErrTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again shortly.'**
  String get authErrTooManyRequests;

  /// No description provided for @authErrUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get authErrUserDisabled;

  /// No description provided for @authErrAccountExistsDifferent.
  ///
  /// In en, this message translates to:
  /// **'This email is already linked to another sign-in method.'**
  String get authErrAccountExistsDifferent;

  /// No description provided for @authErrOperationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'This sign-in method is not enabled.'**
  String get authErrOperationNotAllowed;

  /// No description provided for @authErrFirebaseUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Account service is unavailable. Check your connection.'**
  String get authErrFirebaseUnavailable;

  /// No description provided for @authErrUnknown.
  ///
  /// In en, this message translates to:
  /// **'Authentication error. Please try again.'**
  String get authErrUnknown;

  /// No description provided for @widgetTitle.
  ///
  /// In en, this message translates to:
  /// **'Zettask · Today'**
  String get widgetTitle;

  /// No description provided for @widgetEmptyText.
  ///
  /// In en, this message translates to:
  /// **'All tasks for today are done.'**
  String get widgetEmptyText;

  /// No description provided for @repeatingTasksAndFollowingDeleted.
  ///
  /// In en, this message translates to:
  /// **'Repeating task and following occurrences deleted'**
  String get repeatingTasksAndFollowingDeleted;

  /// No description provided for @noProjectTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'No tasks in this project yet'**
  String get noProjectTasksTitle;

  /// No description provided for @noProjectTasksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add a task to {project}.'**
  String noProjectTasksSubtitle(String project);

  /// No description provided for @addTaskToProjectTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add Task to Project'**
  String get addTaskToProjectTooltip;

  /// No description provided for @noTagsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap + to create color tags for tasks and notes.'**
  String get noTagsSubtitle;

  /// No description provided for @tagOptionsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Tag options'**
  String get tagOptionsTooltip;

  /// No description provided for @deleteTag.
  ///
  /// In en, this message translates to:
  /// **'Delete tag'**
  String get deleteTag;

  /// No description provided for @addTagTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add Tag'**
  String get addTagTooltip;

  /// No description provided for @noTasksWithTag.
  ///
  /// In en, this message translates to:
  /// **'No tasks with this tag yet.'**
  String get noTasksWithTag;

  /// No description provided for @addTaskWithTagTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add Task with Tag'**
  String get addTaskWithTagTooltip;

  /// No description provided for @tagNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Work, Personal, Urgent'**
  String get tagNameHint;

  /// No description provided for @tagColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Tag Color'**
  String get tagColorLabel;

  /// No description provided for @createTag.
  ///
  /// In en, this message translates to:
  /// **'Create Tag'**
  String get createTag;

  /// No description provided for @tagDeletedNamed.
  ///
  /// In en, this message translates to:
  /// **'Tag \"{name}\" deleted'**
  String tagDeletedNamed(String name);

  /// No description provided for @noTemplatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Save frequently used task and checklist structures to create them faster.'**
  String get noTemplatesSubtitle;

  /// No description provided for @templateOptionsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Template options'**
  String get templateOptionsTooltip;

  /// No description provided for @deleteTemplate.
  ///
  /// In en, this message translates to:
  /// **'Delete template'**
  String get deleteTemplate;

  /// No description provided for @createTemplateTooltip.
  ///
  /// In en, this message translates to:
  /// **'Create Template'**
  String get createTemplateTooltip;

  /// No description provided for @templateDeletedNamed.
  ///
  /// In en, this message translates to:
  /// **'Template \"{name}\" deleted'**
  String templateDeletedNamed(String name);

  /// No description provided for @templateNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Weekly Release'**
  String get templateNameHint;

  /// No description provided for @defaultTaskTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Default task title'**
  String get defaultTaskTitleLabel;

  /// No description provided for @defaultTaskTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Prepare production release'**
  String get defaultTaskTitleHint;

  /// No description provided for @timeOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Time (optional)'**
  String get timeOptionalLabel;

  /// No description provided for @clearTimeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear time'**
  String get clearTimeTooltip;

  /// No description provided for @projectOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Project (optional)'**
  String get projectOptionalLabel;

  /// No description provided for @tagOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Tag (optional)'**
  String get tagOptionalLabel;

  /// No description provided for @defaultSubtasksLabel.
  ///
  /// In en, this message translates to:
  /// **'Default subtasks'**
  String get defaultSubtasksLabel;

  /// No description provided for @addTemplateSubtaskHint.
  ///
  /// In en, this message translates to:
  /// **'Add template subtask...'**
  String get addTemplateSubtaskHint;

  /// No description provided for @saveTemplate.
  ///
  /// In en, this message translates to:
  /// **'Save Template'**
  String get saveTemplate;

  /// No description provided for @subtasksTotalCount.
  ///
  /// In en, this message translates to:
  /// **'{count} subtasks'**
  String subtasksTotalCount(int count);

  /// No description provided for @useTemplateButton.
  ///
  /// In en, this message translates to:
  /// **'Use Template'**
  String get useTemplateButton;

  /// No description provided for @pickTemplateTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Template'**
  String get pickTemplateTitle;

  /// No description provided for @repeatingTaskDeleted.
  ///
  /// In en, this message translates to:
  /// **'Repeating task deleted'**
  String get repeatingTaskDeleted;

  /// No description provided for @noRepeatingTasksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap + to create daily, weekly, or monthly routines.'**
  String get noRepeatingTasksSubtitle;

  /// No description provided for @addRepeatingTaskTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add Repeating Task'**
  String get addRepeatingTaskTooltip;

  /// No description provided for @editRepeatingTask.
  ///
  /// In en, this message translates to:
  /// **'Edit Repeating Task'**
  String get editRepeatingTask;

  /// No description provided for @newRepeatingTask.
  ///
  /// In en, this message translates to:
  /// **'New Repeating Task'**
  String get newRepeatingTask;

  /// No description provided for @deleteTaskTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete task'**
  String get deleteTaskTooltip;

  /// No description provided for @scheduleLabel.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get scheduleLabel;

  /// No description provided for @startAndTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Start & Time'**
  String get startAndTimeLabel;

  /// No description provided for @dateRequiredForTime.
  ///
  /// In en, this message translates to:
  /// **'Needs date'**
  String get dateRequiredForTime;

  /// No description provided for @clearDateTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear date'**
  String get clearDateTooltip;

  /// No description provided for @pickTimeFirstReminder.
  ///
  /// In en, this message translates to:
  /// **'Pick a time first to enable reminders.'**
  String get pickTimeFirstReminder;

  /// No description provided for @notificationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission is off. Enable it in device settings so reminders appear.'**
  String get notificationPermissionDenied;

  /// No description provided for @pickDateFirstRepeat.
  ///
  /// In en, this message translates to:
  /// **'Pick a date first to configure repetition.'**
  String get pickDateFirstRepeat;

  /// No description provided for @subtasksLabel.
  ///
  /// In en, this message translates to:
  /// **'Subtasks'**
  String get subtasksLabel;

  /// No description provided for @subtasksWithCount.
  ///
  /// In en, this message translates to:
  /// **'Subtasks ({count})'**
  String subtasksWithCount(int count);

  /// No description provided for @removeSubtaskTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove subtask'**
  String get removeSubtaskTooltip;

  /// No description provided for @addSubtaskTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add subtask'**
  String get addSubtaskTooltip;

  /// No description provided for @moveAllOverdueMoved.
  ///
  /// In en, this message translates to:
  /// **'All overdue tasks moved to today'**
  String get moveAllOverdueMoved;

  /// No description provided for @moveAllShort.
  ///
  /// In en, this message translates to:
  /// **'Move all'**
  String get moveAllShort;

  /// No description provided for @noOverdueTasksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All tasks from previous days are completed.'**
  String get noOverdueTasksSubtitle;

  /// No description provided for @repeatingDeletePrompt.
  ///
  /// In en, this message translates to:
  /// **'What would you like to delete?'**
  String get repeatingDeletePrompt;

  /// No description provided for @repeatingEditPrompt.
  ///
  /// In en, this message translates to:
  /// **'What would you like to change?'**
  String get repeatingEditPrompt;

  /// No description provided for @repeatingDeleteSingleSub.
  ///
  /// In en, this message translates to:
  /// **'Delete only this occurrence'**
  String get repeatingDeleteSingleSub;

  /// No description provided for @repeatingEditSingleSub.
  ///
  /// In en, this message translates to:
  /// **'Edit only this occurrence'**
  String get repeatingEditSingleSub;

  /// No description provided for @repeatingDeleteFollowingSub.
  ///
  /// In en, this message translates to:
  /// **'Delete this and all upcoming occurrences'**
  String get repeatingDeleteFollowingSub;

  /// No description provided for @repeatingEditFollowingSub.
  ///
  /// In en, this message translates to:
  /// **'Apply to this and all upcoming occurrences'**
  String get repeatingEditFollowingSub;

  /// No description provided for @deviceCalendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Device Calendar'**
  String get deviceCalendarTitle;

  /// No description provided for @selectCalendarsLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Calendars'**
  String get selectCalendarsLabel;

  /// No description provided for @calendarsActiveCount.
  ///
  /// In en, this message translates to:
  /// **'{selected}/{total} active'**
  String calendarsActiveCount(int selected, int total);

  /// No description provided for @showCalendarEventsTitle.
  ///
  /// In en, this message translates to:
  /// **'Show Calendar Events'**
  String get showCalendarEventsTitle;

  /// No description provided for @showCalendarEventsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Device events appear chronologically as read-only.'**
  String get showCalendarEventsSubtitle;

  /// No description provided for @calendarPermDeniedPermanentTitle.
  ///
  /// In en, this message translates to:
  /// **'Calendar Permission Permanently Denied'**
  String get calendarPermDeniedPermanentTitle;

  /// No description provided for @calendarPermRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Calendar Read Permission Needed'**
  String get calendarPermRequiredTitle;

  /// No description provided for @calendarPermDeniedPermanentDesc.
  ///
  /// In en, this message translates to:
  /// **'Enable calendar read permission in device Settings, then tap Check Again.'**
  String get calendarPermDeniedPermanentDesc;

  /// No description provided for @calendarPermRequiredDesc.
  ///
  /// In en, this message translates to:
  /// **'Zettask only asks for read-only calendar permission to show your events on the timeline.'**
  String get calendarPermRequiredDesc;

  /// No description provided for @openSettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettingsButton;

  /// No description provided for @checkAgainButton.
  ///
  /// In en, this message translates to:
  /// **'Check Again'**
  String get checkAgainButton;

  /// No description provided for @noCalendarsFound.
  ///
  /// In en, this message translates to:
  /// **'No calendars found on this device.'**
  String get noCalendarsFound;

  /// No description provided for @eventDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get eventDetailTitle;

  /// No description provided for @eventNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get eventNotesLabel;

  /// No description provided for @calendarEventReadOnlyBanner.
  ///
  /// In en, this message translates to:
  /// **'Event from device calendar (read-only).'**
  String get calendarEventReadOnlyBanner;

  /// No description provided for @markUncompletedSemantics.
  ///
  /// In en, this message translates to:
  /// **'Mark incomplete'**
  String get markUncompletedSemantics;

  /// No description provided for @markCompletedSemantics.
  ///
  /// In en, this message translates to:
  /// **'Mark completed'**
  String get markCompletedSemantics;

  /// No description provided for @deleteNoteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete note'**
  String get deleteNoteTooltip;

  /// No description provided for @repeatMonthlyDay.
  ///
  /// In en, this message translates to:
  /// **'Every month · day {day}'**
  String repeatMonthlyDay(int day);

  /// No description provided for @last30DaysSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get last30DaysSubtitle;

  /// No description provided for @allTimeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get allTimeSubtitle;

  /// No description provided for @taskCancelled.
  ///
  /// In en, this message translates to:
  /// **'Task marked as cancelled'**
  String get taskCancelled;

  /// No description provided for @taskRestored.
  ///
  /// In en, this message translates to:
  /// **'Task marked as active'**
  String get taskRestored;

  /// No description provided for @cancelledStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelledStatusLabel;

  /// No description provided for @restoreTaskLabel.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restoreTaskLabel;

  /// No description provided for @markCancelledSemantics.
  ///
  /// In en, this message translates to:
  /// **'Mark cancelled'**
  String get markCancelledSemantics;

  /// No description provided for @calendarPermFallbackHint.
  ///
  /// In en, this message translates to:
  /// **'If the permission prompt did not appear, open App Settings to enable Calendar access manually.'**
  String get calendarPermFallbackHint;

  /// No description provided for @calendarBadgeLabel.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendarBadgeLabel;

  /// No description provided for @calendarSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendarSourceLabel;

  /// No description provided for @calendarLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get calendarLocationLabel;

  /// No description provided for @calendarReadOnlyInfo.
  ///
  /// In en, this message translates to:
  /// **'Synced from device calendar. This item is read-only and cannot be edited in Zettask.'**
  String get calendarReadOnlyInfo;

  /// No description provided for @proBrandTitle.
  ///
  /// In en, this message translates to:
  /// **'Zettask Pro'**
  String get proBrandTitle;

  /// No description provided for @proBadge.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get proBadge;

  /// No description provided for @proPaywallSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync, device calendars, app lock, and OLED themes in one plan.'**
  String get proPaywallSubtitle;

  /// No description provided for @proActiveBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Active — {plan}'**
  String proActiveBannerTitle(String plan);

  /// No description provided for @proActiveBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Thank you for supporting Zettask.'**
  String get proActiveBannerSubtitle;

  /// No description provided for @proUpgradeBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'AMOLED theme, custom accents, widget styles & more'**
  String get proUpgradeBannerSubtitle;

  /// No description provided for @proBenefitCloudSync.
  ///
  /// In en, this message translates to:
  /// **'Cloud Sync & Multi-Device'**
  String get proBenefitCloudSync;

  /// No description provided for @proBenefitCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar Integration & National Holidays'**
  String get proBenefitCalendar;

  /// No description provided for @proBenefitAppLock.
  ///
  /// In en, this message translates to:
  /// **'Biometric App Lock & Recent Apps Privacy'**
  String get proBenefitAppLock;

  /// No description provided for @proBenefitProjectsCsv.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Projects & CSV Export'**
  String get proBenefitProjectsCsv;

  /// No description provided for @proBenefitCustomization.
  ///
  /// In en, this message translates to:
  /// **'AMOLED Pure Black, Custom Accents & Widget Styles'**
  String get proBenefitCustomization;

  /// No description provided for @proPlanMonthlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get proPlanMonthlyTitle;

  /// No description provided for @proPlanMonthlyPrice.
  ///
  /// In en, this message translates to:
  /// **'\$1.99 / month'**
  String get proPlanMonthlyPrice;

  /// No description provided for @proPlanYearlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get proPlanYearlyTitle;

  /// No description provided for @proPlanYearlyPrice.
  ///
  /// In en, this message translates to:
  /// **'\$12.99 / year'**
  String get proPlanYearlyPrice;

  /// No description provided for @proPlanYearlyBadge.
  ///
  /// In en, this message translates to:
  /// **'Best Value'**
  String get proPlanYearlyBadge;

  /// No description provided for @proPlanYearlySavings.
  ///
  /// In en, this message translates to:
  /// **'Save ~43%'**
  String get proPlanYearlySavings;

  /// No description provided for @proPlanLifetimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Lifetime'**
  String get proPlanLifetimeTitle;

  /// No description provided for @proPlanLifetimePrice.
  ///
  /// In en, this message translates to:
  /// **'\$29.99'**
  String get proPlanLifetimePrice;

  /// No description provided for @proPlanLifetimeBadge.
  ///
  /// In en, this message translates to:
  /// **'One-Time'**
  String get proPlanLifetimeBadge;

  /// No description provided for @proContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get proContinueButton;

  /// No description provided for @proAlreadyActiveButton.
  ///
  /// In en, this message translates to:
  /// **'Zettask Pro Active'**
  String get proAlreadyActiveButton;

  /// No description provided for @proRestorePurchasesButton.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get proRestorePurchasesButton;

  /// No description provided for @proLegalFootnote.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions renew automatically unless cancelled. Cancel anytime in Google Play.'**
  String get proLegalFootnote;

  /// No description provided for @proStoreUnavailableMessage.
  ///
  /// In en, this message translates to:
  /// **'Google Play Billing is not available on this device yet. Try again once connected to Google Play.'**
  String get proStoreUnavailableMessage;

  /// No description provided for @proPurchaseSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Zettask Pro is now active.'**
  String get proPurchaseSuccessMessage;

  /// No description provided for @proRestoreSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your Zettask Pro purchase has been restored.'**
  String get proRestoreSuccessMessage;

  /// No description provided for @proRestoreEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No active Zettask Pro purchase was found on this account.'**
  String get proRestoreEmptyMessage;

  /// No description provided for @proPurchaseFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Could not complete the purchase right now. Please try again.'**
  String get proPurchaseFailedMessage;

  /// No description provided for @debugProSimulationLabel.
  ///
  /// In en, this message translates to:
  /// **'Developer Mode: Pro Simulation'**
  String get debugProSimulationLabel;

  /// No description provided for @amoledPureBlackTitle.
  ///
  /// In en, this message translates to:
  /// **'AMOLED Pure Black'**
  String get amoledPureBlackTitle;

  /// No description provided for @amoledPureBlackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pure #000000 dark background for OLED displays'**
  String get amoledPureBlackSubtitle;

  /// No description provided for @customAccentSection.
  ///
  /// In en, this message translates to:
  /// **'Custom Accent Color'**
  String get customAccentSection;

  /// No description provided for @accentMonochrome.
  ///
  /// In en, this message translates to:
  /// **'Monochrome'**
  String get accentMonochrome;

  /// No description provided for @accentSage.
  ///
  /// In en, this message translates to:
  /// **'Sage'**
  String get accentSage;

  /// No description provided for @accentIndigo.
  ///
  /// In en, this message translates to:
  /// **'Indigo'**
  String get accentIndigo;

  /// No description provided for @accentTerracotta.
  ///
  /// In en, this message translates to:
  /// **'Terracotta'**
  String get accentTerracotta;

  /// No description provided for @accentAmber.
  ///
  /// In en, this message translates to:
  /// **'Amber'**
  String get accentAmber;

  /// No description provided for @widgetStyleSection.
  ///
  /// In en, this message translates to:
  /// **'Home Screen Widget Style'**
  String get widgetStyleSection;

  /// No description provided for @widgetStyleStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get widgetStyleStandard;

  /// No description provided for @widgetStyleAmoled.
  ///
  /// In en, this message translates to:
  /// **'AMOLED'**
  String get widgetStyleAmoled;

  /// No description provided for @widgetStyleTranslucent.
  ///
  /// In en, this message translates to:
  /// **'Translucent'**
  String get widgetStyleTranslucent;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'he',
    'id',
    'it',
    'ja',
    'ko',
    'pt',
    'ru',
    'uk',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'he':
      return AppLocalizationsHe();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'uk':
      return AppLocalizationsUk();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
