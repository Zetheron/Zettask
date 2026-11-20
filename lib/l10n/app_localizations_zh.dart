// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => '时间线';

  @override
  String get navBoard => '看板';

  @override
  String get navUnplanned => '未安排';

  @override
  String get navMore => '更多';

  @override
  String get save => '保存';

  @override
  String get cancel => '取消';

  @override
  String get close => '关闭';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get undo => '撤销';

  @override
  String get back => '返回';

  @override
  String get retry => '重试';

  @override
  String get clear => '清除';

  @override
  String get all => '全部';

  @override
  String get or => '或';

  @override
  String get continueAction => '继续';

  @override
  String get understand => '知道了';

  @override
  String get useAction => '使用';

  @override
  String get today => '今天';

  @override
  String get tomorrow => '明天';

  @override
  String get yesterday => '昨天';

  @override
  String get toDo => '待办';

  @override
  String get overdue => '已逾期';

  @override
  String get unplanned => '未安排';

  @override
  String get allDay => '全天';

  @override
  String get scheduled => '已安排';

  @override
  String get addTaskToday => '添加今日任务';

  @override
  String get addTask => '添加任务';

  @override
  String get noTasksForDate => '这一天暂无任务。';

  @override
  String get savedToUnplanned => '已保存到未安排';

  @override
  String get savedToUnplannedNoDate => '已保存到未安排（无日期）';

  @override
  String scheduledForDate(String date) {
    return '已安排到 $date';
  }

  @override
  String taskScheduledForDate(String date) {
    return '任务已安排到 $date';
  }

  @override
  String get taskDeleted => '任务已删除';

  @override
  String get searchTasksTooltip => '搜索任务';

  @override
  String get timelineOptionsTooltip => '时间线选项';

  @override
  String get addTaskTooltip => '添加任务';

  @override
  String get completedLabel => '完成';

  @override
  String get uncompleteLabel => '标记未完成';

  @override
  String subtasksCount(int done, int total) {
    return '$done/$total 项子任务';
  }

  @override
  String get repeatingTaskLabel => '重复任务';

  @override
  String get quickAddHint => '添加新任务...';

  @override
  String get expandTooltip => '展开';

  @override
  String get saveTaskTooltip => '保存任务';

  @override
  String get newTask => '新建任务';

  @override
  String get editTask => '编辑任务';

  @override
  String get taskTitleLabel => '任务标题';

  @override
  String get taskTitleHint => '例如：整理迭代笔记';

  @override
  String get taskTitleRequired => '请输入任务标题';

  @override
  String get descriptionLabel => '备注';

  @override
  String get descriptionHint => '添加说明或背景信息...';

  @override
  String get pickDate => '选择日期';

  @override
  String get pickOnCalendar => '从日历选择...';

  @override
  String get noDateUnplanned => '无日期（未安排）';

  @override
  String get noDate => '无日期';

  @override
  String get taskTime => '任务时间';

  @override
  String get changeTime => '修改时间';

  @override
  String get clearTimeAllDay => '清除时间（全天）';

  @override
  String get timeLabel => '时间';

  @override
  String get reminderLabel => '提醒';

  @override
  String get noReminder => '不提醒';

  @override
  String get atTime => '准时';

  @override
  String get minutesBefore10 => '提前10分钟';

  @override
  String get minutesBefore30 => '提前30分钟';

  @override
  String get hourBefore1 => '提前1小时';

  @override
  String get reminderShort10m => '10分钟';

  @override
  String get reminderShort30m => '30分钟';

  @override
  String get reminderShort1h => '1小时';

  @override
  String get projectLabel => '项目';

  @override
  String get noProject => '无项目';

  @override
  String get tagLabel => '标签';

  @override
  String get noTag => '无标签';

  @override
  String get priorityLabel => '优先级';

  @override
  String get priorityLow => '低';

  @override
  String get priorityMedium => '中';

  @override
  String get priorityHigh => '高';

  @override
  String get saveTask => '保存任务';

  @override
  String get saveChanges => '保存更改';

  @override
  String get checklistLabel => '清单';

  @override
  String get addChecklistHint => '添加清单项...';

  @override
  String get repeatLabel => '重复';

  @override
  String get noRepeat => '不重复';

  @override
  String get repeatDaily => '每天';

  @override
  String get repeatWeekly => '每周';

  @override
  String get repeatMonthly => '每月';

  @override
  String get colorLabel => '颜色';

  @override
  String get timelineOptionsTitle => '时间线选项';

  @override
  String get viewModeLabel => '视图模式';

  @override
  String get modeTimeline => '时间线模式';

  @override
  String get modeDaily => '单日模式';

  @override
  String get firstDayOfWeek => '每周起始日';

  @override
  String get monday => '星期一';

  @override
  String get sunday => '星期日';

  @override
  String get firstDayMondayOrder => '一 · 二 · 三 · 四 · 五 · 六 · 日';

  @override
  String get firstDaySundayOrder => '日 · 一 · 二 · 三 · 四 · 五 · 六';

  @override
  String get showCompletedTasks => '显示已完成任务';

  @override
  String get showCompletedTasksSubtitle => '隐藏已完成任务，专注当前待办。';

  @override
  String get showCompletedWorkspaceSubtitle => '显示或隐藏已完成的任务。';

  @override
  String get overdueTasksTitle => '已逾期任务';

  @override
  String get noOverdueTasks => '没有逾期任务';

  @override
  String get moveToToday => '移至今天';

  @override
  String get moveAllToToday => '全部移至今天';

  @override
  String get searchTasksHint => '搜索任务...';

  @override
  String get searchTasksEmpty => '输入关键词搜索任务、备注或清单。';

  @override
  String searchNoResults(String query) {
    return '未找到匹配“$query”的任务。';
  }

  @override
  String get calendarEventReadOnly => '日历日程 · 只读';

  @override
  String get prevWeekTooltip => '上一周';

  @override
  String get nextWeekTooltip => '下一周';

  @override
  String get boardTitle => '看板';

  @override
  String get allProjects => '全部项目';

  @override
  String get searchProjectHint => '搜索项目名称...';

  @override
  String get searchProjectTooltip => '搜索项目';

  @override
  String get closeSearchTooltip => '关闭搜索';

  @override
  String get createProject => '新建项目';

  @override
  String get editProject => '编辑项目';

  @override
  String get deleteProject => '删除项目';

  @override
  String get projectOptionsTooltip => '项目选项';

  @override
  String projectDeleted(String name) {
    return '已删除项目“$name”';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return '已完成 $done/$total';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return '已完成 $done/$total 项任务';
  }

  @override
  String get projectNotFound => '未找到项目';

  @override
  String get noProjectsYet => '暂无项目';

  @override
  String projectSearchEmpty(String query) {
    return '未找到匹配“$query”的项目。';
  }

  @override
  String get noProjectsSubtitle => '点击右下角文件夹按钮创建第一个项目。';

  @override
  String get newProject => '新建项目';

  @override
  String get projectNameLabel => '项目名称';

  @override
  String get projectNameHint => '例如：Zettask 发布';

  @override
  String get projectNameRequired => '请输入项目名称';

  @override
  String get projectColorLabel => '项目颜色';

  @override
  String get unplannedTitle => '未安排';

  @override
  String activeCountLabel(int count) {
    return '$count 项进行中';
  }

  @override
  String get noUnplannedTitle => '暂无未安排任务';

  @override
  String get noUnplannedSubtitle => '点击 + 记录无日期任务。';

  @override
  String get addUnplannedTooltip => '添加未安排任务';

  @override
  String get workspaceTitle => '工作区';

  @override
  String get organizeSection => '整理';

  @override
  String get automationSection => '自动化';

  @override
  String get insightsSection => '统计与个性';

  @override
  String get settingsInfoSection => '设置与信息';

  @override
  String get tagsTitle => '标签';

  @override
  String get tagsSubtitleEmpty => '用于任务和笔记的颜色标签';

  @override
  String tagsCountSubtitle(int count) {
    return '已保存 $count 个标签';
  }

  @override
  String get newTag => '新建标签';

  @override
  String get editTag => '编辑标签';

  @override
  String get tagNameLabel => '标签名称';

  @override
  String get tagNameRequired => '请输入标签名称';

  @override
  String get tagDeleted => '标签已删除';

  @override
  String get noTagsYet => '暂无标签';

  @override
  String tagTasksCount(int count) {
    return '$count 项任务';
  }

  @override
  String get templatesTitle => '模板';

  @override
  String get templatesSubtitleEmpty => '保存可复用的任务与清单结构';

  @override
  String templatesCountSubtitle(int count) {
    return '$count 个可用模板';
  }

  @override
  String get newTemplate => '新建模板';

  @override
  String get editTemplate => '编辑模板';

  @override
  String get templateNameLabel => '模板名称';

  @override
  String get templateNameRequired => '请输入模板名称';

  @override
  String get templateDeleted => '模板已删除';

  @override
  String get noTemplatesYet => '暂无模板';

  @override
  String get taskFromTemplateSaved => '已从模板保存任务';

  @override
  String get notesTitle => '笔记';

  @override
  String get notesSubtitleEmpty => '无日期快速笔记';

  @override
  String notesCountSubtitle(int count) {
    return '已保存 $count 条笔记';
  }

  @override
  String get newNote => '新建笔记';

  @override
  String get editNote => '编辑笔记';

  @override
  String get noteTitleLabel => '笔记标题';

  @override
  String get noteTitleHint => '例如：会议纪要';

  @override
  String get noteTitleRequired => '请输入笔记标题';

  @override
  String get noteContentLabel => '内容';

  @override
  String get noteContentHint => '在此输入笔记...';

  @override
  String get noteDeleted => '笔记已删除';

  @override
  String get searchNotesHint => '搜索笔记...';

  @override
  String get noteNotFound => '未找到笔记';

  @override
  String get noNotesYet => '暂无笔记';

  @override
  String noteSearchEmpty(String query) {
    return '未找到匹配“$query”的笔记。';
  }

  @override
  String get noNotesSubtitle => '点击 + 写下快速笔记。';

  @override
  String get saveNote => '保存笔记';

  @override
  String get repeatingTasksTitle => '重复任务';

  @override
  String get repeatingTasksSubtitleEmpty => '管理每日、每周和每月例程';

  @override
  String repeatingActiveCount(int count) {
    return '$count 个启用例程';
  }

  @override
  String get noRepeatingTasks => '暂无重复任务';

  @override
  String get repeatingActionTitle => '这是一项重复任务';

  @override
  String get repeatingThisOnly => '仅此任务';

  @override
  String get repeatingThisAndFollowing => '此任务及之后所有任务';

  @override
  String get last7DaysUpper => '最近 7 天';

  @override
  String weeklySummary(int tasks, int checklists) {
    return '$tasks 项任务，外加 $checklists 项清单';
  }

  @override
  String get statsTitle => '统计';

  @override
  String get range7Days => '7天';

  @override
  String get range30Days => '30天';

  @override
  String get completedToday => '今日完成';

  @override
  String get last7DaysLabel => '最近 7 天';

  @override
  String get last30DaysLabel => '最近 30 天';

  @override
  String get allTimeLabel => '累计完成';

  @override
  String get completionRateLabel => '完成率';

  @override
  String get activity7Days => '最近 7 天动态';

  @override
  String get activity30Days => '最近 30 天动态';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks 项任务 · $checklists 项清单';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return '$days天总计：$tasks 项任务，外加 $checklists 项清单';
  }

  @override
  String get completedByPriority => '按优先级完成';

  @override
  String get progressByProject => '按项目进度';

  @override
  String get breakdownByTag => '按标签明细';

  @override
  String get habits30Days => '习惯 · 30天';

  @override
  String get noProjectsCreated => '尚未创建项目。';

  @override
  String get noTagsCreated => '尚未创建标签。';

  @override
  String get noActiveHabits => '暂无启用的例程。';

  @override
  String completedCountLabel(int count) {
    return '已完成 $count 项';
  }

  @override
  String tagBreakdownTrailing(int done, int total) {
    return '已完成 $done/$total';
  }

  @override
  String habitCompletedRatio(String summary, int done, int scheduled) {
    return '$summary · 已完成 $done/$scheduled';
  }

  @override
  String statsSubtitle(int completed, int percent) {
    return '已完成 $completed 项 · 完成率 $percent%';
  }

  @override
  String get themeTitle => '主题';

  @override
  String get themeAndColorsTitle => '主题与配色';

  @override
  String get livePreviewSection => '实时预览';

  @override
  String get appearanceModeSection => '外观模式';

  @override
  String get colorPaletteSection => '配色方案';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeSystemLight => '系统（浅色）';

  @override
  String get themeSystemDark => '系统（深色）';

  @override
  String get presetDefault => '默认';

  @override
  String get presetDefaultDesc => '靛蓝与石板灰';

  @override
  String get presetOcean => '海洋';

  @override
  String get presetOceanDesc => '宁静蓝';

  @override
  String get presetForest => '森林';

  @override
  String get presetForestDesc => '鼠尾草与祖母绿';

  @override
  String get presetTerracotta => '陶土';

  @override
  String get presetTerracottaDesc => '温暖砖橙';

  @override
  String get presetPlum => '梅紫';

  @override
  String get presetPlumDesc => '柔和紫';

  @override
  String get presetMonochrome => '单色';

  @override
  String get presetMonochromeDesc => '炭灰与纯黑';

  @override
  String get previewActiveTask => '评审界面设计';

  @override
  String get previewCompletedTask => '同步本周日程';

  @override
  String get languageTitle => '语言';

  @override
  String get deviceLanguageOption => '设备语言（若支持）';

  @override
  String get appLockTitle => '应用锁';

  @override
  String get appLockSubtitle => '指纹、面部或设备 PIN 码';

  @override
  String get appLockLockedTitle => 'Zettask 已锁定';

  @override
  String get appLockLockedSubtitle => '请使用指纹、面部或设备 PIN 码解锁。';

  @override
  String get unlockButton => '解锁';

  @override
  String get verifyingButton => '验证中...';

  @override
  String get appLockUnsupportedError => '此设备未启用生物识别或锁屏 PIN 码。';

  @override
  String get appLockCancelledError => '验证已取消或失败。';

  @override
  String get appLockUnlockFailedError => '验证失败，请点击解锁重试。';

  @override
  String get calendarSyncTitle => '日历同步';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return '已开启 · $count 个日历';
  }

  @override
  String get calendarSyncInactiveSubtitle => '已关闭 · 仅以只读方式显示日程';

  @override
  String get grantCalendarPermission => '授予日历权限';

  @override
  String get exportCsvTitle => '导出 CSV';

  @override
  String get exportCsvSubtitle => '将任务或笔记导出为 CSV 分享';

  @override
  String get exportDataCsvTitle => '导出 CSV 数据';

  @override
  String get exportTasksTitle => '导出任务';

  @override
  String get exportTasksSubtitle => '所有已安排、未安排和项目任务';

  @override
  String get exportNotesTitle => '导出笔记';

  @override
  String get exportNotesSubtitle => '全部快速笔记';

  @override
  String get exportBothTitle => '全部导出';

  @override
  String get exportBothSubtitle => '同时导出任务与笔记 CSV 文件';

  @override
  String get aboutPrivacyTitle => '关于与隐私政策';

  @override
  String aboutPrivacySubtitle(String version) {
    return '版本 $version · 本地优先与可选云同步';
  }

  @override
  String get aboutTitle => '关于 Zettask';

  @override
  String versionLabel(String version) {
    return '版本 $version';
  }

  @override
  String get privacySyncTitle => '隐私与同步';

  @override
  String get privacySyncDescription =>
      '默认情况下数据仅保存在本地设备。登录后可选择开启 Firebase 云同步，您可随时永久删除账号及所有云端数据。';

  @override
  String get privacyPolicyLabel => '隐私政策';

  @override
  String get privacyLinkCopied => '隐私政策链接已复制';

  @override
  String get accountAndSyncTitle => '账号与同步';

  @override
  String get signInToZettask => '登录 Zettask 账号';

  @override
  String get accountBannerSubtitle => '可选 · 云端备份与多设备同步';

  @override
  String get authWelcomeTitle => '保存您的进度与任务';

  @override
  String get authWelcomeSubtitle => '自动将日程、项目和笔记备份至云端。不登录也可继续在本地使用 Zettask。';

  @override
  String get createNewAccount => '创建新账号';

  @override
  String get signIn => '登录';

  @override
  String get continueWithGoogle => '使用 Google 继续';

  @override
  String get authTermsNotice => '继续即表示您同意 Zettask 的条款与隐私政策。';

  @override
  String get signInToAccountTitle => '登录 Zettask';

  @override
  String get signInToAccountSubtitle => '本地数据将与云端备份安全合并。';

  @override
  String get emailLabel => '邮箱';

  @override
  String get emailHint => 'name@email.com';

  @override
  String get emailRequired => '请输入邮箱。';

  @override
  String get emailInvalid => '邮箱格式不正确。';

  @override
  String get passwordLabel => '密码';

  @override
  String get passwordHint => '请输入密码';

  @override
  String get passwordNewHint => '至少 6 位字符';

  @override
  String get passwordRequired => '请输入密码。';

  @override
  String get passwordTooShort => '密码至少需要 6 位字符。';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get enterValidEmailFirst => '请先输入有效的邮箱地址。';

  @override
  String passwordResetSent(String email) {
    return '重置密码链接已发送至 $email。';
  }

  @override
  String get showPasswordTooltip => '显示密码';

  @override
  String get hidePasswordTooltip => '隐藏密码';

  @override
  String get noAccountPrompt => '还没有账号？';

  @override
  String get createAccountLink => '创建账号';

  @override
  String get createAccountTitle => '创建账号';

  @override
  String get createAccountSubtitle => '将全部任务、例程和笔记备份到云端。';

  @override
  String get haveAccountPrompt => '已有账号？';

  @override
  String signedInVia(String provider) {
    return '通过 $provider 登录';
  }

  @override
  String get syncNowButton => '立即同步';

  @override
  String get syncingLabel => '同步中...';

  @override
  String get syncDoneMessage => '同步完成。';

  @override
  String get syncFailedMessage => '同步失败，请检查网络连接。';

  @override
  String get syncStatusIdle => '尚未同步';

  @override
  String get syncStatusSyncing => '同步中...';

  @override
  String get syncStatusSynced => '已同步';

  @override
  String get syncStatusError => '同步失败';

  @override
  String lastSyncedPrefix(String time) {
    return '上次同步：$time';
  }

  @override
  String get neverSynced => '从未同步';

  @override
  String get signOutButton => '退出登录';

  @override
  String get signedOutMessage => '已退出登录，本地数据仍保存在设备中。';

  @override
  String get deleteAccountButton => '删除账号';

  @override
  String get deleteAccountStep1Title => '删除账号？';

  @override
  String get deleteAccountStep1Body => '所有云端备份及您的账号将被永久删除。设备上的本地数据不会受影响。';

  @override
  String get deleteAccountStep2Title => '确认永久删除';

  @override
  String get deleteAccountStep2Body => '此操作无法撤销。确定立即永久删除账号及所有云端数据吗？';

  @override
  String get deleteAccountConfirmButton => '确认永久删除';

  @override
  String get accountDeletedMessage => '账号及全部云端数据已永久删除。';

  @override
  String get reloginRequiredTitle => '需要重新登录';

  @override
  String get authErrUserNotFound => '未找到该邮箱对应的账号。';

  @override
  String get authErrWrongPassword => '密码错误。';

  @override
  String get authErrInvalidCredential => '邮箱或密码无效。';

  @override
  String get authErrInvalidEmail => '邮箱格式不正确。';

  @override
  String get authErrEmailInUse => '该邮箱已被其他账号注册。';

  @override
  String get authErrWeakPassword => '密码强度不足，请至少使用 6 位字符。';

  @override
  String get authErrNetwork => '网络异常，请检查网络连接。';

  @override
  String get authErrRequiresRecentLogin => '出于安全考虑，请先退出并重新登录后再删除账号。';

  @override
  String get authErrTooManyRequests => '尝试次数过多，请稍后再试。';

  @override
  String get authErrUserDisabled => '此账号已被停用。';

  @override
  String get authErrAccountExistsDifferent => '该邮箱已关联其他登录方式。';

  @override
  String get authErrOperationNotAllowed => '未启用此登录方式。';

  @override
  String get authErrFirebaseUnavailable => '账号服务当前不可用。';

  @override
  String get authErrUnknown => '身份验证出错，请重试。';

  @override
  String get widgetTitle => 'Zettask · 今日';

  @override
  String get widgetEmptyText => '今日任务已全部完成。';

  @override
  String get repeatingTasksAndFollowingDeleted => '已删除重复任务及后续日程';

  @override
  String get noProjectTasksTitle => '此项目中暂无任务';

  @override
  String noProjectTasksSubtitle(String project) {
    return '点击 + 向 $project 添加任务。';
  }

  @override
  String get addTaskToProjectTooltip => '添加项目任务';

  @override
  String get noTagsSubtitle => '点击 + 为任务和笔记创建颜色标签。';

  @override
  String get tagOptionsTooltip => '标签选项';

  @override
  String get deleteTag => '删除标签';

  @override
  String get addTagTooltip => '添加标签';

  @override
  String get noTasksWithTag => '暂无使用此标签的任务。';

  @override
  String get addTaskWithTagTooltip => '添加带标签任务';

  @override
  String get tagNameHint => '例如：工作、个人、紧急';

  @override
  String get tagColorLabel => '标签颜色';

  @override
  String get createTag => '创建标签';

  @override
  String tagDeletedNamed(String name) {
    return '已删除标签“$name”';
  }

  @override
  String get noTemplatesSubtitle => '保存常用任务和清单结构，方便快速创建。';

  @override
  String get templateOptionsTooltip => '模板选项';

  @override
  String get deleteTemplate => '删除模板';

  @override
  String get createTemplateTooltip => '创建模板';

  @override
  String templateDeletedNamed(String name) {
    return '已删除模板“$name”';
  }

  @override
  String get templateNameHint => '例如：每周发布';

  @override
  String get defaultTaskTitleLabel => '默认任务标题';

  @override
  String get defaultTaskTitleHint => '例如：准备正式发布';

  @override
  String get timeOptionalLabel => '时间（可选）';

  @override
  String get clearTimeTooltip => '清除时间';

  @override
  String get projectOptionalLabel => '项目（可选）';

  @override
  String get tagOptionalLabel => '标签（可选）';

  @override
  String get defaultSubtasksLabel => '默认子任务';

  @override
  String get addTemplateSubtaskHint => '添加模板子任务...';

  @override
  String get saveTemplate => '保存模板';

  @override
  String subtasksTotalCount(int count) {
    return '$count 个子任务';
  }

  @override
  String get useTemplateButton => '使用模板';

  @override
  String get pickTemplateTitle => '选择模板';

  @override
  String get repeatingTaskDeleted => '已删除重复任务';

  @override
  String get noRepeatingTasksSubtitle => '点击 + 创建每日、每周或每月的习惯日程。';

  @override
  String get addRepeatingTaskTooltip => '添加重复任务';

  @override
  String get editRepeatingTask => '编辑重复任务';

  @override
  String get newRepeatingTask => '新建重复任务';

  @override
  String get deleteTaskTooltip => '删除任务';

  @override
  String get scheduleLabel => '日程';

  @override
  String get startAndTimeLabel => '开始日期与时间';

  @override
  String get dateRequiredForTime => '需选日期';

  @override
  String get clearDateTooltip => '清除日期';

  @override
  String get pickTimeFirstReminder => '请先选择时间以启用提醒。';

  @override
  String get notificationPermissionDenied => '通知权限未开启，请在设备设置中允许以接收提醒。';

  @override
  String get pickDateFirstRepeat => '请先选择日期以设置重复。';

  @override
  String get subtasksLabel => '子任务';

  @override
  String subtasksWithCount(int count) {
    return '子任务（$count）';
  }

  @override
  String get removeSubtaskTooltip => '删除子任务';

  @override
  String get addSubtaskTooltip => '添加子任务';

  @override
  String get moveAllOverdueMoved => '已将所有逾期任务移至今天';

  @override
  String get moveAllShort => '全部移至今天';

  @override
  String get noOverdueTasksSubtitle => '之前的所有任务都已完成。';

  @override
  String get repeatingDeletePrompt => '要删除哪些内容？';

  @override
  String get repeatingEditPrompt => '要修改哪些内容？';

  @override
  String get repeatingDeleteSingleSub => '仅删除此次日程';

  @override
  String get repeatingEditSingleSub => '仅修改此次日程';

  @override
  String get repeatingDeleteFollowingSub => '删除此次及所有后续日程';

  @override
  String get repeatingEditFollowingSub => '应用于此次及所有后续日程';

  @override
  String get deviceCalendarTitle => '设备日历';

  @override
  String get selectCalendarsLabel => '选择日历';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '已启用 $selected/$total';
  }

  @override
  String get showCalendarEventsTitle => '显示日历日程';

  @override
  String get showCalendarEventsSubtitle => '以只读方式按时间顺序显示设备日历日程。';

  @override
  String get calendarPermDeniedPermanentTitle => '日历权限已被永久拒绝';

  @override
  String get calendarPermRequiredTitle => '需要日历读取权限';

  @override
  String get calendarPermDeniedPermanentDesc => '请在设备设置中开启日历读取权限，然后点击“重新检查”。';

  @override
  String get calendarPermRequiredDesc => 'Zettask 仅申请只读日历权限，用于在时间轴展示您的日程。';

  @override
  String get openSettingsButton => '打开设置';

  @override
  String get checkAgainButton => '重新检查';

  @override
  String get noCalendarsFound => '未在此设备上找到日历。';

  @override
  String get eventDetailTitle => '日程详情';

  @override
  String get eventNotesLabel => '备注';

  @override
  String get calendarEventReadOnlyBanner => '来自设备日历的日程（只读）。';

  @override
  String get markUncompletedSemantics => '标记为未完成';

  @override
  String get markCompletedSemantics => '标记为已完成';

  @override
  String get deleteNoteTooltip => '删除笔记';

  @override
  String repeatMonthlyDay(int day) {
    return '每月 · $day日';
  }

  @override
  String get last30DaysSubtitle => '过去 30 天';

  @override
  String get allTimeSubtitle => '全部时间';

  @override
  String get taskCancelled => '任务已标记为取消';

  @override
  String get taskRestored => '任务已恢复为进行中';

  @override
  String get cancelledStatusLabel => '已取消';

  @override
  String get restoreTaskLabel => '恢复';

  @override
  String get markCancelledSemantics => '标记为已取消';

  @override
  String get calendarPermFallbackHint => '如果未弹出权限提示，请打开应用设置手动启用日历访问权限。';

  @override
  String get calendarBadgeLabel => '日历';

  @override
  String get calendarSourceLabel => '日历';

  @override
  String get calendarLocationLabel => '地点';

  @override
  String get calendarReadOnlyInfo => '已从设备日历同步。此项目为只读，无法在 Zettask 中编辑。';

  @override
  String get proBrandTitle => 'Zettask Pro';

  @override
  String get proBadge => 'PRO';

  @override
  String get proPaywallSubtitle => '云端同步、设备日历、应用锁与 OLED 纯黑主题一站式体验。';

  @override
  String proActiveBannerTitle(String plan) {
    return '已开通 — $plan';
  }

  @override
  String get proActiveBannerSubtitle => '感谢你支持 Zettask。';

  @override
  String get proUpgradeBannerSubtitle => 'AMOLED 主题、自定义强调色、小组件样式等';

  @override
  String get proBenefitCloudSync => '云端同步与多设备支持';

  @override
  String get proBenefitCalendar => '日历集成与法定节假日';

  @override
  String get proBenefitAppLock => '生物识别应用锁与最近任务隐私保护';

  @override
  String get proBenefitProjectsCsv => '无限项目与 CSV 导出';

  @override
  String get proBenefitCustomization => 'AMOLED 纯黑主题、自定义强调色与小组件样式';

  @override
  String get proPlanMonthlyTitle => '按月订阅';

  @override
  String get proPlanMonthlyPrice => '\$1.99 / 月';

  @override
  String get proPlanYearlyTitle => '按年订阅';

  @override
  String get proPlanYearlyPrice => '\$12.99 / 年';

  @override
  String get proPlanYearlyBadge => '最划算';

  @override
  String get proPlanYearlySavings => '立省约 43%';

  @override
  String get proPlanLifetimeTitle => '终身版';

  @override
  String get proPlanLifetimePrice => '\$29.99';

  @override
  String get proPlanLifetimeBadge => '一次付费';

  @override
  String get proContinueButton => '继续';

  @override
  String get proAlreadyActiveButton => 'Zettask Pro 已激活';

  @override
  String get proRestorePurchasesButton => '恢复购买';

  @override
  String get proLegalFootnote => '订阅到期将自动续费，除非提前取消。可随时在 Google Play 中取消。';

  @override
  String get proStoreUnavailableMessage =>
      '当前设备暂不支持 Google Play 结算，请连接 Google Play 后重试。';

  @override
  String get proPurchaseSuccessMessage => 'Zettask Pro 已激活。';

  @override
  String get proRestoreSuccessMessage => '已恢复你的 Zettask Pro 购买记录。';

  @override
  String get proRestoreEmptyMessage => '未在此账号找到有效的 Zettask Pro 购买记录。';

  @override
  String get proPurchaseFailedMessage => '暂时无法完成购买，请重试。';

  @override
  String get debugProSimulationLabel => '开发者模式：模拟 Pro';

  @override
  String get amoledPureBlackTitle => 'AMOLED 纯黑';

  @override
  String get amoledPureBlackSubtitle => '纯黑 #000000 深色背景，更适合 OLED 屏幕省电';

  @override
  String get customAccentSection => '自定义强调色';

  @override
  String get accentMonochrome => '单色';

  @override
  String get accentSage => '鼠尾草绿';

  @override
  String get accentIndigo => '靛蓝';

  @override
  String get accentTerracotta => '陶土橙';

  @override
  String get accentAmber => '琥珀金';

  @override
  String get widgetStyleSection => '主屏幕小组件样式';

  @override
  String get widgetStyleStandard => '标准';

  @override
  String get widgetStyleAmoled => 'AMOLED';

  @override
  String get widgetStyleTranslucent => '半透明';

  @override
  String get proContextUnlimitedProjects =>
      '免费版最多可创建 3 个项目。升级至 Zettask Pro 可创建无限项目。';

  @override
  String get proContextCalendarSync => '设备日历同步与法定节假日包含在 Zettask Pro 中。';

  @override
  String get proContextAppLock => '生物识别应用锁与最近任务隐私保护包含在 Zettask Pro 中。';

  @override
  String get proContextCsvExport => '任务与笔记 CSV 导出包含在 Zettask Pro 中。';

  @override
  String get proContextCloudSync => '多设备云端同步包含在 Zettask Pro 中。';

  @override
  String get proContextCustomThemes => 'AMOLED 纯黑主题与自定义强调色包含在 Zettask Pro 中。';

  @override
  String get proContextWidgetStyles => 'AMOLED 与半透明主屏幕小组件样式包含在 Zettask Pro 中。';

  @override
  String get cloudSyncPausedShort => '云端同步已暂停 · 本地数据安全';

  @override
  String get cloudSyncPausedTitle => '云端同步已暂停';

  @override
  String get cloudSyncPausedBody => '你的 Zettask Pro 订阅未激活。本地任务和笔记仍安全保存在此设备上。';

  @override
  String get resumeSyncWithProButton => '使用 Pro 恢复同步';
}
