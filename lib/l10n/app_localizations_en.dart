// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => 'Timeline';

  @override
  String get navBoard => 'Board';

  @override
  String get navUnplanned => 'Unplanned';

  @override
  String get navMore => 'More';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get undo => 'Undo';

  @override
  String get back => 'Back';

  @override
  String get retry => 'Try Again';

  @override
  String get clear => 'Clear';

  @override
  String get all => 'All';

  @override
  String get or => 'or';

  @override
  String get continueAction => 'Continue';

  @override
  String get understand => 'Got it';

  @override
  String get useAction => 'Use';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get toDo => 'To Do';

  @override
  String get overdue => 'Overdue';

  @override
  String get unplanned => 'Unplanned';

  @override
  String get allDay => 'All Day';

  @override
  String get scheduled => 'Scheduled';

  @override
  String get addTaskToday => 'Add task for today';

  @override
  String get addTask => 'Add task';

  @override
  String get noTasksForDate => 'No tasks for this date.';

  @override
  String get savedToUnplanned => 'Saved to Unplanned';

  @override
  String get savedToUnplannedNoDate => 'Saved to Unplanned (no date)';

  @override
  String scheduledForDate(String date) {
    return 'Scheduled for $date';
  }

  @override
  String taskScheduledForDate(String date) {
    return 'Task scheduled for $date';
  }

  @override
  String get taskDeleted => 'Task deleted';

  @override
  String get searchTasksTooltip => 'Search tasks';

  @override
  String get timelineOptionsTooltip => 'Timeline options';

  @override
  String get addTaskTooltip => 'Add Task';

  @override
  String get completedLabel => 'Done';

  @override
  String get uncompleteLabel => 'Mark active';

  @override
  String subtasksCount(int done, int total) {
    return '$done/$total subtasks';
  }

  @override
  String get repeatingTaskLabel => 'Repeating task';

  @override
  String get quickAddHint => 'Add a new task...';

  @override
  String get expandTooltip => 'Expand';

  @override
  String get saveTaskTooltip => 'Save task';

  @override
  String get newTask => 'New Task';

  @override
  String get editTask => 'Edit Task';

  @override
  String get taskTitleLabel => 'Task title';

  @override
  String get taskTitleHint => 'e.g. Review sprint notes';

  @override
  String get taskTitleRequired => 'Task title is required';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get descriptionHint => 'Add notes or context...';

  @override
  String get pickDate => 'Pick Date';

  @override
  String get pickOnCalendar => 'Pick on calendar...';

  @override
  String get noDateUnplanned => 'No date (Unplanned)';

  @override
  String get noDate => 'No date';

  @override
  String get taskTime => 'Task Time';

  @override
  String get changeTime => 'Change time';

  @override
  String get clearTimeAllDay => 'Clear time (All Day)';

  @override
  String get timeLabel => 'Time';

  @override
  String get reminderLabel => 'Reminder';

  @override
  String get noReminder => 'No reminder';

  @override
  String get atTime => 'On time';

  @override
  String get minutesBefore10 => '10 min before';

  @override
  String get minutesBefore30 => '30 min before';

  @override
  String get hourBefore1 => '1 hour before';

  @override
  String get reminderShort10m => '10m';

  @override
  String get reminderShort30m => '30m';

  @override
  String get reminderShort1h => '1h';

  @override
  String get projectLabel => 'Project';

  @override
  String get noProject => 'No project';

  @override
  String get tagLabel => 'Tag';

  @override
  String get noTag => 'No tag';

  @override
  String get priorityLabel => 'Priority';

  @override
  String get priorityLow => 'Low';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityHigh => 'High';

  @override
  String get saveTask => 'Save Task';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get checklistLabel => 'Checklist';

  @override
  String get addChecklistHint => 'Add checklist item...';

  @override
  String get repeatLabel => 'Repeat';

  @override
  String get noRepeat => 'Does not repeat';

  @override
  String get repeatDaily => 'Every day';

  @override
  String get repeatWeekly => 'Every week';

  @override
  String get repeatMonthly => 'Every month';

  @override
  String get colorLabel => 'Color';

  @override
  String get timelineOptionsTitle => 'Timeline Options';

  @override
  String get viewModeLabel => 'View Mode';

  @override
  String get modeTimeline => 'Timeline Mode';

  @override
  String get modeDaily => 'Daily Mode';

  @override
  String get firstDayOfWeek => 'Start of Week';

  @override
  String get monday => 'Monday';

  @override
  String get sunday => 'Sunday';

  @override
  String get firstDayMondayOrder => 'Mon · Tue · Wed · Thu · Fri · Sat · Sun';

  @override
  String get firstDaySundayOrder => 'Sun · Mon · Tue · Wed · Thu · Fri · Sat';

  @override
  String get showCompletedTasks => 'Show completed tasks';

  @override
  String get showCompletedTasksSubtitle =>
      'Hide checked tasks to stay focused on active ones.';

  @override
  String get showCompletedWorkspaceSubtitle => 'Show or hide completed tasks.';

  @override
  String get overdueTasksTitle => 'Overdue Tasks';

  @override
  String get noOverdueTasks => 'No overdue tasks';

  @override
  String get moveToToday => 'Move to Today';

  @override
  String get moveAllToToday => 'Move all to Today';

  @override
  String get searchTasksHint => 'Search tasks...';

  @override
  String get searchTasksEmpty =>
      'Type to search tasks, descriptions, or checklists.';

  @override
  String searchNoResults(String query) {
    return 'No tasks match \"$query\".';
  }

  @override
  String get calendarEventReadOnly => 'Calendar event · read-only';

  @override
  String get prevWeekTooltip => 'Previous week';

  @override
  String get nextWeekTooltip => 'Next week';

  @override
  String get boardTitle => 'Board';

  @override
  String get allProjects => 'All Projects';

  @override
  String get searchProjectHint => 'Search project name...';

  @override
  String get searchProjectTooltip => 'Search projects';

  @override
  String get closeSearchTooltip => 'Close search';

  @override
  String get createProject => 'Create Project';

  @override
  String get editProject => 'Edit project';

  @override
  String get deleteProject => 'Delete project';

  @override
  String get projectOptionsTooltip => 'Project options';

  @override
  String projectDeleted(String name) {
    return 'Project \"$name\" deleted';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return '$done/$total done';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return '$done/$total tasks done';
  }

  @override
  String get projectNotFound => 'Project not found';

  @override
  String get noProjectsYet => 'No projects yet';

  @override
  String projectSearchEmpty(String query) {
    return 'No project matches \"$query\".';
  }

  @override
  String get noProjectsSubtitle =>
      'Tap the folder button below to create your first project.';

  @override
  String get newProject => 'New Project';

  @override
  String get projectNameLabel => 'Project name';

  @override
  String get projectNameHint => 'e.g. Zettask Launch';

  @override
  String get projectNameRequired => 'Project name is required';

  @override
  String get projectColorLabel => 'Project Color';

  @override
  String get unplannedTitle => 'Unplanned';

  @override
  String activeCountLabel(int count) {
    return '$count active';
  }

  @override
  String get noUnplannedTitle => 'No unplanned tasks yet';

  @override
  String get noUnplannedSubtitle => 'Tap + to capture tasks without a date.';

  @override
  String get addUnplannedTooltip => 'Add Unplanned Task';

  @override
  String get workspaceTitle => 'Workspace';

  @override
  String get organizeSection => 'Organize';

  @override
  String get automationSection => 'Automation';

  @override
  String get insightsSection => 'Insights & Personalization';

  @override
  String get settingsInfoSection => 'Settings & Info';

  @override
  String get tagsTitle => 'Tags';

  @override
  String get tagsSubtitleEmpty => 'Color labels for tasks and notes';

  @override
  String tagsCountSubtitle(int count) {
    return '$count tags saved';
  }

  @override
  String get newTag => 'New Tag';

  @override
  String get editTag => 'Edit Tag';

  @override
  String get tagNameLabel => 'Tag name';

  @override
  String get tagNameRequired => 'Tag name is required';

  @override
  String get tagDeleted => 'Tag deleted';

  @override
  String get noTagsYet => 'No tags yet';

  @override
  String tagTasksCount(int count) {
    return '$count tasks';
  }

  @override
  String get templatesTitle => 'Templates';

  @override
  String get templatesSubtitleEmpty =>
      'Save reusable task and checklist structures';

  @override
  String templatesCountSubtitle(int count) {
    return '$count templates ready';
  }

  @override
  String get newTemplate => 'New Template';

  @override
  String get editTemplate => 'Edit Template';

  @override
  String get templateNameLabel => 'Template name';

  @override
  String get templateNameRequired => 'Template name is required';

  @override
  String get templateDeleted => 'Template deleted';

  @override
  String get noTemplatesYet => 'No templates yet';

  @override
  String get taskFromTemplateSaved => 'Task from template saved';

  @override
  String get notesTitle => 'Notes';

  @override
  String get notesSubtitleEmpty => 'Quick undated notes';

  @override
  String notesCountSubtitle(int count) {
    return '$count notes saved';
  }

  @override
  String get newNote => 'New Note';

  @override
  String get editNote => 'Edit Note';

  @override
  String get noteTitleLabel => 'Note title';

  @override
  String get noteTitleHint => 'e.g. Meeting summary';

  @override
  String get noteTitleRequired => 'Note title is required';

  @override
  String get noteContentLabel => 'Note content';

  @override
  String get noteContentHint => 'Write your note here...';

  @override
  String get noteDeleted => 'Note deleted';

  @override
  String get searchNotesHint => 'Search notes...';

  @override
  String get noteNotFound => 'Note not found';

  @override
  String get noNotesYet => 'No notes yet';

  @override
  String noteSearchEmpty(String query) {
    return 'No note matches \"$query\".';
  }

  @override
  String get noNotesSubtitle => 'Tap + to jot down an undated note.';

  @override
  String get saveNote => 'Save Note';

  @override
  String get repeatingTasksTitle => 'Repeating Tasks';

  @override
  String get repeatingTasksSubtitleEmpty =>
      'Manage daily, weekly, and monthly routines';

  @override
  String repeatingActiveCount(int count) {
    return '$count active routines';
  }

  @override
  String get noRepeatingTasks => 'No repeating tasks yet';

  @override
  String get repeatingActionTitle => 'This is a repeating task';

  @override
  String get repeatingThisOnly => 'Only this task';

  @override
  String get repeatingThisAndFollowing => 'This and all following tasks';

  @override
  String get last7DaysUpper => 'LAST 7 DAYS';

  @override
  String weeklySummary(int tasks, int checklists) {
    return '$tasks tasks, plus $checklists checklist items';
  }

  @override
  String get statsTitle => 'Statistics';

  @override
  String get range7Days => '7 Days';

  @override
  String get range30Days => '30 Days';

  @override
  String get completedToday => 'Done Today';

  @override
  String get last7DaysLabel => 'Last 7 Days';

  @override
  String get last30DaysLabel => 'Last 30 Days';

  @override
  String get allTimeLabel => 'All Time';

  @override
  String get completionRateLabel => 'Completion Rate';

  @override
  String get activity7Days => 'Last 7 Days Activity';

  @override
  String get activity30Days => 'Last 30 Days Activity';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks tasks · $checklists checklists';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return 'Total $days days: $tasks tasks, plus $checklists checklist items';
  }

  @override
  String get completedByPriority => 'Completed by Priority';

  @override
  String get progressByProject => 'Progress by Project';

  @override
  String get breakdownByTag => 'Breakdown by Tag';

  @override
  String get habits30Days => 'Habits · 30 Days';

  @override
  String get noProjectsCreated => 'No projects created yet.';

  @override
  String get noTagsCreated => 'No tags created yet.';

  @override
  String get noActiveHabits => 'No active routines yet.';

  @override
  String completedCountLabel(int count) {
    return '$count done';
  }

  @override
  String tagBreakdownTrailing(int done, int total) {
    return '$done/$total done';
  }

  @override
  String habitCompletedRatio(String summary, int done, int scheduled) {
    return '$summary · $done/$scheduled done';
  }

  @override
  String statsSubtitle(int completed, int percent) {
    return '$completed completed · $percent% completion rate';
  }

  @override
  String get themeTitle => 'Theme';

  @override
  String get themeAndColorsTitle => 'Theme & Colors';

  @override
  String get livePreviewSection => 'Live Preview';

  @override
  String get appearanceModeSection => 'Appearance Mode';

  @override
  String get colorPaletteSection => 'Color Palette';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get themeSystemLight => 'System (Light)';

  @override
  String get themeSystemDark => 'System (Dark)';

  @override
  String get presetDefault => 'Default';

  @override
  String get presetDefaultDesc => 'Indigo & slate';

  @override
  String get presetOcean => 'Ocean';

  @override
  String get presetOceanDesc => 'Calm blue';

  @override
  String get presetForest => 'Forest';

  @override
  String get presetForestDesc => 'Sage & emerald';

  @override
  String get presetTerracotta => 'Terracotta';

  @override
  String get presetTerracottaDesc => 'Warm clay orange';

  @override
  String get presetPlum => 'Plum';

  @override
  String get presetPlumDesc => 'Muted purple';

  @override
  String get presetMonochrome => 'Monochrome';

  @override
  String get presetMonochromeDesc => 'Charcoal & black';

  @override
  String get previewActiveTask => 'Review interface design';

  @override
  String get previewCompletedTask => 'Sync weekly schedule';

  @override
  String get languageTitle => 'Language';

  @override
  String get deviceLanguageOption => 'Device language (if supported)';

  @override
  String get appLockTitle => 'App Lock';

  @override
  String get appLockSubtitle => 'Fingerprint, face, or device PIN';

  @override
  String get appLockLockedTitle => 'Zettask Locked';

  @override
  String get appLockLockedSubtitle =>
      'Use fingerprint, face, or device PIN to access your tasks.';

  @override
  String get unlockButton => 'Unlock';

  @override
  String get verifyingButton => 'Verifying...';

  @override
  String get appLockUnsupportedError =>
      'Device has no biometrics or screen lock PIN enabled.';

  @override
  String get appLockCancelledError => 'Verification cancelled or failed.';

  @override
  String get appLockUnlockFailedError =>
      'Authentication cancelled or failed. Tap Unlock to try again.';

  @override
  String get calendarSyncTitle => 'Calendar Sync';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return 'Active · $count calendars';
  }

  @override
  String get calendarSyncInactiveSubtitle =>
      'Off · display device events read-only';

  @override
  String get grantCalendarPermission => 'Grant Calendar Permission';

  @override
  String get exportCsvTitle => 'Export CSV';

  @override
  String get exportCsvSubtitle => 'Share tasks or notes as CSV files';

  @override
  String get exportDataCsvTitle => 'Export CSV Data';

  @override
  String get exportTasksTitle => 'Export Tasks';

  @override
  String get exportTasksSubtitle =>
      'All scheduled, unplanned, and project tasks';

  @override
  String get exportNotesTitle => 'Export Notes';

  @override
  String get exportNotesSubtitle => 'All quick notes in Notes';

  @override
  String get exportBothTitle => 'Export Both';

  @override
  String get exportBothSubtitle => 'Tasks and notes CSV files together';

  @override
  String get aboutPrivacyTitle => 'About & Privacy Policy';

  @override
  String aboutPrivacySubtitle(String version) {
    return 'Version $version · Offline-first & optional cloud';
  }

  @override
  String get aboutTitle => 'About Zettask';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get privacySyncTitle => 'Privacy & Sync';

  @override
  String get privacySyncDescription =>
      'By default your data stays locally on this device. Firebase cloud sync is optional when signed in, and you can permanently delete your account and cloud data at any time.';

  @override
  String get privacyPolicyLabel => 'Privacy Policy';

  @override
  String get privacyLinkCopied => 'Privacy Policy link copied';

  @override
  String get accountAndSyncTitle => 'Account & Sync';

  @override
  String get signInToZettask => 'Sign in to Zettask Account';

  @override
  String get accountBannerSubtitle => 'Optional · back up & sync data to cloud';

  @override
  String get authWelcomeTitle => 'Keep your progress and tasks';

  @override
  String get authWelcomeSubtitle =>
      'Back up schedules, projects, and notes automatically to the cloud. You can still use Zettask locally without an account.';

  @override
  String get createNewAccount => 'Create new account';

  @override
  String get signIn => 'Sign In';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get authTermsNotice =>
      'By continuing, you agree to Zettask Terms & Privacy Policy.';

  @override
  String get signInToAccountTitle => 'Sign in to Zettask';

  @override
  String get signInToAccountSubtitle =>
      'Local data will be merged with your cloud backup.';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'name@email.com';

  @override
  String get emailRequired => 'Email is required.';

  @override
  String get emailInvalid => 'Invalid email format.';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter password';

  @override
  String get passwordNewHint => 'At least 6 characters';

  @override
  String get passwordRequired => 'Password is required.';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters.';

  @override
  String get forgotPassword => 'Forgot?';

  @override
  String get enterValidEmailFirst =>
      'Please enter a valid email address first.';

  @override
  String passwordResetSent(String email) {
    return 'Password reset link sent to $email.';
  }

  @override
  String get showPasswordTooltip => 'Show password';

  @override
  String get hidePasswordTooltip => 'Hide password';

  @override
  String get noAccountPrompt => 'Don\'t have an account?';

  @override
  String get createAccountLink => 'Create account';

  @override
  String get createAccountTitle => 'Create Account';

  @override
  String get createAccountSubtitle =>
      'Back up all tasks, routines, and notes to the cloud.';

  @override
  String get haveAccountPrompt => 'Already have an account?';

  @override
  String signedInVia(String provider) {
    return 'Signed in via $provider';
  }

  @override
  String get syncNowButton => 'Sync now';

  @override
  String get syncingLabel => 'Syncing...';

  @override
  String get syncDoneMessage => 'Sync completed.';

  @override
  String get syncFailedMessage =>
      'Failed to sync data. Check your internet connection.';

  @override
  String get syncStatusIdle => 'Not synced yet';

  @override
  String get syncStatusSyncing => 'Syncing...';

  @override
  String get syncStatusSynced => 'Synced';

  @override
  String get syncStatusError => 'Sync failed';

  @override
  String lastSyncedPrefix(String time) {
    return 'Last synced: $time';
  }

  @override
  String get neverSynced => 'Never synced';

  @override
  String get signOutButton => 'Sign Out';

  @override
  String get signedOutMessage =>
      'Signed out. Local data remains on your device.';

  @override
  String get deleteAccountButton => 'Delete Account';

  @override
  String get deleteAccountStep1Title => 'Delete Account?';

  @override
  String get deleteAccountStep1Body =>
      'All cloud backups (tasks, routines, projects, tags, notes, and templates) and your account will be permanently deleted. Local data on this device remains intact.';

  @override
  String get deleteAccountStep2Title => 'Confirm Permanent Deletion';

  @override
  String get deleteAccountStep2Body =>
      'This action cannot be undone. Are you sure you want to permanently delete your account and all cloud data now?';

  @override
  String get deleteAccountConfirmButton => 'Yes, Delete Permanently';

  @override
  String get accountDeletedMessage =>
      'Account and all cloud data permanently deleted.';

  @override
  String get reloginRequiredTitle => 'Re-login Required';

  @override
  String get authErrUserNotFound => 'No account found for this email.';

  @override
  String get authErrWrongPassword => 'Incorrect password.';

  @override
  String get authErrInvalidCredential => 'Invalid email or password.';

  @override
  String get authErrInvalidEmail => 'Invalid email format.';

  @override
  String get authErrEmailInUse =>
      'This email is already registered to another account.';

  @override
  String get authErrWeakPassword =>
      'Password is too weak. Use at least 6 characters.';

  @override
  String get authErrNetwork =>
      'Network issue. Please check your internet connection.';

  @override
  String get authErrRequiresRecentLogin =>
      'For security, sign out and sign back in before deleting your account.';

  @override
  String get authErrTooManyRequests =>
      'Too many attempts. Please try again shortly.';

  @override
  String get authErrUserDisabled => 'This account has been disabled.';

  @override
  String get authErrAccountExistsDifferent =>
      'This email is already linked to another sign-in method.';

  @override
  String get authErrOperationNotAllowed =>
      'This sign-in method is not enabled.';

  @override
  String get authErrFirebaseUnavailable =>
      'Account service is unavailable. Check your connection.';

  @override
  String get authErrUnknown => 'Authentication error. Please try again.';

  @override
  String get widgetTitle => 'Zettask · Today';

  @override
  String get widgetEmptyText => 'All tasks for today are done.';

  @override
  String get repeatingTasksAndFollowingDeleted =>
      'Repeating task and following occurrences deleted';

  @override
  String get noProjectTasksTitle => 'No tasks in this project yet';

  @override
  String noProjectTasksSubtitle(String project) {
    return 'Tap + to add a task to $project.';
  }

  @override
  String get addTaskToProjectTooltip => 'Add Task to Project';

  @override
  String get noTagsSubtitle =>
      'Tap + to create color tags for tasks and notes.';

  @override
  String get tagOptionsTooltip => 'Tag options';

  @override
  String get deleteTag => 'Delete tag';

  @override
  String get addTagTooltip => 'Add Tag';

  @override
  String get noTasksWithTag => 'No tasks with this tag yet.';

  @override
  String get addTaskWithTagTooltip => 'Add Task with Tag';

  @override
  String get tagNameHint => 'e.g. Work, Personal, Urgent';

  @override
  String get tagColorLabel => 'Tag Color';

  @override
  String get createTag => 'Create Tag';

  @override
  String tagDeletedNamed(String name) {
    return 'Tag \"$name\" deleted';
  }

  @override
  String get noTemplatesSubtitle =>
      'Save frequently used task and checklist structures to create them faster.';

  @override
  String get templateOptionsTooltip => 'Template options';

  @override
  String get deleteTemplate => 'Delete template';

  @override
  String get createTemplateTooltip => 'Create Template';

  @override
  String templateDeletedNamed(String name) {
    return 'Template \"$name\" deleted';
  }

  @override
  String get templateNameHint => 'e.g. Weekly Release';

  @override
  String get defaultTaskTitleLabel => 'Default task title';

  @override
  String get defaultTaskTitleHint => 'e.g. Prepare production release';

  @override
  String get timeOptionalLabel => 'Time (optional)';

  @override
  String get clearTimeTooltip => 'Clear time';

  @override
  String get projectOptionalLabel => 'Project (optional)';

  @override
  String get tagOptionalLabel => 'Tag (optional)';

  @override
  String get defaultSubtasksLabel => 'Default subtasks';

  @override
  String get addTemplateSubtaskHint => 'Add template subtask...';

  @override
  String get saveTemplate => 'Save Template';

  @override
  String subtasksTotalCount(int count) {
    return '$count subtasks';
  }

  @override
  String get useTemplateButton => 'Use Template';

  @override
  String get pickTemplateTitle => 'Choose Template';

  @override
  String get repeatingTaskDeleted => 'Repeating task deleted';

  @override
  String get noRepeatingTasksSubtitle =>
      'Tap + to create daily, weekly, or monthly routines.';

  @override
  String get addRepeatingTaskTooltip => 'Add Repeating Task';

  @override
  String get editRepeatingTask => 'Edit Repeating Task';

  @override
  String get newRepeatingTask => 'New Repeating Task';

  @override
  String get deleteTaskTooltip => 'Delete task';

  @override
  String get scheduleLabel => 'Schedule';

  @override
  String get startAndTimeLabel => 'Start & Time';

  @override
  String get dateRequiredForTime => 'Needs date';

  @override
  String get clearDateTooltip => 'Clear date';

  @override
  String get pickTimeFirstReminder => 'Pick a time first to enable reminders.';

  @override
  String get notificationPermissionDenied =>
      'Notification permission is off. Enable it in device settings so reminders appear.';

  @override
  String get pickDateFirstRepeat =>
      'Pick a date first to configure repetition.';

  @override
  String get subtasksLabel => 'Subtasks';

  @override
  String subtasksWithCount(int count) {
    return 'Subtasks ($count)';
  }

  @override
  String get removeSubtaskTooltip => 'Remove subtask';

  @override
  String get addSubtaskTooltip => 'Add subtask';

  @override
  String get moveAllOverdueMoved => 'All overdue tasks moved to today';

  @override
  String get moveAllShort => 'Move all';

  @override
  String get noOverdueTasksSubtitle =>
      'All tasks from previous days are completed.';

  @override
  String get repeatingDeletePrompt => 'What would you like to delete?';

  @override
  String get repeatingEditPrompt => 'What would you like to change?';

  @override
  String get repeatingDeleteSingleSub => 'Delete only this occurrence';

  @override
  String get repeatingEditSingleSub => 'Edit only this occurrence';

  @override
  String get repeatingDeleteFollowingSub =>
      'Delete this and all upcoming occurrences';

  @override
  String get repeatingEditFollowingSub =>
      'Apply to this and all upcoming occurrences';

  @override
  String get deviceCalendarTitle => 'Device Calendar';

  @override
  String get selectCalendarsLabel => 'Select Calendars';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '$selected/$total active';
  }

  @override
  String get showCalendarEventsTitle => 'Show Calendar Events';

  @override
  String get showCalendarEventsSubtitle =>
      'Device events appear chronologically as read-only.';

  @override
  String get calendarPermDeniedPermanentTitle =>
      'Calendar Permission Permanently Denied';

  @override
  String get calendarPermRequiredTitle => 'Calendar Read Permission Needed';

  @override
  String get calendarPermDeniedPermanentDesc =>
      'Enable calendar read permission in device Settings, then tap Check Again.';

  @override
  String get calendarPermRequiredDesc =>
      'Zettask only asks for read-only calendar permission to show your events on the timeline.';

  @override
  String get openSettingsButton => 'Open Settings';

  @override
  String get checkAgainButton => 'Check Again';

  @override
  String get noCalendarsFound => 'No calendars found on this device.';

  @override
  String get eventDetailTitle => 'Event Details';

  @override
  String get eventNotesLabel => 'Notes';

  @override
  String get calendarEventReadOnlyBanner =>
      'Event from device calendar (read-only).';

  @override
  String get markUncompletedSemantics => 'Mark incomplete';

  @override
  String get markCompletedSemantics => 'Mark completed';

  @override
  String get deleteNoteTooltip => 'Delete note';

  @override
  String repeatMonthlyDay(int day) {
    return 'Every month · day $day';
  }

  @override
  String get last30DaysSubtitle => 'Last 30 days';

  @override
  String get allTimeSubtitle => 'All time';

  @override
  String get taskCancelled => 'Task marked as cancelled';

  @override
  String get taskRestored => 'Task marked as active';

  @override
  String get cancelledStatusLabel => 'Cancelled';

  @override
  String get restoreTaskLabel => 'Restore';

  @override
  String get markCancelledSemantics => 'Mark cancelled';

  @override
  String get calendarPermFallbackHint =>
      'If the permission prompt did not appear, open App Settings to enable Calendar access manually.';

  @override
  String get calendarBadgeLabel => 'Calendar';

  @override
  String get calendarSourceLabel => 'Calendar';

  @override
  String get calendarLocationLabel => 'Location';

  @override
  String get calendarReadOnlyInfo =>
      'Synced from device calendar. This item is read-only and cannot be edited in Zettask.';
}
