// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => 'タイムライン';

  @override
  String get navBoard => 'ボード';

  @override
  String get navUnplanned => '未設定';

  @override
  String get navMore => 'その他';

  @override
  String get save => '保存';

  @override
  String get cancel => 'キャンセル';

  @override
  String get close => '閉じる';

  @override
  String get delete => '削除';

  @override
  String get edit => '編集';

  @override
  String get undo => '元に戻す';

  @override
  String get back => '戻る';

  @override
  String get retry => '再試行';

  @override
  String get clear => 'クリア';

  @override
  String get all => 'すべて';

  @override
  String get or => 'または';

  @override
  String get continueAction => '続行';

  @override
  String get understand => '了解';

  @override
  String get useAction => '使用';

  @override
  String get today => '今日';

  @override
  String get tomorrow => '明日';

  @override
  String get yesterday => '昨日';

  @override
  String get toDo => '未完了';

  @override
  String get overdue => '期限切れ';

  @override
  String get unplanned => '未設定';

  @override
  String get allDay => '終日';

  @override
  String get scheduled => '予定あり';

  @override
  String get addTaskToday => '今日のタスクを追加';

  @override
  String get addTask => 'タスクを追加';

  @override
  String get noTasksForDate => 'この日のタスクはありません。';

  @override
  String get savedToUnplanned => '未設定に保存しました';

  @override
  String get savedToUnplannedNoDate => '未設定（日付なし）に保存しました';

  @override
  String scheduledForDate(String date) {
    return '$date に予定しました';
  }

  @override
  String taskScheduledForDate(String date) {
    return 'タスクを $date に予定しました';
  }

  @override
  String get taskDeleted => 'タスクを削除しました';

  @override
  String get searchTasksTooltip => 'タスクを検索';

  @override
  String get timelineOptionsTooltip => 'タイムライン設定';

  @override
  String get addTaskTooltip => 'タスクを追加';

  @override
  String get completedLabel => '完了';

  @override
  String get uncompleteLabel => '未完了に戻す';

  @override
  String subtasksCount(int done, int total) {
    return '$done/$total サブタスク';
  }

  @override
  String get repeatingTaskLabel => '繰り返しタスク';

  @override
  String get quickAddHint => '新しいタスクを追加...';

  @override
  String get expandTooltip => '詳細を開く';

  @override
  String get saveTaskTooltip => 'タスクを保存';

  @override
  String get newTask => '新しいタスク';

  @override
  String get editTask => 'タスクを編集';

  @override
  String get taskTitleLabel => 'タスク名';

  @override
  String get taskTitleHint => '例：スプリントメモを確認';

  @override
  String get taskTitleRequired => 'タスク名を入力してください';

  @override
  String get descriptionLabel => '説明';

  @override
  String get descriptionHint => 'メモや詳細を追加...';

  @override
  String get pickDate => '日付を選択';

  @override
  String get pickOnCalendar => 'カレンダーから選択...';

  @override
  String get noDateUnplanned => '日付なし（未設定）';

  @override
  String get noDate => '日付なし';

  @override
  String get taskTime => '時刻';

  @override
  String get changeTime => '時刻を変更';

  @override
  String get clearTimeAllDay => '時刻をクリア（終日）';

  @override
  String get timeLabel => '時刻';

  @override
  String get reminderLabel => 'リマインダー';

  @override
  String get noReminder => 'リマインダーなし';

  @override
  String get atTime => '時間通り';

  @override
  String get minutesBefore10 => '10分前';

  @override
  String get minutesBefore30 => '30分前';

  @override
  String get hourBefore1 => '1時間前';

  @override
  String get reminderShort10m => '10分前';

  @override
  String get reminderShort30m => '30分前';

  @override
  String get reminderShort1h => '1時間前';

  @override
  String get projectLabel => 'プロジェクト';

  @override
  String get noProject => 'プロジェクトなし';

  @override
  String get tagLabel => 'タグ';

  @override
  String get noTag => 'タグなし';

  @override
  String get priorityLabel => '優先度';

  @override
  String get priorityLow => '低';

  @override
  String get priorityMedium => '中';

  @override
  String get priorityHigh => '高';

  @override
  String get saveTask => 'タスクを保存';

  @override
  String get saveChanges => '変更を保存';

  @override
  String get checklistLabel => 'チェックリスト';

  @override
  String get addChecklistHint => '項目を追加...';

  @override
  String get repeatLabel => '繰り返し';

  @override
  String get noRepeat => '繰り返さない';

  @override
  String get repeatDaily => '毎日';

  @override
  String get repeatWeekly => '毎週';

  @override
  String get repeatMonthly => '毎月';

  @override
  String get colorLabel => 'カラー';

  @override
  String get timelineOptionsTitle => 'タイムライン設定';

  @override
  String get viewModeLabel => '表示モード';

  @override
  String get modeTimeline => 'タイムライン';

  @override
  String get modeDaily => '日別表示';

  @override
  String get firstDayOfWeek => '週の開始曜日';

  @override
  String get monday => '月曜日';

  @override
  String get sunday => '日曜日';

  @override
  String get firstDayMondayOrder => '月 · 火 · 水 · 木 · 金 · 土 · 日';

  @override
  String get firstDaySundayOrder => '日 · 月 · 火 · 水 · 木 · 金 · 土';

  @override
  String get showCompletedTasks => '完了タスクを表示';

  @override
  String get showCompletedTasksSubtitle => '完了済みタスクを隠して進行中に集中できます。';

  @override
  String get showCompletedWorkspaceSubtitle => '完了済みタスクの表示を切り替えます。';

  @override
  String get overdueTasksTitle => '期限切れのタスク';

  @override
  String get noOverdueTasks => '期限切れのタスクはありません';

  @override
  String get moveToToday => '今日に移動';

  @override
  String get moveAllToToday => 'すべて今日に移動';

  @override
  String get searchTasksHint => 'タスクを検索...';

  @override
  String get searchTasksEmpty => 'タスク名・説明・チェックリストを検索できます。';

  @override
  String searchNoResults(String query) {
    return '「$query」に一致するタスクはありません。';
  }

  @override
  String get calendarEventReadOnly => 'カレンダー予定 · 読み取り専用';

  @override
  String get prevWeekTooltip => '前の週';

  @override
  String get nextWeekTooltip => '次の週';

  @override
  String get boardTitle => 'ボード';

  @override
  String get allProjects => 'すべてのプロジェクト';

  @override
  String get searchProjectHint => 'プロジェクトを検索...';

  @override
  String get searchProjectTooltip => 'プロジェクトを検索';

  @override
  String get closeSearchTooltip => '検索を閉じる';

  @override
  String get createProject => 'プロジェクト作成';

  @override
  String get editProject => 'プロジェクトを編集';

  @override
  String get deleteProject => 'プロジェクトを削除';

  @override
  String get projectOptionsTooltip => 'プロジェクト設定';

  @override
  String projectDeleted(String name) {
    return 'プロジェクト「$name」を削除しました';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return '$done/$total 完了';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return '$done/$total 件完了';
  }

  @override
  String get projectNotFound => 'プロジェクトが見つかりません';

  @override
  String get noProjectsYet => 'プロジェクトはまだありません';

  @override
  String projectSearchEmpty(String query) {
    return '「$query」に一致するプロジェクトはありません。';
  }

  @override
  String get noProjectsSubtitle => '下のフォルダボタンから最初のプロジェクトを作成しましょう。';

  @override
  String get newProject => '新規プロジェクト';

  @override
  String get projectNameLabel => 'プロジェクト名';

  @override
  String get projectNameHint => '例：Zettask リリース';

  @override
  String get projectNameRequired => 'プロジェクト名を入力してください';

  @override
  String get projectColorLabel => 'プロジェクトカラー';

  @override
  String get unplannedTitle => '未設定';

  @override
  String activeCountLabel(int count) {
    return '$count 件進行中';
  }

  @override
  String get noUnplannedTitle => '未設定のタスクはありません';

  @override
  String get noUnplannedSubtitle => '+ をタップして日付なしのタスクを追加できます。';

  @override
  String get addUnplannedTooltip => '未設定タスクを追加';

  @override
  String get workspaceTitle => 'ワークスペース';

  @override
  String get organizeSection => '整理';

  @override
  String get automationSection => '自動化';

  @override
  String get insightsSection => '統計とカスタマイズ';

  @override
  String get settingsInfoSection => '設定と情報';

  @override
  String get tagsTitle => 'タグ';

  @override
  String get tagsSubtitleEmpty => 'タスクやメモ用のカラーラベル';

  @override
  String tagsCountSubtitle(int count) {
    return '$count 件のタグ';
  }

  @override
  String get newTag => '新規タグ';

  @override
  String get editTag => 'タグを編集';

  @override
  String get tagNameLabel => 'タグ名';

  @override
  String get tagNameRequired => 'タグ名を入力してください';

  @override
  String get tagDeleted => 'タグを削除しました';

  @override
  String get noTagsYet => 'タグはまだありません';

  @override
  String tagTasksCount(int count) {
    return '$count 件';
  }

  @override
  String get templatesTitle => 'テンプレート';

  @override
  String get templatesSubtitleEmpty => 'よく使うタスク構成を保存';

  @override
  String templatesCountSubtitle(int count) {
    return '$count 件のテンプレート';
  }

  @override
  String get newTemplate => '新規テンプレート';

  @override
  String get editTemplate => 'テンプレート編集';

  @override
  String get templateNameLabel => 'テンプレート名';

  @override
  String get templateNameRequired => 'テンプレート名を入力してください';

  @override
  String get templateDeleted => 'テンプレートを削除しました';

  @override
  String get noTemplatesYet => 'テンプレートはまだありません';

  @override
  String get taskFromTemplateSaved => 'テンプレートからタスクを保存しました';

  @override
  String get notesTitle => 'メモ';

  @override
  String get notesSubtitleEmpty => '日付なしのクイックメモ';

  @override
  String notesCountSubtitle(int count) {
    return '$count 件のメモ';
  }

  @override
  String get newNote => '新規メモ';

  @override
  String get editNote => 'メモを編集';

  @override
  String get noteTitleLabel => 'タイトル';

  @override
  String get noteTitleHint => '例：会議メモ';

  @override
  String get noteTitleRequired => 'タイトルを入力してください';

  @override
  String get noteContentLabel => '内容';

  @override
  String get noteContentHint => 'ここにメモを入力...';

  @override
  String get noteDeleted => 'メモを削除しました';

  @override
  String get searchNotesHint => 'メモを検索...';

  @override
  String get noteNotFound => 'メモが見つかりません';

  @override
  String get noNotesYet => 'メモはまだありません';

  @override
  String noteSearchEmpty(String query) {
    return '「$query」に一致するメモはありません。';
  }

  @override
  String get noNotesSubtitle => '+ をタップしてメモを追加できます。';

  @override
  String get saveNote => 'メモを保存';

  @override
  String get repeatingTasksTitle => '繰り返しタスク';

  @override
  String get repeatingTasksSubtitleEmpty => '毎日・毎週・毎月のルーティンを管理';

  @override
  String repeatingActiveCount(int count) {
    return '$count 件のルーティン';
  }

  @override
  String get noRepeatingTasks => '繰り返しタスクはありません';

  @override
  String get repeatingActionTitle => '繰り返しタスクの操作';

  @override
  String get repeatingThisOnly => 'このタスクのみ';

  @override
  String get repeatingThisAndFollowing => 'このタスクと今後のすべて';

  @override
  String get last7DaysUpper => '過去7日間';

  @override
  String weeklySummary(int tasks, int checklists) {
    return 'タスク $tasks 件、チェックリスト $checklists 件';
  }

  @override
  String get statsTitle => '統計';

  @override
  String get range7Days => '7日間';

  @override
  String get range30Days => '30日間';

  @override
  String get completedToday => '今日の完了';

  @override
  String get last7DaysLabel => '過去7日間';

  @override
  String get last30DaysLabel => '過去30日間';

  @override
  String get allTimeLabel => '累計完了';

  @override
  String get completionRateLabel => '完了率';

  @override
  String get activity7Days => '過去7日間のアクティビティ';

  @override
  String get activity30Days => '過去30日間のアクティビティ';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks タスク · $checklists 項目';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return '$days日間合計：$tasks タスク、$checklists チェックリスト項目';
  }

  @override
  String get completedByPriority => '優先度別の完了数';

  @override
  String get progressByProject => 'プロジェクト別進捗';

  @override
  String get breakdownByTag => 'タグ別内訳';

  @override
  String get habits30Days => '習慣（Habits）· 30日間';

  @override
  String get noProjectsCreated => 'プロジェクトがまだありません。';

  @override
  String get noTagsCreated => 'タグがまだありません。';

  @override
  String get noActiveHabits => '進行中のルーティンはありません。';

  @override
  String completedCountLabel(int count) {
    return '$count 件完了';
  }

  @override
  String tagBreakdownTrailing(int done, int total) {
    return '$done/$total 完了';
  }

  @override
  String habitCompletedRatio(String summary, int done, int scheduled) {
    return '$summary · $done/$scheduled 完了';
  }

  @override
  String statsSubtitle(int completed, int percent) {
    return '$completed 件完了 · 完了率 $percent%';
  }

  @override
  String get themeTitle => 'テーマ';

  @override
  String get themeAndColorsTitle => 'テーマとカラー';

  @override
  String get livePreviewSection => 'ライブプレビュー';

  @override
  String get appearanceModeSection => '外観モード';

  @override
  String get colorPaletteSection => 'カラーパレット';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get themeSystem => 'システム';

  @override
  String get themeSystemLight => 'システム（ライト）';

  @override
  String get themeSystemDark => 'システム（ダーク）';

  @override
  String get presetDefault => 'デフォルト';

  @override
  String get presetDefaultDesc => 'インディゴ＆スレート';

  @override
  String get presetOcean => 'オーシャン';

  @override
  String get presetOceanDesc => '落ち着いたブルー';

  @override
  String get presetForest => 'フォレスト';

  @override
  String get presetForestDesc => 'セージ＆エメラルド';

  @override
  String get presetTerracotta => 'テラコッタ';

  @override
  String get presetTerracottaDesc => '温かみのあるオレンジ';

  @override
  String get presetPlum => 'プラム';

  @override
  String get presetPlumDesc => '穏やかなパープル';

  @override
  String get presetMonochrome => 'モノクロ';

  @override
  String get presetMonochromeDesc => 'チャコール＆ブラック';

  @override
  String get previewActiveTask => 'UIデザインを確認';

  @override
  String get previewCompletedTask => '週間スケジュールを同期';

  @override
  String get languageTitle => '言語';

  @override
  String get deviceLanguageOption => '端末の言語（対応時）';

  @override
  String get appLockTitle => 'アプリロック';

  @override
  String get appLockSubtitle => '指紋・顔認証または端末のPIN';

  @override
  String get appLockLockedTitle => 'Zettask はロック中';

  @override
  String get appLockLockedSubtitle => '指紋・顔認証または端末のPINでロックを解除してください。';

  @override
  String get unlockButton => 'ロック解除';

  @override
  String get verifyingButton => '確認中...';

  @override
  String get appLockUnsupportedError => 'この端末では生体認証または画面ロックが設定されていません。';

  @override
  String get appLockCancelledError => '認証がキャンセルまたは失敗しました。';

  @override
  String get appLockUnlockFailedError => '認証に失敗しました。「ロック解除」をタップして再試行してください。';

  @override
  String get calendarSyncTitle => 'カレンダー同期';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return 'オン · $count 件のカレンダー';
  }

  @override
  String get calendarSyncInactiveSubtitle => 'オフ · 端末の予定を読み取り専用で表示';

  @override
  String get grantCalendarPermission => 'カレンダー権限を許可';

  @override
  String get exportCsvTitle => 'CSVエクスポート';

  @override
  String get exportCsvSubtitle => 'タスクやメモをCSV形式で共有';

  @override
  String get exportDataCsvTitle => 'CSVデータをエクスポート';

  @override
  String get exportTasksTitle => 'タスクをエクスポート';

  @override
  String get exportTasksSubtitle => '予定済み・未設定・プロジェクトの全タスク';

  @override
  String get exportNotesTitle => 'メモをエクスポート';

  @override
  String get exportNotesSubtitle => 'すべてのクイックメモ';

  @override
  String get exportBothTitle => '両方エクスポート';

  @override
  String get exportBothSubtitle => 'タスクとメモのCSVをまとめて出力';

  @override
  String get aboutPrivacyTitle => 'アプリ情報とプライバシー';

  @override
  String aboutPrivacySubtitle(String version) {
    return 'バージョン $version · オフライン優先＆任意クラウド';
  }

  @override
  String get aboutTitle => 'Zettask について';

  @override
  String versionLabel(String version) {
    return 'バージョン $version';
  }

  @override
  String get privacySyncTitle => 'プライバシーと同期';

  @override
  String get privacySyncDescription =>
      'データは標準で端末内に保存されます。サインイン時はFirebaseクラウド同期を任意で利用でき、アカウントとクラウドデータはいつでも完全削除できます。';

  @override
  String get privacyPolicyLabel => 'プライバシーポリシー';

  @override
  String get privacyLinkCopied => 'リンクをコピーしました';

  @override
  String get accountAndSyncTitle => 'アカウントと同期';

  @override
  String get signInToZettask => 'Zettaskアカウントにログイン';

  @override
  String get accountBannerSubtitle => '任意 · クラウドにバックアップ＆同期';

  @override
  String get authWelcomeTitle => '進捗とタスクを安全に保存';

  @override
  String get authWelcomeSubtitle =>
      '予定・プロジェクト・メモをクラウドに自動バックアップ。アカウントなしでもローカルでそのまま使えます。';

  @override
  String get createNewAccount => '新しいアカウントを作成';

  @override
  String get signIn => 'ログイン';

  @override
  String get continueWithGoogle => 'Googleで続行';

  @override
  String get authTermsNotice => '続行するとZettaskの利用規約およびプライバシーポリシーに同意したものとみなされます。';

  @override
  String get signInToAccountTitle => 'Zettaskにログイン';

  @override
  String get signInToAccountSubtitle => 'ローカルデータはクラウドのバックアップと統合されます。';

  @override
  String get emailLabel => 'メールアドレス';

  @override
  String get emailHint => 'name@email.com';

  @override
  String get emailRequired => 'メールアドレスを入力してください。';

  @override
  String get emailInvalid => 'メールアドレスの形式が正しくありません。';

  @override
  String get passwordLabel => 'パスワード';

  @override
  String get passwordHint => 'パスワードを入力';

  @override
  String get passwordNewHint => '6文字以上';

  @override
  String get passwordRequired => 'パスワードを入力してください。';

  @override
  String get passwordTooShort => 'パスワードは6文字以上で入力してください。';

  @override
  String get forgotPassword => 'お忘れですか？';

  @override
  String get enterValidEmailFirst => '先に有効なメールアドレスを入力してください。';

  @override
  String passwordResetSent(String email) {
    return '$email にリセット用リンクを送信しました。';
  }

  @override
  String get showPasswordTooltip => 'パスワードを表示';

  @override
  String get hidePasswordTooltip => 'パスワードを隠す';

  @override
  String get noAccountPrompt => 'アカウントをお持ちでないですか？';

  @override
  String get createAccountLink => 'アカウント作成';

  @override
  String get createAccountTitle => 'アカウント作成';

  @override
  String get createAccountSubtitle => 'すべてのタスク・ルーティン・メモをクラウドに保存します。';

  @override
  String get haveAccountPrompt => 'すでにアカウントをお持ちですか？';

  @override
  String signedInVia(String provider) {
    return '$provider でログイン中';
  }

  @override
  String get syncNowButton => '今すぐ同期';

  @override
  String get syncingLabel => '同期中...';

  @override
  String get syncDoneMessage => '同期が完了しました。';

  @override
  String get syncFailedMessage => '同期に失敗しました。接続を確認してください。';

  @override
  String get syncStatusIdle => '未同期';

  @override
  String get syncStatusSyncing => '同期中...';

  @override
  String get syncStatusSynced => '同期済み';

  @override
  String get syncStatusError => '同期エラー';

  @override
  String lastSyncedPrefix(String time) {
    return '最終同期: $time';
  }

  @override
  String get neverSynced => '同期履歴なし';

  @override
  String get signOutButton => 'ログアウト';

  @override
  String get signedOutMessage => 'ログアウトしました。ローカルデータは端末に残ります。';

  @override
  String get deleteAccountButton => 'アカウントを削除';

  @override
  String get deleteAccountStep1Title => 'アカウントを削除しますか？';

  @override
  String get deleteAccountStep1Body =>
      'クラウド上のバックアップとアカウントが完全に削除されます。端末のローカルデータは残ります。';

  @override
  String get deleteAccountStep2Title => '完全削除の最終確認';

  @override
  String get deleteAccountStep2Body =>
      'この操作は取り消せません。アカウントとすべてのクラウドデータを今すぐ削除しますか？';

  @override
  String get deleteAccountConfirmButton => 'はい、完全に削除する';

  @override
  String get accountDeletedMessage => 'アカウントとクラウドデータを完全に削除しました。';

  @override
  String get reloginRequiredTitle => '再ログインが必要です';

  @override
  String get authErrUserNotFound => 'このメールアドレスのアカウントが見つかりません。';

  @override
  String get authErrWrongPassword => 'パスワードが正しくありません。';

  @override
  String get authErrInvalidCredential => 'メールアドレスまたはパスワードが正しくありません。';

  @override
  String get authErrInvalidEmail => 'メールアドレスの形式が正しくありません。';

  @override
  String get authErrEmailInUse => 'このメールアドレスは既に登録されています。';

  @override
  String get authErrWeakPassword => 'パスワードが弱すぎます。6文字以上にしてください。';

  @override
  String get authErrNetwork => '通信エラーです。インターネット接続を確認してください。';

  @override
  String get authErrRequiresRecentLogin =>
      'セキュリティのため、一度ログアウトして再ログインしてから削除してください。';

  @override
  String get authErrTooManyRequests => '試行回数が多すぎます。しばらくしてからお試しください。';

  @override
  String get authErrUserDisabled => 'このアカウントは無効化されています。';

  @override
  String get authErrAccountExistsDifferent => 'このメールは別のログイン方法に紐づいています。';

  @override
  String get authErrOperationNotAllowed => 'このログイン方法は有効になっていません。';

  @override
  String get authErrFirebaseUnavailable => 'アカウントサービスを利用できません。';

  @override
  String get authErrUnknown => '認証エラーが発生しました。再試行してください。';

  @override
  String get widgetTitle => 'Zettask · 今日';

  @override
  String get widgetEmptyText => '今日のタスクはすべて完了しました。';

  @override
  String get repeatingTasksAndFollowingDeleted => '繰り返しタスクと以降の予定を削除しました';

  @override
  String get noProjectTasksTitle => 'このプロジェクトにはまだタスクがありません';

  @override
  String noProjectTasksSubtitle(String project) {
    return '+ をタップして $project にタスクを追加できます。';
  }

  @override
  String get addTaskToProjectTooltip => 'プロジェクトにタスクを追加';

  @override
  String get noTagsSubtitle => '+ をタップしてタスクやメモ用のカラータグを作成できます。';

  @override
  String get tagOptionsTooltip => 'タグのオプション';

  @override
  String get deleteTag => 'タグを削除';

  @override
  String get addTagTooltip => 'タグを追加';

  @override
  String get noTasksWithTag => 'このタグが付いたタスクはまだありません。';

  @override
  String get addTaskWithTagTooltip => 'タグ付きタスクを追加';

  @override
  String get tagNameHint => '例：仕事、個人、重要';

  @override
  String get tagColorLabel => 'タグの色';

  @override
  String get createTag => 'タグを作成';

  @override
  String tagDeletedNamed(String name) {
    return 'タグ「$name」を削除しました';
  }

  @override
  String get noTemplatesSubtitle => 'よく使うタスクやチェックリスト構成を保存して素早く作成できます。';

  @override
  String get templateOptionsTooltip => 'テンプレートのオプション';

  @override
  String get deleteTemplate => 'テンプレートを削除';

  @override
  String get createTemplateTooltip => 'テンプレートを作成';

  @override
  String templateDeletedNamed(String name) {
    return 'テンプレート「$name」を削除しました';
  }

  @override
  String get templateNameHint => '例：週次リリース';

  @override
  String get defaultTaskTitleLabel => 'デフォルトのタスク名';

  @override
  String get defaultTaskTitleHint => '例：本番リリース準備';

  @override
  String get timeOptionalLabel => '時刻（任意）';

  @override
  String get clearTimeTooltip => '時刻をクリア';

  @override
  String get projectOptionalLabel => 'プロジェクト（任意）';

  @override
  String get tagOptionalLabel => 'タグ（任意）';

  @override
  String get defaultSubtasksLabel => 'デフォルトのサブタスク';

  @override
  String get addTemplateSubtaskHint => 'テンプレートのサブタスクを追加...';

  @override
  String get saveTemplate => 'テンプレートを保存';

  @override
  String subtasksTotalCount(int count) {
    return '$count 件のサブタスク';
  }

  @override
  String get useTemplateButton => 'テンプレートを使用';

  @override
  String get pickTemplateTitle => 'テンプレートを選択';

  @override
  String get repeatingTaskDeleted => '繰り返しタスクを削除しました';

  @override
  String get noRepeatingTasksSubtitle => '+ をタップして毎日・毎週・毎月のルーティンを作成できます。';

  @override
  String get addRepeatingTaskTooltip => '繰り返しタスクを追加';

  @override
  String get editRepeatingTask => '繰り返しタスクを編集';

  @override
  String get newRepeatingTask => '新しい繰り返しタスク';

  @override
  String get deleteTaskTooltip => 'タスクを削除';

  @override
  String get scheduleLabel => 'スケジュール';

  @override
  String get startAndTimeLabel => '開始日と時刻';

  @override
  String get dateRequiredForTime => '日付が必要';

  @override
  String get clearDateTooltip => '日付をクリア';

  @override
  String get pickTimeFirstReminder => 'リマインダーを有効にするには先に時刻を選択してください。';

  @override
  String get notificationPermissionDenied => '通知権限がオフです。端末の設定で許可してください。';

  @override
  String get pickDateFirstRepeat => '繰り返しを設定するには先に日付を選択してください。';

  @override
  String get subtasksLabel => 'サブタスク';

  @override
  String subtasksWithCount(int count) {
    return 'サブタスク（$count）';
  }

  @override
  String get removeSubtaskTooltip => 'サブタスクを削除';

  @override
  String get addSubtaskTooltip => 'サブタスクを追加';

  @override
  String get moveAllOverdueMoved => '期限切れのタスクをすべて今日へ移動しました';

  @override
  String get moveAllShort => 'すべて移動';

  @override
  String get noOverdueTasksSubtitle => 'これまでのタスクはすべて完了しています。';

  @override
  String get repeatingDeletePrompt => 'どれを削除しますか？';

  @override
  String get repeatingEditPrompt => 'どれを変更しますか？';

  @override
  String get repeatingDeleteSingleSub => 'この予定のみ削除';

  @override
  String get repeatingEditSingleSub => 'この予定のみ変更';

  @override
  String get repeatingDeleteFollowingSub => 'この予定と以降すべてを削除';

  @override
  String get repeatingEditFollowingSub => 'この予定と以降すべてに適用';

  @override
  String get deviceCalendarTitle => '端末カレンダー';

  @override
  String get selectCalendarsLabel => 'カレンダーを選択';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '$selected/$total 有効';
  }

  @override
  String get showCalendarEventsTitle => 'カレンダー予定を表示';

  @override
  String get showCalendarEventsSubtitle => '端末の予定を時系列で読み取り専用表示します。';

  @override
  String get calendarPermDeniedPermanentTitle => 'カレンダー権限が完全に拒否されています';

  @override
  String get calendarPermRequiredTitle => 'カレンダー読み取り権限が必要です';

  @override
  String get calendarPermDeniedPermanentDesc =>
      '端末の設定でカレンダー読み取り権限を許可し、「再確認」をタップしてください。';

  @override
  String get calendarPermRequiredDesc =>
      'Zettask はタイムラインに予定を表示するための読み取り権限のみを要求します。';

  @override
  String get openSettingsButton => '設定を開く';

  @override
  String get checkAgainButton => '再確認';

  @override
  String get noCalendarsFound => 'この端末にカレンダーが見つかりません。';

  @override
  String get eventDetailTitle => '予定の詳細';

  @override
  String get eventNotesLabel => 'メモ';

  @override
  String get calendarEventReadOnlyBanner => '端末カレンダーの予定（読み取り専用）。';

  @override
  String get markUncompletedSemantics => '未完了にする';

  @override
  String get markCompletedSemantics => '完了にする';

  @override
  String get deleteNoteTooltip => 'メモを削除';

  @override
  String repeatMonthlyDay(int day) {
    return '毎月 · $day日';
  }

  @override
  String get last30DaysSubtitle => '過去30日間';

  @override
  String get allTimeSubtitle => '全期間';

  @override
  String get taskCancelled => 'タスクをキャンセルにしました';

  @override
  String get taskRestored => 'タスクを有効に戻しました';

  @override
  String get cancelledStatusLabel => 'キャンセル';

  @override
  String get restoreTaskLabel => '元に戻す';

  @override
  String get markCancelledSemantics => 'キャンセルにする';

  @override
  String get calendarPermFallbackHint =>
      '許可ダイアログが表示されない場合は、アプリ設定からカレンダー権限を手動でオンにしてください。';

  @override
  String get calendarBadgeLabel => 'カレンダー';

  @override
  String get calendarSourceLabel => 'カレンダー';

  @override
  String get calendarLocationLabel => '場所';

  @override
  String get calendarReadOnlyInfo =>
      '端末のカレンダーから同期されました。この項目は読み取り専用のため、Zettask では編集できません。';

  @override
  String get proBrandTitle => 'Zettask Pro';

  @override
  String get proBadge => 'PRO';

  @override
  String get proPaywallSubtitle => 'クラウド同期、カレンダー連携、アプリロック、OLEDテーマをひとつのプランで。';

  @override
  String proActiveBannerTitle(String plan) {
    return '有効 — $plan';
  }

  @override
  String get proActiveBannerSubtitle => 'Zettaskをサポートいただきありがとうございます。';

  @override
  String get proUpgradeBannerSubtitle => 'AMOLEDテーマ、カスタムアクセント、ウィジェットスタイルなど';

  @override
  String get proBenefitCloudSync => 'クラウド同期・マルチデバイス対応';

  @override
  String get proBenefitCalendar => 'カレンダー連携と祝日表示';

  @override
  String get proBenefitAppLock => '生体認証アプリロックと最近使ったアプリの保護';

  @override
  String get proBenefitProjectsCsv => '無制限のプロジェクトとCSVエクスポート';

  @override
  String get proBenefitCustomization => 'AMOLEDピュアブラック、カスタムアクセント、ウィジェットスタイル';

  @override
  String get proPlanMonthlyTitle => '月額';

  @override
  String get proPlanMonthlyPrice => '¥280 / 月';

  @override
  String get proPlanYearlyTitle => '年額';

  @override
  String get proPlanYearlyPrice => '¥1,900 / 年';

  @override
  String get proPlanYearlyBadge => '一番お得';

  @override
  String get proPlanYearlySavings => '約43%お得';

  @override
  String get proPlanLifetimeTitle => '買い切り';

  @override
  String get proPlanLifetimePrice => '¥4,500';

  @override
  String get proPlanLifetimeBadge => '1回払い';

  @override
  String get proContinueButton => '続ける';

  @override
  String get proAlreadyActiveButton => 'Zettask Pro 有効';

  @override
  String get proRestorePurchasesButton => '購入を復元';

  @override
  String get proLegalFootnote =>
      'サブスクリプションは解約しない限り自動更新されます。Google Playからいつでも解約できます。';

  @override
  String get proStoreUnavailableMessage =>
      'この端末では現在Google Play課金を利用できません。接続後に再度お試しください。';

  @override
  String get proPurchaseSuccessMessage => 'Zettask Proが有効になりました。';

  @override
  String get proRestoreSuccessMessage => 'Zettask Proの購入を復元しました。';

  @override
  String get proRestoreEmptyMessage => 'このアカウントで有効なZettask Proの購入は見つかりませんでした。';

  @override
  String get proPurchaseFailedMessage => '購入を完了できませんでした。もう一度お試しください。';

  @override
  String get debugProSimulationLabel => '開発者モード: Proシミュレーション';

  @override
  String get amoledPureBlackTitle => 'AMOLED ピュアブラック';

  @override
  String get amoledPureBlackSubtitle => 'OLED画面向けの純黒 #000000 ダーク背景';

  @override
  String get customAccentSection => 'カスタムアクセントカラー';

  @override
  String get accentMonochrome => 'モノクロ';

  @override
  String get accentSage => 'セージ';

  @override
  String get accentIndigo => 'インディゴ';

  @override
  String get accentTerracotta => 'テラコッタ';

  @override
  String get accentAmber => 'アンバー';

  @override
  String get widgetStyleSection => 'ホーム画面ウィジェットスタイル';

  @override
  String get widgetStyleStandard => '標準';

  @override
  String get widgetStyleAmoled => 'AMOLED';

  @override
  String get widgetStyleTranslucent => '半透明';

  @override
  String get proContextUnlimitedProjects =>
      '無料プランではプロジェクトは最大3件まで作成できます。Zettask Proで無制限に作成できます。';

  @override
  String get proContextCalendarSync => '端末カレンダー連携と祝日表示はZettask Proに含まれています。';

  @override
  String get proContextAppLock => '生体認証アプリロックと最近使ったアプリの保護はZettask Proに含まれています。';

  @override
  String get proContextCsvExport => 'タスクとメモのCSVエクスポートはZettask Proに含まれています。';

  @override
  String get proContextCloudSync => 'マルチデバイスのクラウド同期はZettask Proに含まれています。';

  @override
  String get proContextCustomThemes =>
      'AMOLEDピュアブラックとカスタムアクセントカラーはZettask Proに含まれています。';

  @override
  String get proContextWidgetStyles =>
      'AMOLEDおよび半透明ウィジェットスタイルはZettask Proに含まれています。';

  @override
  String get cloudSyncPausedShort => 'クラウド同期一時停止中 · ローカルデータは安全です';

  @override
  String get cloudSyncPausedTitle => 'クラウド同期は一時停止中';

  @override
  String get cloudSyncPausedBody =>
      'Zettask Proプランが有効ではありません。ローカルのタスクとメモはこの端末に安全に保持されています。';

  @override
  String get resumeSyncWithProButton => 'Proで同期を再開';

  @override
  String get onboardingSkip => 'スキップ';

  @override
  String get onboardingNext => '次へ';

  @override
  String get onboardingGetStarted => '今すぐ始める';

  @override
  String get onboardingSlide1Title => '迷わずタスクを記録';

  @override
  String get onboardingSlide1Body => '日々のタスクを数秒で追加し、チェックリストで整理してワンタップで完了できます。';

  @override
  String get onboardingSlide2Title => '見やすいタイムラインとプロジェクト';

  @override
  String get onboardingSlide2Body =>
      '1日の予定を時系列で確認し、プロジェクトごとに整理。ローカル通知で時間に遅れません。';

  @override
  String get onboardingSlide3Title => '高速・オフライン・安心のプライバシー';

  @override
  String get onboardingSlide3Body =>
      'データは端末内にローカル保存されます。アカウント登録不要でオフラインでも軽快に動作します。';

  @override
  String get appGuideTitle => 'アプリガイド';

  @override
  String get appGuideSubtitle => 'Zettaskの簡単なガイドをもう一度見る';

  @override
  String get dynamicColorTitle => 'Material You（壁紙カラー）';

  @override
  String get dynamicColorSubtitle => '端末の壁紙に合わせてアクセントカラーを調整（Android 12+）';

  @override
  String get subtaskMarkedCancelled => 'サブタスクをキャンセルしました';

  @override
  String get subtaskCancelledBadge => 'キャンセル済み';

  @override
  String get cancelSubtaskTooltip => 'サブタスクをキャンセル';

  @override
  String get restoreSubtaskTooltip => 'サブタスクを復元';

  @override
  String get notificationActionComplete => '完了';

  @override
  String get notificationActionSnooze => 'スヌーズ';

  @override
  String get notificationActionDismiss => '閉じる';

  @override
  String notificationSubtasksMore(int count) {
    return '他 +$count 件';
  }

  @override
  String notificationSubtasksSummary(int completed, int total) {
    return '$completed/$total 完了';
  }
}
