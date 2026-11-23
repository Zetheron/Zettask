// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => '타임라인';

  @override
  String get navBoard => '보드';

  @override
  String get navUnplanned => '미정';

  @override
  String get navMore => '더보기';

  @override
  String get save => '저장';

  @override
  String get cancel => '취소';

  @override
  String get close => '닫기';

  @override
  String get delete => '삭제';

  @override
  String get edit => '편집';

  @override
  String get undo => '실행 취소';

  @override
  String get back => '뒤로';

  @override
  String get retry => '다시 시도';

  @override
  String get clear => '지우기';

  @override
  String get all => '전체';

  @override
  String get or => '또는';

  @override
  String get continueAction => '계속';

  @override
  String get understand => '확인';

  @override
  String get useAction => '사용';

  @override
  String get today => '오늘';

  @override
  String get tomorrow => '내일';

  @override
  String get yesterday => '어제';

  @override
  String get toDo => '할 일';

  @override
  String get overdue => '지연됨';

  @override
  String get unplanned => '미정';

  @override
  String get allDay => '하루 종일';

  @override
  String get scheduled => '예정됨';

  @override
  String get addTaskToday => '오늘 할 일 추가';

  @override
  String get addTask => '할 일 추가';

  @override
  String get noTasksForDate => '이 날짜에 등록된 할 일이 없습니다.';

  @override
  String get savedToUnplanned => '미정 목록에 저장됨';

  @override
  String get savedToUnplannedNoDate => '미정 목록에 저장됨 (날짜 없음)';

  @override
  String scheduledForDate(String date) {
    return '$date에 예정됨';
  }

  @override
  String taskScheduledForDate(String date) {
    return '할 일이 $date에 예정되었습니다';
  }

  @override
  String get taskDeleted => '할 일이 삭제되었습니다';

  @override
  String get searchTasksTooltip => '할 일 검색';

  @override
  String get timelineOptionsTooltip => '타임라인 옵션';

  @override
  String get addTaskTooltip => '할 일 추가';

  @override
  String get completedLabel => '완료';

  @override
  String get uncompleteLabel => '진행 중으로 변경';

  @override
  String subtasksCount(int done, int total) {
    return '하위 작업 $done/$total';
  }

  @override
  String get repeatingTaskLabel => '반복 작업';

  @override
  String get quickAddHint => '새 할 일 추가...';

  @override
  String get expandTooltip => '펼치기';

  @override
  String get saveTaskTooltip => '할 일 저장';

  @override
  String get newTask => '새 할 일';

  @override
  String get editTask => '할 일 편집';

  @override
  String get taskTitleLabel => '할 일 제목';

  @override
  String get taskTitleHint => '예: 스프린트 노트 검토';

  @override
  String get taskTitleRequired => '제목을 입력하세요';

  @override
  String get descriptionLabel => '설명';

  @override
  String get descriptionHint => '메모나 세부 내용을 입력하세요...';

  @override
  String get pickDate => '날짜 선택';

  @override
  String get pickOnCalendar => '캘린더에서 선택...';

  @override
  String get noDateUnplanned => '날짜 없음 (미정)';

  @override
  String get noDate => '날짜 없음';

  @override
  String get taskTime => '시간 설정';

  @override
  String get changeTime => '시간 변경';

  @override
  String get clearTimeAllDay => '시간 지우기 (하루 종일)';

  @override
  String get timeLabel => '시간';

  @override
  String get reminderLabel => '알림';

  @override
  String get noReminder => '알림 없음';

  @override
  String get atTime => '정시';

  @override
  String get minutesBefore10 => '10분 전';

  @override
  String get minutesBefore30 => '30분 전';

  @override
  String get hourBefore1 => '1시간 전';

  @override
  String get reminderShort10m => '10분';

  @override
  String get reminderShort30m => '30분';

  @override
  String get reminderShort1h => '1시간';

  @override
  String get projectLabel => '프로젝트';

  @override
  String get noProject => '프로젝트 없음';

  @override
  String get tagLabel => '태그';

  @override
  String get noTag => '태그 없음';

  @override
  String get priorityLabel => '우선순위';

  @override
  String get priorityLow => '낮음';

  @override
  String get priorityMedium => '보통';

  @override
  String get priorityHigh => '높음';

  @override
  String get saveTask => '할 일 저장';

  @override
  String get saveChanges => '변경 사항 저장';

  @override
  String get checklistLabel => '체크리스트';

  @override
  String get addChecklistHint => '항목 추가...';

  @override
  String get repeatLabel => '반복';

  @override
  String get noRepeat => '반복 안 함';

  @override
  String get repeatDaily => '매일';

  @override
  String get repeatWeekly => '매주';

  @override
  String get repeatMonthly => '매월';

  @override
  String get colorLabel => '색상';

  @override
  String get timelineOptionsTitle => '타임라인 옵션';

  @override
  String get viewModeLabel => '보기 모드';

  @override
  String get modeTimeline => '타임라인 모드';

  @override
  String get modeDaily => '일간 모드';

  @override
  String get firstDayOfWeek => '주 시작 요일';

  @override
  String get monday => '월요일';

  @override
  String get sunday => '일요일';

  @override
  String get firstDayMondayOrder => '월 · 화 · 수 · 목 · 금 · 토 · 일';

  @override
  String get firstDaySundayOrder => '일 · 월 · 화 · 수 · 목 · 금 · 토';

  @override
  String get showCompletedTasks => '완료된 할 일 표시';

  @override
  String get showCompletedTasksSubtitle => '완료된 항목을 숨겨 진행 중인 작업에 집중하세요.';

  @override
  String get showCompletedWorkspaceSubtitle => '완료된 할 일을 표시하거나 숨깁니다.';

  @override
  String get overdueTasksTitle => '지연된 할 일';

  @override
  String get noOverdueTasks => '지연된 할 일이 없습니다';

  @override
  String get moveToToday => '오늘로 이동';

  @override
  String get moveAllToToday => '모두 오늘로 이동';

  @override
  String get searchTasksHint => '할 일 검색...';

  @override
  String get searchTasksEmpty => '할 일, 설명 또는 체크리스트를 검색하세요.';

  @override
  String searchNoResults(String query) {
    return '\"$query\"와 일치하는 할 일이 없습니다.';
  }

  @override
  String get calendarEventReadOnly => '캘린더 일정 · 읽기 전용';

  @override
  String get prevWeekTooltip => '이전 주';

  @override
  String get nextWeekTooltip => '다음 주';

  @override
  String get boardTitle => '보드';

  @override
  String get allProjects => '모든 프로젝트';

  @override
  String get searchProjectHint => '프로젝트 검색...';

  @override
  String get searchProjectTooltip => '프로젝트 검색';

  @override
  String get closeSearchTooltip => '검색 닫기';

  @override
  String get createProject => '프로젝트 만들기';

  @override
  String get editProject => '프로젝트 편집';

  @override
  String get deleteProject => '프로젝트 삭제';

  @override
  String get projectOptionsTooltip => '프로젝트 옵션';

  @override
  String projectDeleted(String name) {
    return '\"$name\" 프로젝트가 삭제되었습니다';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return '$done/$total 완료';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return '$done/$total 완료됨';
  }

  @override
  String get projectNotFound => '프로젝트를 찾을 수 없습니다';

  @override
  String get noProjectsYet => '아직 프로젝트가 없습니다';

  @override
  String projectSearchEmpty(String query) {
    return '\"$query\"와 일치하는 프로젝트가 없습니다.';
  }

  @override
  String get noProjectsSubtitle => '아래 폴더 버튼을 눌러 첫 프로젝트를 만드세요.';

  @override
  String get newProject => '새 프로젝트';

  @override
  String get projectNameLabel => '프로젝트 이름';

  @override
  String get projectNameHint => '예: Zettask 출시';

  @override
  String get projectNameRequired => '프로젝트 이름을 입력하세요';

  @override
  String get projectColorLabel => '프로젝트 색상';

  @override
  String get unplannedTitle => '미정';

  @override
  String activeCountLabel(int count) {
    return '$count개 진행 중';
  }

  @override
  String get noUnplannedTitle => '미정 할 일이 없습니다';

  @override
  String get noUnplannedSubtitle => '+ 버튼을 눌러 날짜 없는 할 일을 기록하세요.';

  @override
  String get addUnplannedTooltip => '미정 할 일 추가';

  @override
  String get workspaceTitle => '워크스페이스';

  @override
  String get organizeSection => '정리';

  @override
  String get automationSection => '자동화';

  @override
  String get insightsSection => '통계 및 개인화';

  @override
  String get settingsInfoSection => '설정 및 정보';

  @override
  String get tagsTitle => '태그';

  @override
  String get tagsSubtitleEmpty => '할 일과 메모용 컬러 라벨';

  @override
  String tagsCountSubtitle(int count) {
    return '태그 $count개';
  }

  @override
  String get newTag => '새 태그';

  @override
  String get editTag => '태그 편집';

  @override
  String get tagNameLabel => '태그 이름';

  @override
  String get tagNameRequired => '태그 이름을 입력하세요';

  @override
  String get tagDeleted => '태그가 삭제되었습니다';

  @override
  String get noTagsYet => '아직 태그가 없습니다';

  @override
  String tagTasksCount(int count) {
    return '$count개 작업';
  }

  @override
  String get templatesTitle => '템플릿';

  @override
  String get templatesSubtitleEmpty => '자주 쓰는 할 일과 체크리스트 저장';

  @override
  String templatesCountSubtitle(int count) {
    return '템플릿 $count개';
  }

  @override
  String get newTemplate => '새 템플릿';

  @override
  String get editTemplate => '템플릿 편집';

  @override
  String get templateNameLabel => '템플릿 이름';

  @override
  String get templateNameRequired => '템플릿 이름을 입력하세요';

  @override
  String get templateDeleted => '템플릿이 삭제되었습니다';

  @override
  String get noTemplatesYet => '아직 템플릿이 없습니다';

  @override
  String get taskFromTemplateSaved => '템플릿에서 할 일이 저장되었습니다';

  @override
  String get notesTitle => '메모';

  @override
  String get notesSubtitleEmpty => '날짜 없는 빠른 메모';

  @override
  String notesCountSubtitle(int count) {
    return '메모 $count개';
  }

  @override
  String get newNote => '새 메모';

  @override
  String get editNote => '메모 편집';

  @override
  String get noteTitleLabel => '메모 제목';

  @override
  String get noteTitleHint => '예: 회의 요약';

  @override
  String get noteTitleRequired => '제목을 입력하세요';

  @override
  String get noteContentLabel => '내용';

  @override
  String get noteContentHint => '여기에 메모를 작성하세요...';

  @override
  String get noteDeleted => '메모가 삭제되었습니다';

  @override
  String get searchNotesHint => '메모 검색...';

  @override
  String get noteNotFound => '메모를 찾을 수 없습니다';

  @override
  String get noNotesYet => '아직 메모가 없습니다';

  @override
  String noteSearchEmpty(String query) {
    return '\"$query\"와 일치하는 메모가 없습니다.';
  }

  @override
  String get noNotesSubtitle => '+ 버튼을 눌러 빠른 메모를 작성하세요.';

  @override
  String get saveNote => '메모 저장';

  @override
  String get repeatingTasksTitle => '반복 작업';

  @override
  String get repeatingTasksSubtitleEmpty => '일간·주간·월간 루틴 관리';

  @override
  String repeatingActiveCount(int count) {
    return '활성 루틴 $count개';
  }

  @override
  String get noRepeatingTasks => '반복 작업이 없습니다';

  @override
  String get repeatingActionTitle => '반복 작업입니다';

  @override
  String get repeatingThisOnly => '이 작업만';

  @override
  String get repeatingThisAndFollowing => '이 작업과 이후 모든 작업';

  @override
  String get last7DaysUpper => '최근 7일';

  @override
  String weeklySummary(int tasks, int checklists) {
    return '할 일 $tasks개, 체크리스트 $checklists개';
  }

  @override
  String get statsTitle => '통계';

  @override
  String get range7Days => '7일';

  @override
  String get range30Days => '30일';

  @override
  String get completedToday => '오늘 완료';

  @override
  String get last7DaysLabel => '최근 7일';

  @override
  String get last30DaysLabel => '최근 30일';

  @override
  String get allTimeLabel => '전체 완료';

  @override
  String get completionRateLabel => '완료율';

  @override
  String get activity7Days => '최근 7일 활동';

  @override
  String get activity30Days => '최근 30일 활동';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks개 작업 · $checklists개 항목';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return '$days일 합계: 할 일 $tasks개, 체크리스트 $checklists개';
  }

  @override
  String get completedByPriority => '우선순위별 완료';

  @override
  String get progressByProject => '프로젝트별 진행률';

  @override
  String get breakdownByTag => '태그별 세부 내역';

  @override
  String get habits30Days => '습관 (Habits) · 30일';

  @override
  String get noProjectsCreated => '생성된 프로젝트가 없습니다.';

  @override
  String get noTagsCreated => '생성된 태그가 없습니다.';

  @override
  String get noActiveHabits => '활성 루틴이 없습니다.';

  @override
  String completedCountLabel(int count) {
    return '$count개 완료';
  }

  @override
  String tagBreakdownTrailing(int done, int total) {
    return '$done/$total 완료';
  }

  @override
  String habitCompletedRatio(String summary, int done, int scheduled) {
    return '$summary · $done/$scheduled 완료';
  }

  @override
  String statsSubtitle(int completed, int percent) {
    return '$completed개 완료 · 완료율 $percent%';
  }

  @override
  String get themeTitle => '테마';

  @override
  String get themeAndColorsTitle => '테마 및 색상';

  @override
  String get livePreviewSection => '실시간 미리보기';

  @override
  String get appearanceModeSection => '화면 모드';

  @override
  String get colorPaletteSection => '색상 팔레트';

  @override
  String get themeLight => '라이트';

  @override
  String get themeDark => '다크';

  @override
  String get themeSystem => '시스템';

  @override
  String get themeSystemLight => '시스템 (라이트)';

  @override
  String get themeSystemDark => '시스템 (다크)';

  @override
  String get presetDefault => '기본';

  @override
  String get presetDefaultDesc => '인디고 & 슬레이트';

  @override
  String get presetOcean => '오션';

  @override
  String get presetOceanDesc => '차분한 블루';

  @override
  String get presetForest => '포레스트';

  @override
  String get presetForestDesc => '세이지 & 에메랄드';

  @override
  String get presetTerracotta => '테라코타';

  @override
  String get presetTerracottaDesc => '따뜻한 오렌지';

  @override
  String get presetPlum => '플럼';

  @override
  String get presetPlumDesc => '부드러운 퍼플';

  @override
  String get presetMonochrome => '모노크롬';

  @override
  String get presetMonochromeDesc => '차콜 & 블랙';

  @override
  String get previewActiveTask => '인터페이스 디자인 검토';

  @override
  String get previewCompletedTask => '주간 일정 동기화';

  @override
  String get languageTitle => '언어';

  @override
  String get deviceLanguageOption => '기기 언어 (지원 시)';

  @override
  String get appLockTitle => '앱 잠금';

  @override
  String get appLockSubtitle => '지문, 얼굴 또는 기기 PIN';

  @override
  String get appLockLockedTitle => 'Zettask 잠김';

  @override
  String get appLockLockedSubtitle => '지문, 얼굴 또는 기기 PIN으로 잠금을 해제하세요.';

  @override
  String get unlockButton => '잠금 해제';

  @override
  String get verifyingButton => '확인 중...';

  @override
  String get appLockUnsupportedError => '이 기기에 생체 인증 또는 화면 잠금이 설정되어 있지 않습니다.';

  @override
  String get appLockCancelledError => '인증이 취소되었거나 실패했습니다.';

  @override
  String get appLockUnlockFailedError => '인증에 실패했습니다. 잠금 해제를 눌러 다시 시도하세요.';

  @override
  String get calendarSyncTitle => '캘린더 동기화';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return '사용 중 · 캘린더 $count개';
  }

  @override
  String get calendarSyncInactiveSubtitle => '꺼짐 · 기기 일정을 읽기 전용으로 표시';

  @override
  String get grantCalendarPermission => '캘린더 권한 허용';

  @override
  String get exportCsvTitle => 'CSV 내보내기';

  @override
  String get exportCsvSubtitle => '할 일이나 메모를 CSV로 공유';

  @override
  String get exportDataCsvTitle => 'CSV 데이터 내보내기';

  @override
  String get exportTasksTitle => '할 일 내보내기';

  @override
  String get exportTasksSubtitle => '예정, 미정 및 프로젝트의 모든 할 일';

  @override
  String get exportNotesTitle => '메모 내보내기';

  @override
  String get exportNotesSubtitle => '모든 빠른 메모';

  @override
  String get exportBothTitle => '모두 내보내기';

  @override
  String get exportBothSubtitle => '할 일과 메모 CSV 파일 함께 내보내기';

  @override
  String get aboutPrivacyTitle => '정보 및 개인정보 보호';

  @override
  String aboutPrivacySubtitle(String version) {
    return '버전 $version · 오프라인 우선 및 선택적 클라우드';
  }

  @override
  String get aboutTitle => 'Zettask 정보';

  @override
  String versionLabel(String version) {
    return '버전 $version';
  }

  @override
  String get privacySyncTitle => '개인정보 및 동기화';

  @override
  String get privacySyncDescription =>
      '기본적으로 데이터는 기기에 로컬 저장됩니다. 로그인 시 Firebase 클라우드 동기화를 선택적으로 사용할 수 있으며 언제든 계정과 클라우드 데이터를 영구 삭제할 수 있습니다.';

  @override
  String get privacyPolicyLabel => '개인정보 처리방침';

  @override
  String get privacyLinkCopied => '링크가 복사되었습니다';

  @override
  String get accountAndSyncTitle => '계정 및 동기화';

  @override
  String get signInToZettask => 'Zettask 계정 로그인';

  @override
  String get accountBannerSubtitle => '선택 · 클라우드 백업 및 동기화';

  @override
  String get authWelcomeTitle => '진행 상황과 할 일을 안전하게 보관';

  @override
  String get authWelcomeSubtitle =>
      '일정, 프로젝트, 메모를 클라우드에 자동 백업하세요. 계정 없이도 로컬에서 계속 사용할 수 있습니다.';

  @override
  String get createNewAccount => '새 계정 만들기';

  @override
  String get signIn => '로그인';

  @override
  String get continueWithGoogle => 'Google로 계속하기';

  @override
  String get authTermsNotice => '계속하면 Zettask 약관 및 개인정보 처리방침에 동의하게 됩니다.';

  @override
  String get signInToAccountTitle => 'Zettask 로그인';

  @override
  String get signInToAccountSubtitle => '로컬 데이터가 클라우드 백업과 병합됩니다.';

  @override
  String get emailLabel => '이메일';

  @override
  String get emailHint => 'name@email.com';

  @override
  String get emailRequired => '이메일을 입력하세요.';

  @override
  String get emailInvalid => '올바른 이메일 형식이 아닙니다.';

  @override
  String get passwordLabel => '비밀번호';

  @override
  String get passwordHint => '비밀번호 입력';

  @override
  String get passwordNewHint => '6자 이상';

  @override
  String get passwordRequired => '비밀번호를 입력하세요.';

  @override
  String get passwordTooShort => '비밀번호는 6자 이상이어야 합니다.';

  @override
  String get forgotPassword => '비밀번호 찾기';

  @override
  String get enterValidEmailFirst => '먼저 올바른 이메일 주소를 입력하세요.';

  @override
  String passwordResetSent(String email) {
    return '$email로 재설정 링크를 보냈습니다.';
  }

  @override
  String get showPasswordTooltip => '비밀번호 표시';

  @override
  String get hidePasswordTooltip => '비밀번호 숨기기';

  @override
  String get noAccountPrompt => '계정이 없으신가요?';

  @override
  String get createAccountLink => '계정 만들기';

  @override
  String get createAccountTitle => '계정 만들기';

  @override
  String get createAccountSubtitle => '모든 할 일, 루틴, 메모를 클라우드에 백업하세요.';

  @override
  String get haveAccountPrompt => '이미 계정이 있으신가요?';

  @override
  String signedInVia(String provider) {
    return '$provider(으)로 로그인됨';
  }

  @override
  String get syncNowButton => '지금 동기화';

  @override
  String get syncingLabel => '동기화 중...';

  @override
  String get syncDoneMessage => '동기화가 완료되었습니다.';

  @override
  String get syncFailedMessage => '동기화에 실패했습니다. 인터넷 연결을 확인하세요.';

  @override
  String get syncStatusIdle => '아직 동기화되지 않음';

  @override
  String get syncStatusSyncing => '동기화 중...';

  @override
  String get syncStatusSynced => '동기화됨';

  @override
  String get syncStatusError => '동기화 실패';

  @override
  String lastSyncedPrefix(String time) {
    return '마지막 동기화: $time';
  }

  @override
  String get neverSynced => '동기화 기록 없음';

  @override
  String get signOutButton => '로그아웃';

  @override
  String get signedOutMessage => '로그아웃되었습니다. 로컬 데이터는 기기에 유지됩니다.';

  @override
  String get deleteAccountButton => '계정 삭제';

  @override
  String get deleteAccountStep1Title => '계정을 삭제하시겠습니까?';

  @override
  String get deleteAccountStep1Body =>
      '모든 클라우드 백업과 계정이 영구 삭제됩니다. 기기의 로컬 데이터는 유지됩니다.';

  @override
  String get deleteAccountStep2Title => '영구 삭제 최종 확인';

  @override
  String get deleteAccountStep2Body =>
      '이 작업은 되돌릴 수 없습니다. 계정과 모든 클라우드 데이터를 지금 영구 삭제할까요?';

  @override
  String get deleteAccountConfirmButton => '예, 영구 삭제';

  @override
  String get accountDeletedMessage => '계정과 모든 클라우드 데이터가 영구 삭제되었습니다.';

  @override
  String get reloginRequiredTitle => '다시 로그인 필요';

  @override
  String get authErrUserNotFound => '이 이메일로 등록된 계정이 없습니다.';

  @override
  String get authErrWrongPassword => '비밀번호가 일치하지 않습니다.';

  @override
  String get authErrInvalidCredential => '이메일 또는 비밀번호가 올바르지 않습니다.';

  @override
  String get authErrInvalidEmail => '올바른 이메일 형식이 아닙니다.';

  @override
  String get authErrEmailInUse => '이미 사용 중인 이메일입니다.';

  @override
  String get authErrWeakPassword => '비밀번호가 너무 약합니다. 6자 이상 입력하세요.';

  @override
  String get authErrNetwork => '네트워크 오류입니다. 인터넷 연결을 확인하세요.';

  @override
  String get authErrRequiresRecentLogin => '보안을 위해 로그아웃 후 다시 로그인한 뒤 삭제하세요.';

  @override
  String get authErrTooManyRequests => '시도가 너무 많습니다. 잠시 후 다시 시도하세요.';

  @override
  String get authErrUserDisabled => '비활성화된 계정입니다.';

  @override
  String get authErrAccountExistsDifferent => '다른 로그인 방식과 연결된 이메일입니다.';

  @override
  String get authErrOperationNotAllowed => '허용되지 않은 로그인 방식입니다.';

  @override
  String get authErrFirebaseUnavailable => '계정 서비스를 사용할 수 없습니다.';

  @override
  String get authErrUnknown => '인증 오류가 발생했습니다. 다시 시도하세요.';

  @override
  String get widgetTitle => 'Zettask · 오늘';

  @override
  String get widgetEmptyText => '오늘의 할 일을 모두 마쳤습니다.';

  @override
  String get repeatingTasksAndFollowingDeleted => '반복 할 일과 이후 일정이 삭제되었습니다';

  @override
  String get noProjectTasksTitle => '이 프로젝트에 할 일이 없습니다';

  @override
  String noProjectTasksSubtitle(String project) {
    return '+ 버튼을 눌러 $project에 할 일을 추가하세요.';
  }

  @override
  String get addTaskToProjectTooltip => '프로젝트에 할 일 추가';

  @override
  String get noTagsSubtitle => '+ 버튼을 눌러 할 일과 메모용 색상 태그를 만드세요.';

  @override
  String get tagOptionsTooltip => '태그 옵션';

  @override
  String get deleteTag => '태그 삭제';

  @override
  String get addTagTooltip => '태그 추가';

  @override
  String get noTasksWithTag => '이 태그가 붙은 할 일이 없습니다.';

  @override
  String get addTaskWithTagTooltip => '태그 할 일 추가';

  @override
  String get tagNameHint => '예: 업무, 개인, 긴급';

  @override
  String get tagColorLabel => '태그 색상';

  @override
  String get createTag => '태그 만들기';

  @override
  String tagDeletedNamed(String name) {
    return '태그 \"$name\" 삭제됨';
  }

  @override
  String get noTemplatesSubtitle => '자주 쓰는 할 일과 체크리스트 구조를 저장해 빠르게 만드세요.';

  @override
  String get templateOptionsTooltip => '템플릿 옵션';

  @override
  String get deleteTemplate => '템플릿 삭제';

  @override
  String get createTemplateTooltip => '템플릿 만들기';

  @override
  String templateDeletedNamed(String name) {
    return '템플릿 \"$name\" 삭제됨';
  }

  @override
  String get templateNameHint => '예: 주간 릴리스';

  @override
  String get defaultTaskTitleLabel => '기본 할 일 제목';

  @override
  String get defaultTaskTitleHint => '예: 프로덕션 배포 준비';

  @override
  String get timeOptionalLabel => '시간 (선택)';

  @override
  String get clearTimeTooltip => '시간 지우기';

  @override
  String get projectOptionalLabel => '프로젝트 (선택)';

  @override
  String get tagOptionalLabel => '태그 (선택)';

  @override
  String get defaultSubtasksLabel => '기본 하위 항목';

  @override
  String get addTemplateSubtaskHint => '템플릿 하위 항목 추가...';

  @override
  String get saveTemplate => '템플릿 저장';

  @override
  String subtasksTotalCount(int count) {
    return '하위 항목 $count개';
  }

  @override
  String get useTemplateButton => '템플릿 사용';

  @override
  String get pickTemplateTitle => '템플릿 선택';

  @override
  String get repeatingTaskDeleted => '반복 할 일이 삭제되었습니다';

  @override
  String get noRepeatingTasksSubtitle => '+ 버튼을 눌러 매일, 매주, 매월 루틴을 만드세요.';

  @override
  String get addRepeatingTaskTooltip => '반복 할 일 추가';

  @override
  String get editRepeatingTask => '반복 할 일 편집';

  @override
  String get newRepeatingTask => '새 반복 할 일';

  @override
  String get deleteTaskTooltip => '할 일 삭제';

  @override
  String get scheduleLabel => '일정';

  @override
  String get startAndTimeLabel => '시작일 및 시간';

  @override
  String get dateRequiredForTime => '날짜 필요';

  @override
  String get clearDateTooltip => '날짜 지우기';

  @override
  String get pickTimeFirstReminder => '알림을 켜려면 먼저 시간을 선택하세요.';

  @override
  String get notificationPermissionDenied => '알림 권한이 꺼져 있습니다. 기기 설정에서 허용하세요.';

  @override
  String get pickDateFirstRepeat => '반복을 설정하려면 먼저 날짜를 선택하세요.';

  @override
  String get subtasksLabel => '하위 항목';

  @override
  String subtasksWithCount(int count) {
    return '하위 항목 ($count)';
  }

  @override
  String get removeSubtaskTooltip => '하위 항목 삭제';

  @override
  String get addSubtaskTooltip => '하위 항목 추가';

  @override
  String get moveAllOverdueMoved => '모든 지난 할 일을 오늘로 이동했습니다';

  @override
  String get moveAllShort => '모두 이동';

  @override
  String get noOverdueTasksSubtitle => '이전 날짜의 할 일을 모두 완료했습니다.';

  @override
  String get repeatingDeletePrompt => '무엇을 삭제할까요?';

  @override
  String get repeatingEditPrompt => '무엇을 변경할까요?';

  @override
  String get repeatingDeleteSingleSub => '이 일정만 삭제';

  @override
  String get repeatingEditSingleSub => '이 일정만 변경';

  @override
  String get repeatingDeleteFollowingSub => '이 일정 및 이후 모든 일정 삭제';

  @override
  String get repeatingEditFollowingSub => '이 일정 및 이후 모든 일정에 적용';

  @override
  String get deviceCalendarTitle => '기기 캘린더';

  @override
  String get selectCalendarsLabel => '캘린더 선택';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '$selected/$total 활성';
  }

  @override
  String get showCalendarEventsTitle => '캘린더 일정 표시';

  @override
  String get showCalendarEventsSubtitle => '기기 일정을 시간순 읽기 전용으로 표시합니다.';

  @override
  String get calendarPermDeniedPermanentTitle => '캘린더 권한이 영구 거부됨';

  @override
  String get calendarPermRequiredTitle => '캘린더 읽기 권한 필요';

  @override
  String get calendarPermDeniedPermanentDesc =>
      '기기 설정에서 캘린더 읽기 권한을 켠 뒤 다시 확인을 누르세요.';

  @override
  String get calendarPermRequiredDesc =>
      'Zettask는 타임라인에 일정을 표시하기 위한 읽기 권한만 요청합니다.';

  @override
  String get openSettingsButton => '설정 열기';

  @override
  String get checkAgainButton => '다시 확인';

  @override
  String get noCalendarsFound => '이 기기에서 캘린더를 찾을 수 없습니다.';

  @override
  String get eventDetailTitle => '일정 상세';

  @override
  String get eventNotesLabel => '메모';

  @override
  String get calendarEventReadOnlyBanner => '기기 캘린더 일정 (읽기 전용).';

  @override
  String get markUncompletedSemantics => '미완료로 표시';

  @override
  String get markCompletedSemantics => '완료로 표시';

  @override
  String get deleteNoteTooltip => '메모 삭제';

  @override
  String repeatMonthlyDay(int day) {
    return '매월 · $day일';
  }

  @override
  String get last30DaysSubtitle => '최근 30일';

  @override
  String get allTimeSubtitle => '전체 기간';

  @override
  String get taskCancelled => '할 일이 취소됨으로 표시되었습니다';

  @override
  String get taskRestored => '할 일이 다시 활성화되었습니다';

  @override
  String get cancelledStatusLabel => '취소됨';

  @override
  String get restoreTaskLabel => '복원';

  @override
  String get markCancelledSemantics => '취소됨으로 표시';

  @override
  String get calendarPermFallbackHint =>
      '권한 팝업이 나타나지 않으면 앱 설정을 열어 캘린더 권한을 직접 허용하세요.';

  @override
  String get calendarBadgeLabel => '캘린더';

  @override
  String get calendarSourceLabel => '캘린더';

  @override
  String get calendarLocationLabel => '위치';

  @override
  String get calendarReadOnlyInfo =>
      '기기 캘린더에서 동기화되었습니다. 이 항목은 읽기 전용이며 Zettask에서 편집할 수 없습니다.';

  @override
  String get proBrandTitle => 'Zettask Pro';

  @override
  String get proBadge => 'PRO';

  @override
  String get proPaywallSubtitle =>
      '클라우드 동기화, 캘린더 연동, 앱 잠금, OLED 테마를 한 번에 이용하세요.';

  @override
  String proActiveBannerTitle(String plan) {
    return '활성 — $plan';
  }

  @override
  String get proActiveBannerSubtitle => 'Zettask를 후원해 주셔서 감사합니다.';

  @override
  String get proUpgradeBannerSubtitle => 'AMOLED 테마, 맞춤 강조 색상, 위젯 스타일 등';

  @override
  String get proBenefitCloudSync => '클라우드 동기화 및 멀티 디바이스';

  @override
  String get proBenefitCalendar => '캘린더 연동 및 공휴일 표시';

  @override
  String get proBenefitAppLock => '생체 인식 앱 잠금 및 최근 앱 보호';

  @override
  String get proBenefitProjectsCsv => '무제한 프로젝트 및 CSV 내보내기';

  @override
  String get proBenefitCustomization => 'AMOLED 퓨어 블랙, 맞춤 강조 색상 및 위젯 스타일';

  @override
  String get proPlanMonthlyTitle => '월간';

  @override
  String get proPlanMonthlyPrice => '₩2,500 / 월';

  @override
  String get proPlanYearlyTitle => '연간';

  @override
  String get proPlanYearlyPrice => '₩17,000 / 년';

  @override
  String get proPlanYearlyBadge => '최고 가성비';

  @override
  String get proPlanYearlySavings => '약 43% 할인';

  @override
  String get proPlanLifetimeTitle => '평생 이용';

  @override
  String get proPlanLifetimePrice => '₩39,000';

  @override
  String get proPlanLifetimeBadge => '일회성 결제';

  @override
  String get proContinueButton => '계속하기';

  @override
  String get proAlreadyActiveButton => 'Zettask Pro 활성';

  @override
  String get proRestorePurchasesButton => '구매 복원';

  @override
  String get proLegalFootnote =>
      '구독은 취소하지 않으면 자동 갱신됩니다. Google Play에서 언제든 취소할 수 있습니다.';

  @override
  String get proStoreUnavailableMessage =>
      '이 기기에서는 아직 Google Play 결제를 사용할 수 없습니다. 연결 후 다시 시도해 주세요.';

  @override
  String get proPurchaseSuccessMessage => 'Zettask Pro가 활성화되었습니다.';

  @override
  String get proRestoreSuccessMessage => 'Zettask Pro 구매 내역이 복원되었습니다.';

  @override
  String get proRestoreEmptyMessage => '이 계정에서 활성화된 Zettask Pro 구매를 찾을 수 없습니다.';

  @override
  String get proPurchaseFailedMessage => '지금은 구매를 완료할 수 없습니다. 다시 시도해 주세요.';

  @override
  String get debugProSimulationLabel => '개발자 모드: Pro 시뮬레이션';

  @override
  String get amoledPureBlackTitle => 'AMOLED 퓨어 블랙';

  @override
  String get amoledPureBlackSubtitle => 'OLED 화면 배터리를 절약하는 순수 #000000 배경';

  @override
  String get customAccentSection => '맞춤 강조 색상';

  @override
  String get accentMonochrome => '모노크롬';

  @override
  String get accentSage => '세이지';

  @override
  String get accentIndigo => '인디고';

  @override
  String get accentTerracotta => '테라코타';

  @override
  String get accentAmber => '앰버';

  @override
  String get widgetStyleSection => '홈 화면 위젯 스타일';

  @override
  String get widgetStyleStandard => '기본';

  @override
  String get widgetStyleAmoled => 'AMOLED';

  @override
  String get widgetStyleTranslucent => '반투명';

  @override
  String get proContextUnlimitedProjects =>
      '무료 플랜에서는 프로젝트를 최대 3개까지 만들 수 있습니다. Zettask Pro에서 무제한으로 이용해 보세요.';

  @override
  String get proContextCalendarSync =>
      '기기 캘린더 연동 및 공휴일 표시는 Zettask Pro에 포함되어 있습니다.';

  @override
  String get proContextAppLock =>
      '생체 인식 앱 잠금 및 최근 앱 보호는 Zettask Pro에 포함되어 있습니다.';

  @override
  String get proContextCsvExport =>
      '할 일 및 메모 CSV 내보내기는 Zettask Pro에 포함되어 있습니다.';

  @override
  String get proContextCloudSync => '멀티 디바이스 클라우드 동기화는 Zettask Pro에 포함되어 있습니다.';

  @override
  String get proContextCustomThemes =>
      'AMOLED 퓨어 블랙과 맞춤 강조 색상은 Zettask Pro에 포함되어 있습니다.';

  @override
  String get proContextWidgetStyles =>
      'AMOLED 및 반투명 위젯 스타일은 Zettask Pro에 포함되어 있습니다.';

  @override
  String get cloudSyncPausedShort => '클라우드 동기화 일시 중지 · 로컬 데이터 안전';

  @override
  String get cloudSyncPausedTitle => '클라우드 동기화 일시 중지됨';

  @override
  String get cloudSyncPausedBody =>
      'Zettask Pro 구독이 비활성 상태입니다. 로컬 할 일과 메모는 이 기기에 안전하게 보관됩니다.';

  @override
  String get resumeSyncWithProButton => 'Pro로 동기화 재개';

  @override
  String get onboardingSkip => '건너뛰기';

  @override
  String get onboardingNext => '다음';

  @override
  String get onboardingGetStarted => '지금 시작하기';

  @override
  String get onboardingSlide1Title => '방해 없이 빠르게 할 일 기록';

  @override
  String get onboardingSlide1Body =>
      '몇 초 만에 할 일을 추가하고 체크리스트로 나누어 한 번의 탭으로 완료하세요.';

  @override
  String get onboardingSlide2Title => '깔끔한 타임라인과 프로젝트';

  @override
  String get onboardingSlide2Body =>
      '하루 일정을 시간순으로 보고 프로젝트별로 정리하며 로컬 알림으로 제시간에 챙기세요.';

  @override
  String get onboardingSlide3Title => '빠르고 안전한 오프라인 우선';

  @override
  String get onboardingSlide3Body =>
      '모든 데이터는 기기에 먼저 저장됩니다. 계정 없이도 인터넷 없이 빠르게 사용할 수 있습니다.';

  @override
  String get appGuideTitle => '앱 가이드';

  @override
  String get appGuideSubtitle => 'Zettask 간단 안내 다시 보기';

  @override
  String get dynamicColorTitle => 'Material You(배경화면 색상)';

  @override
  String get dynamicColorSubtitle =>
      '기기 배경화면에 맞춰 강조 색상을 자동 조정합니다 (Android 12+)';

  @override
  String get subtaskMarkedCancelled => '하위 작업이 취소됨';

  @override
  String get subtaskCancelledBadge => '취소됨';

  @override
  String get cancelSubtaskTooltip => '하위 작업 취소';

  @override
  String get restoreSubtaskTooltip => '하위 작업 복원';

  @override
  String get notificationActionComplete => '완료';

  @override
  String get notificationActionSnooze => '다시 알림';

  @override
  String get notificationActionDismiss => '닫기';

  @override
  String notificationSubtasksMore(int count) {
    return '+$count개 더';
  }

  @override
  String notificationSubtasksSummary(int completed, int total) {
    return '$completed/$total 완료';
  }
}
