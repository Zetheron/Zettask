// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => 'Lịch trình';

  @override
  String get navBoard => 'Bảng';

  @override
  String get navUnplanned => 'Chưa xếp';

  @override
  String get navMore => 'Thêm';

  @override
  String get save => 'Lưu';

  @override
  String get cancel => 'Hủy';

  @override
  String get close => 'Đóng';

  @override
  String get delete => 'Xóa';

  @override
  String get edit => 'Sửa';

  @override
  String get undo => 'Hoàn tác';

  @override
  String get back => 'Quay lại';

  @override
  String get retry => 'Thử lại';

  @override
  String get clear => 'Xóa';

  @override
  String get all => 'Tất cả';

  @override
  String get or => 'hoặc';

  @override
  String get continueAction => 'Tiếp tục';

  @override
  String get understand => 'Đã hiểu';

  @override
  String get useAction => 'Dùng';

  @override
  String get today => 'Hôm nay';

  @override
  String get tomorrow => 'Ngày mai';

  @override
  String get yesterday => 'Hôm qua';

  @override
  String get toDo => 'Cần làm';

  @override
  String get overdue => 'Quá hạn';

  @override
  String get unplanned => 'Chưa xếp';

  @override
  String get allDay => 'Cả ngày';

  @override
  String get scheduled => 'Có giờ';

  @override
  String get addTaskToday => 'Thêm việc cho hôm nay';

  @override
  String get addTask => 'Thêm việc';

  @override
  String get noTasksForDate => 'Chưa có công việc nào cho ngày này.';

  @override
  String get savedToUnplanned => 'Đã lưu vào Chưa xếp';

  @override
  String get savedToUnplannedNoDate => 'Đã lưu vào Chưa xếp (không ngày)';

  @override
  String scheduledForDate(String date) {
    return 'Đã hẹn vào $date';
  }

  @override
  String taskScheduledForDate(String date) {
    return 'Đã hẹn công việc vào $date';
  }

  @override
  String get taskDeleted => 'Đã xóa công việc';

  @override
  String get searchTasksTooltip => 'Tìm công việc';

  @override
  String get timelineOptionsTooltip => 'Tùy chọn lịch trình';

  @override
  String get addTaskTooltip => 'Thêm công việc';

  @override
  String get completedLabel => 'Hoàn thành';

  @override
  String get uncompleteLabel => 'Đánh dấu chưa xong';

  @override
  String subtasksCount(int done, int total) {
    return '$done/$total việc nhỏ';
  }

  @override
  String get repeatingTaskLabel => 'Việc lặp lại';

  @override
  String get quickAddHint => 'Thêm công việc mới...';

  @override
  String get expandTooltip => 'Mở rộng';

  @override
  String get saveTaskTooltip => 'Lưu công việc';

  @override
  String get newTask => 'Công việc mới';

  @override
  String get editTask => 'Sửa công việc';

  @override
  String get taskTitleLabel => 'Tiêu đề công việc';

  @override
  String get taskTitleHint => 'VD: Xem lại ghi chú sprint';

  @override
  String get taskTitleRequired => 'Vui lòng nhập tiêu đề';

  @override
  String get descriptionLabel => 'Mô tả';

  @override
  String get descriptionHint => 'Thêm ghi chú hoặc chi tiết...';

  @override
  String get pickDate => 'Chọn ngày';

  @override
  String get pickOnCalendar => 'Chọn trên lịch...';

  @override
  String get noDateUnplanned => 'Không ngày (Chưa xếp)';

  @override
  String get noDate => 'Không ngày';

  @override
  String get taskTime => 'Giờ thực hiện';

  @override
  String get changeTime => 'Đổi giờ';

  @override
  String get clearTimeAllDay => 'Xóa giờ (Cả ngày)';

  @override
  String get timeLabel => 'Giờ';

  @override
  String get reminderLabel => 'Nhắc nhở';

  @override
  String get noReminder => 'Không nhắc';

  @override
  String get atTime => 'Đúng giờ';

  @override
  String get minutesBefore10 => 'Trước 10 phút';

  @override
  String get minutesBefore30 => 'Trước 30 phút';

  @override
  String get hourBefore1 => 'Trước 1 giờ';

  @override
  String get reminderShort10m => '10p';

  @override
  String get reminderShort30m => '30p';

  @override
  String get reminderShort1h => '1g';

  @override
  String get projectLabel => 'Dự án';

  @override
  String get noProject => 'Không có dự án';

  @override
  String get tagLabel => 'Thẻ';

  @override
  String get noTag => 'Không có thẻ';

  @override
  String get priorityLabel => 'Ưu tiên';

  @override
  String get priorityLow => 'Thấp';

  @override
  String get priorityMedium => 'Trung bình';

  @override
  String get priorityHigh => 'Cao';

  @override
  String get saveTask => 'Lưu công việc';

  @override
  String get saveChanges => 'Lưu thay đổi';

  @override
  String get checklistLabel => 'Danh sách kiểm tra';

  @override
  String get addChecklistHint => 'Thêm mục...';

  @override
  String get repeatLabel => 'Lặp lại';

  @override
  String get noRepeat => 'Không lặp lại';

  @override
  String get repeatDaily => 'Hằng ngày';

  @override
  String get repeatWeekly => 'Hằng tuần';

  @override
  String get repeatMonthly => 'Hằng tháng';

  @override
  String get colorLabel => 'Màu sắc';

  @override
  String get timelineOptionsTitle => 'Tùy chọn lịch trình';

  @override
  String get viewModeLabel => 'Chế độ xem';

  @override
  String get modeTimeline => 'Chế độ Lịch trình';

  @override
  String get modeDaily => 'Chế độ Theo ngày';

  @override
  String get firstDayOfWeek => 'Ngày đầu tuần';

  @override
  String get monday => 'Thứ Hai';

  @override
  String get sunday => 'Chủ Nhật';

  @override
  String get firstDayMondayOrder => 'T2 · T3 · T4 · T5 · T6 · T7 · CN';

  @override
  String get firstDaySundayOrder => 'CN · T2 · T3 · T4 · T5 · T6 · T7';

  @override
  String get showCompletedTasks => 'Hiện việc đã xong';

  @override
  String get showCompletedTasksSubtitle =>
      'Ẩn các mục đã đánh dấu để tập trung vào việc đang làm.';

  @override
  String get showCompletedWorkspaceSubtitle =>
      'Hiện hoặc ẩn các công việc đã hoàn thành.';

  @override
  String get overdueTasksTitle => 'Việc quá hạn';

  @override
  String get noOverdueTasks => 'Không có việc quá hạn';

  @override
  String get moveToToday => 'Chuyển sang Hôm nay';

  @override
  String get moveAllToToday => 'Chuyển tất cả sang Hôm nay';

  @override
  String get searchTasksHint => 'Tìm công việc...';

  @override
  String get searchTasksEmpty =>
      'Nhập để tìm công việc, mô tả hoặc danh sách kiểm tra.';

  @override
  String searchNoResults(String query) {
    return 'Không có công việc khớp với \"$query\".';
  }

  @override
  String get calendarEventReadOnly => 'Sự kiện lịch · chỉ đọc';

  @override
  String get prevWeekTooltip => 'Tuần trước';

  @override
  String get nextWeekTooltip => 'Tuần sau';

  @override
  String get boardTitle => 'Bảng';

  @override
  String get allProjects => 'Tất cả dự án';

  @override
  String get searchProjectHint => 'Tìm tên dự án...';

  @override
  String get searchProjectTooltip => 'Tìm dự án';

  @override
  String get closeSearchTooltip => 'Đóng tìm kiếm';

  @override
  String get createProject => 'Tạo dự án';

  @override
  String get editProject => 'Sửa dự án';

  @override
  String get deleteProject => 'Xóa dự án';

  @override
  String get projectOptionsTooltip => 'Tùy chọn dự án';

  @override
  String projectDeleted(String name) {
    return 'Đã xóa dự án \"$name\"';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return 'Xong $done/$total';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return 'Đã xong $done/$total việc';
  }

  @override
  String get projectNotFound => 'Không tìm thấy dự án';

  @override
  String get noProjectsYet => 'Chưa có dự án';

  @override
  String projectSearchEmpty(String query) {
    return 'Không có dự án khớp với \"$query\".';
  }

  @override
  String get noProjectsSubtitle =>
      'Chạm nút thư mục bên dưới để tạo dự án đầu tiên.';

  @override
  String get newProject => 'Dự án mới';

  @override
  String get projectNameLabel => 'Tên dự án';

  @override
  String get projectNameHint => 'VD: Ra mắt Zettask';

  @override
  String get projectNameRequired => 'Vui lòng nhập tên dự án';

  @override
  String get projectColorLabel => 'Màu dự án';

  @override
  String get unplannedTitle => 'Chưa xếp';

  @override
  String activeCountLabel(int count) {
    return '$count đang mở';
  }

  @override
  String get noUnplannedTitle => 'Chưa có việc không ngày';

  @override
  String get noUnplannedSubtitle => 'Chạm + để ghi nhanh việc chưa định ngày.';

  @override
  String get addUnplannedTooltip => 'Thêm việc chưa xếp';

  @override
  String get workspaceTitle => 'Không gian làm việc';

  @override
  String get organizeSection => 'Sắp xếp';

  @override
  String get automationSection => 'Tự động hóa';

  @override
  String get insightsSection => 'Thống kê & giao diện';

  @override
  String get settingsInfoSection => 'Cài đặt & thông tin';

  @override
  String get tagsTitle => 'Thẻ';

  @override
  String get tagsSubtitleEmpty => 'Nhãn màu cho công việc và ghi chú';

  @override
  String tagsCountSubtitle(int count) {
    return '$count thẻ đã lưu';
  }

  @override
  String get newTag => 'Thẻ mới';

  @override
  String get editTag => 'Sửa thẻ';

  @override
  String get tagNameLabel => 'Tên thẻ';

  @override
  String get tagNameRequired => 'Vui lòng nhập tên thẻ';

  @override
  String get tagDeleted => 'Đã xóa thẻ';

  @override
  String get noTagsYet => 'Chưa có thẻ';

  @override
  String tagTasksCount(int count) {
    return '$count việc';
  }

  @override
  String get templatesTitle => 'Mẫu';

  @override
  String get templatesSubtitleEmpty =>
      'Lưu cấu trúc công việc và checklist tái sử dụng';

  @override
  String templatesCountSubtitle(int count) {
    return '$count mẫu sẵn sàng';
  }

  @override
  String get newTemplate => 'Mẫu mới';

  @override
  String get editTemplate => 'Sửa mẫu';

  @override
  String get templateNameLabel => 'Tên mẫu';

  @override
  String get templateNameRequired => 'Vui lòng nhập tên mẫu';

  @override
  String get templateDeleted => 'Đã xóa mẫu';

  @override
  String get noTemplatesYet => 'Chưa có mẫu';

  @override
  String get taskFromTemplateSaved => 'Đã lưu việc từ mẫu';

  @override
  String get notesTitle => 'Ghi chú';

  @override
  String get notesSubtitleEmpty => 'Ghi chú nhanh không ngày';

  @override
  String notesCountSubtitle(int count) {
    return '$count ghi chú đã lưu';
  }

  @override
  String get newNote => 'Ghi chú mới';

  @override
  String get editNote => 'Sửa ghi chú';

  @override
  String get noteTitleLabel => 'Tiêu đề ghi chú';

  @override
  String get noteTitleHint => 'VD: Tóm tắt cuộc họp';

  @override
  String get noteTitleRequired => 'Vui lòng nhập tiêu đề';

  @override
  String get noteContentLabel => 'Nội dung';

  @override
  String get noteContentHint => 'Viết ghi chú tại đây...';

  @override
  String get noteDeleted => 'Đã xóa ghi chú';

  @override
  String get searchNotesHint => 'Tìm ghi chú...';

  @override
  String get noteNotFound => 'Không tìm thấy ghi chú';

  @override
  String get noNotesYet => 'Chưa có ghi chú';

  @override
  String noteSearchEmpty(String query) {
    return 'Không có ghi chú khớp với \"$query\".';
  }

  @override
  String get noNotesSubtitle => 'Chạm + để viết ghi chú nhanh.';

  @override
  String get saveNote => 'Lưu ghi chú';

  @override
  String get repeatingTasksTitle => 'Việc lặp lại';

  @override
  String get repeatingTasksSubtitleEmpty =>
      'Quản lý thói quen hằng ngày, tuần và tháng';

  @override
  String repeatingActiveCount(int count) {
    return '$count lịch lặp đang bật';
  }

  @override
  String get noRepeatingTasks => 'Chưa có việc lặp lại';

  @override
  String get repeatingActionTitle => 'Đây là công việc lặp lại';

  @override
  String get repeatingThisOnly => 'Chỉ lần này';

  @override
  String get repeatingThisAndFollowing => 'Lần này và tất cả lần sau';

  @override
  String get last7DaysUpper => '7 NGÀY QUA';

  @override
  String weeklySummary(int tasks, int checklists) {
    return '$tasks công việc, cộng thêm $checklists mục checklist';
  }

  @override
  String get statsTitle => 'Thống kê';

  @override
  String get range7Days => '7 ngày';

  @override
  String get range30Days => '30 ngày';

  @override
  String get completedToday => 'Xong hôm nay';

  @override
  String get last7DaysLabel => '7 ngày qua';

  @override
  String get last30DaysLabel => '30 ngày qua';

  @override
  String get allTimeLabel => 'Mọi lúc';

  @override
  String get completionRateLabel => 'Tỷ lệ hoàn thành';

  @override
  String get activity7Days => 'Hoạt động 7 ngày qua';

  @override
  String get activity30Days => 'Hoạt động 30 ngày qua';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks việc · $checklists mục';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return 'Tổng $days ngày: $tasks việc và $checklists mục checklist';
  }

  @override
  String get completedByPriority => 'Hoàn thành theo ưu tiên';

  @override
  String get progressByProject => 'Tiến độ theo dự án';

  @override
  String get breakdownByTag => 'Chi tiết theo thẻ';

  @override
  String get habits30Days => 'Thói quen · 30 ngày';

  @override
  String get noProjectsCreated => 'Chưa tạo dự án nào.';

  @override
  String get noTagsCreated => 'Chưa tạo thẻ nào.';

  @override
  String get noActiveHabits => 'Chưa có thói quen nào đang bật.';

  @override
  String completedCountLabel(int count) {
    return '$count xong';
  }

  @override
  String tagBreakdownTrailing(int done, int total) {
    return '$done/$total xong';
  }

  @override
  String habitCompletedRatio(String summary, int done, int scheduled) {
    return '$summary · $done/$scheduled xong';
  }

  @override
  String statsSubtitle(int completed, int percent) {
    return '$completed xong · tỷ lệ $percent%';
  }

  @override
  String get themeTitle => 'Giao diện';

  @override
  String get themeAndColorsTitle => 'Giao diện & màu sắc';

  @override
  String get livePreviewSection => 'Xem trước trực tiếp';

  @override
  String get appearanceModeSection => 'Chế độ hiển thị';

  @override
  String get colorPaletteSection => 'Bảng màu';

  @override
  String get themeLight => 'Sáng';

  @override
  String get themeDark => 'Tối';

  @override
  String get themeSystem => 'Hệ thống';

  @override
  String get themeSystemLight => 'Hệ thống (Sáng)';

  @override
  String get themeSystemDark => 'Hệ thống (Tối)';

  @override
  String get presetDefault => 'Mặc định';

  @override
  String get presetDefaultDesc => 'Chàm & xám đá';

  @override
  String get presetOcean => 'Đại dương';

  @override
  String get presetOceanDesc => 'Xanh dịu nhẹ';

  @override
  String get presetForest => 'Rừng xanh';

  @override
  String get presetForestDesc => 'Xanh xô thơm & ngọc';

  @override
  String get presetTerracotta => 'Đất nung';

  @override
  String get presetTerracottaDesc => 'Cam ấm áp';

  @override
  String get presetPlum => 'Mận tím';

  @override
  String get presetPlumDesc => 'Tím trầm';

  @override
  String get presetMonochrome => 'Đơn sắc';

  @override
  String get presetMonochromeDesc => 'Than chì & đen';

  @override
  String get previewActiveTask => 'Rà soát thiết kế giao diện';

  @override
  String get previewCompletedTask => 'Đồng bộ lịch tuần';

  @override
  String get languageTitle => 'Ngôn ngữ';

  @override
  String get deviceLanguageOption => 'Ngôn ngữ thiết bị (nếu hỗ trợ)';

  @override
  String get appLockTitle => 'Khóa ứng dụng';

  @override
  String get appLockSubtitle => 'Vân tay, khuôn mặt hoặc mã PIN thiết bị';

  @override
  String get appLockLockedTitle => 'Zettask đã khóa';

  @override
  String get appLockLockedSubtitle =>
      'Dùng vân tay, khuôn mặt hoặc mã PIN thiết bị để mở khóa.';

  @override
  String get unlockButton => 'Mở khóa';

  @override
  String get verifyingButton => 'Đang xác minh...';

  @override
  String get appLockUnsupportedError =>
      'Thiết bị chưa bật sinh trắc học hoặc mã PIN khóa màn hình.';

  @override
  String get appLockCancelledError => 'Xác minh bị hủy hoặc thất bại.';

  @override
  String get appLockUnlockFailedError =>
      'Xác thực thất bại. Chạm Mở khóa để thử lại.';

  @override
  String get calendarSyncTitle => 'Đồng bộ lịch';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return 'Đang bật · $count lịch';
  }

  @override
  String get calendarSyncInactiveSubtitle =>
      'Đang tắt · hiển thị sự kiện chỉ đọc';

  @override
  String get grantCalendarPermission => 'Cấp quyền truy cập lịch';

  @override
  String get exportCsvTitle => 'Xuất CSV';

  @override
  String get exportCsvSubtitle => 'Chia sẻ tệp CSV công việc hoặc ghi chú';

  @override
  String get exportDataCsvTitle => 'Xuất dữ liệu CSV';

  @override
  String get exportTasksTitle => 'Xuất công việc';

  @override
  String get exportTasksSubtitle => 'Tất cả việc đã hẹn, chưa xếp và dự án';

  @override
  String get exportNotesTitle => 'Xuất ghi chú';

  @override
  String get exportNotesSubtitle => 'Tất cả ghi chú nhanh';

  @override
  String get exportBothTitle => 'Xuất cả hai';

  @override
  String get exportBothSubtitle => 'Tệp CSV công việc và ghi chú cùng lúc';

  @override
  String get aboutPrivacyTitle => 'Giới thiệu & Quyền riêng tư';

  @override
  String aboutPrivacySubtitle(String version) {
    return 'Phiên bản $version · Ngoại tuyến trước & đám mây tùy chọn';
  }

  @override
  String get aboutTitle => 'Giới thiệu Zettask';

  @override
  String versionLabel(String version) {
    return 'Phiên bản $version';
  }

  @override
  String get privacySyncTitle => 'Quyền riêng tư & Đồng bộ';

  @override
  String get privacySyncDescription =>
      'Mặc định dữ liệu lưu cục bộ trên máy. Đồng bộ đám mây Firebase là tùy chọn khi đăng nhập và bạn có thể xóa vĩnh viễn tài khoản cùng dữ liệu đám mây bất cứ lúc nào.';

  @override
  String get privacyPolicyLabel => 'Chính sách quyền riêng tư';

  @override
  String get privacyLinkCopied => 'Đã sao chép liên kết';

  @override
  String get accountAndSyncTitle => 'Tài khoản & Đồng bộ';

  @override
  String get signInToZettask => 'Đăng nhập tài khoản Zettask';

  @override
  String get accountBannerSubtitle => 'Tùy chọn · sao lưu & đồng bộ đám mây';

  @override
  String get authWelcomeTitle => 'Lưu giữ tiến độ và công việc';

  @override
  String get authWelcomeSubtitle =>
      'Tự động sao lưu lịch trình, dự án và ghi chú lên đám mây. Bạn vẫn có thể dùng Zettask cục bộ mà không cần tài khoản.';

  @override
  String get createNewAccount => 'Tạo tài khoản mới';

  @override
  String get signIn => 'Đăng nhập';

  @override
  String get continueWithGoogle => 'Tiếp tục với Google';

  @override
  String get authTermsNotice =>
      'Khi tiếp tục, bạn đồng ý với Điều khoản & Chính sách quyền riêng tư của Zettask.';

  @override
  String get signInToAccountTitle => 'Đăng nhập Zettask';

  @override
  String get signInToAccountSubtitle =>
      'Dữ liệu cục bộ sẽ được hợp nhất với bản sao lưu đám mây.';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'ten@email.com';

  @override
  String get emailRequired => 'Vui lòng nhập email.';

  @override
  String get emailInvalid => 'Định dạng email không hợp lệ.';

  @override
  String get passwordLabel => 'Mật khẩu';

  @override
  String get passwordHint => 'Nhập mật khẩu';

  @override
  String get passwordNewHint => 'Tối thiểu 6 ký tự';

  @override
  String get passwordRequired => 'Vui lòng nhập mật khẩu.';

  @override
  String get passwordTooShort => 'Mật khẩu phải có ít nhất 6 ký tự.';

  @override
  String get forgotPassword => 'Quên?';

  @override
  String get enterValidEmailFirst => 'Vui lòng nhập email hợp lệ trước.';

  @override
  String passwordResetSent(String email) {
    return 'Đã gửi liên kết đặt lại mật khẩu tới $email.';
  }

  @override
  String get showPasswordTooltip => 'Hiện mật khẩu';

  @override
  String get hidePasswordTooltip => 'Ẩn mật khẩu';

  @override
  String get noAccountPrompt => 'Chưa có tài khoản?';

  @override
  String get createAccountLink => 'Tạo tài khoản';

  @override
  String get createAccountTitle => 'Tạo tài khoản';

  @override
  String get createAccountSubtitle =>
      'Sao lưu toàn bộ công việc, lịch lặp và ghi chú lên đám mây.';

  @override
  String get haveAccountPrompt => 'Đã có tài khoản?';

  @override
  String signedInVia(String provider) {
    return 'Đăng nhập qua $provider';
  }

  @override
  String get syncNowButton => 'Đồng bộ ngay';

  @override
  String get syncingLabel => 'Đang đồng bộ...';

  @override
  String get syncDoneMessage => 'Đồng bộ hoàn tất.';

  @override
  String get syncFailedMessage => 'Đồng bộ thất bại. Kiểm tra kết nối mạng.';

  @override
  String get syncStatusIdle => 'Chưa đồng bộ';

  @override
  String get syncStatusSyncing => 'Đang đồng bộ...';

  @override
  String get syncStatusSynced => 'Đã đồng bộ';

  @override
  String get syncStatusError => 'Lỗi đồng bộ';

  @override
  String lastSyncedPrefix(String time) {
    return 'Lần cuối: $time';
  }

  @override
  String get neverSynced => 'Chưa từng đồng bộ';

  @override
  String get signOutButton => 'Đăng xuất';

  @override
  String get signedOutMessage =>
      'Đã đăng xuất. Dữ liệu cục bộ vẫn được giữ trên máy.';

  @override
  String get deleteAccountButton => 'Xóa tài khoản';

  @override
  String get deleteAccountStep1Title => 'Xóa tài khoản?';

  @override
  String get deleteAccountStep1Body =>
      'Toàn bộ dữ liệu sao lưu đám mây và tài khoản sẽ bị xóa vĩnh viễn. Dữ liệu cục bộ trên thiết bị vẫn được giữ nguyên.';

  @override
  String get deleteAccountStep2Title => 'Xác nhận xóa vĩnh viễn';

  @override
  String get deleteAccountStep2Body =>
      'Thao tác này không thể hoàn tác. Bạn chắc chắn muốn xóa vĩnh viễn tài khoản và toàn bộ dữ liệu đám mây ngay?';

  @override
  String get deleteAccountConfirmButton => 'Có, xóa vĩnh viễn';

  @override
  String get accountDeletedMessage =>
      'Đã xóa vĩnh viễn tài khoản và toàn bộ dữ liệu đám mây.';

  @override
  String get reloginRequiredTitle => 'Cần đăng nhập lại';

  @override
  String get authErrUserNotFound => 'Không tìm thấy tài khoản với email này.';

  @override
  String get authErrWrongPassword => 'Mật khẩu không đúng.';

  @override
  String get authErrInvalidCredential => 'Email hoặc mật khẩu không hợp lệ.';

  @override
  String get authErrInvalidEmail => 'Định dạng email không hợp lệ.';

  @override
  String get authErrEmailInUse => 'Email này đã được dùng cho tài khoản khác.';

  @override
  String get authErrWeakPassword => 'Mật khẩu quá yếu. Dùng ít nhất 6 ký tự.';

  @override
  String get authErrNetwork => 'Lỗi mạng. Vui lòng kiểm tra kết nối internet.';

  @override
  String get authErrRequiresRecentLogin =>
      'Vì lý do bảo mật, hãy đăng xuất và đăng nhập lại trước khi xóa tài khoản.';

  @override
  String get authErrTooManyRequests =>
      'Quá nhiều lần thử. Vui lòng thử lại sau.';

  @override
  String get authErrUserDisabled => 'Tài khoản này đã bị vô hiệu hóa.';

  @override
  String get authErrAccountExistsDifferent =>
      'Email này đã liên kết với phương thức đăng nhập khác.';

  @override
  String get authErrOperationNotAllowed =>
      'Phương thức đăng nhập này chưa được bật.';

  @override
  String get authErrFirebaseUnavailable =>
      'Dịch vụ tài khoản hiện không khả dụng.';

  @override
  String get authErrUnknown => 'Lỗi xác thực. Vui lòng thử lại.';

  @override
  String get widgetTitle => 'Zettask · Hôm nay';

  @override
  String get widgetEmptyText => 'Tất cả công việc hôm nay đã xong.';

  @override
  String get repeatingTasksAndFollowingDeleted =>
      'Đã xóa công việc lặp và các lịch tiếp theo';

  @override
  String get noProjectTasksTitle => 'Chưa có công việc nào trong dự án này';

  @override
  String noProjectTasksSubtitle(String project) {
    return 'Chạm + để thêm công việc vào $project.';
  }

  @override
  String get addTaskToProjectTooltip => 'Thêm công việc vào dự án';

  @override
  String get noTagsSubtitle =>
      'Chạm + để tạo thẻ màu cho công việc và ghi chú.';

  @override
  String get tagOptionsTooltip => 'Tùy chọn thẻ';

  @override
  String get deleteTag => 'Xóa thẻ';

  @override
  String get addTagTooltip => 'Thêm thẻ';

  @override
  String get noTasksWithTag => 'Chưa có công việc nào với thẻ này.';

  @override
  String get addTaskWithTagTooltip => 'Thêm công việc có thẻ';

  @override
  String get tagNameHint => 'VD: Công việc, Cá nhân, Khẩn cấp';

  @override
  String get tagColorLabel => 'Màu thẻ';

  @override
  String get createTag => 'Tạo thẻ';

  @override
  String tagDeletedNamed(String name) {
    return 'Đã xóa thẻ \"$name\"';
  }

  @override
  String get noTemplatesSubtitle =>
      'Lưu cấu trúc công việc và danh sách kiểm tra thường dùng để tạo nhanh hơn.';

  @override
  String get templateOptionsTooltip => 'Tùy chọn mẫu';

  @override
  String get deleteTemplate => 'Xóa mẫu';

  @override
  String get createTemplateTooltip => 'Tạo mẫu';

  @override
  String templateDeletedNamed(String name) {
    return 'Đã xóa mẫu \"$name\"';
  }

  @override
  String get templateNameHint => 'VD: Phát hành hàng tuần';

  @override
  String get defaultTaskTitleLabel => 'Tiêu đề công việc mặc định';

  @override
  String get defaultTaskTitleHint => 'VD: Chuẩn bị bản phát hành';

  @override
  String get timeOptionalLabel => 'Giờ (tùy chọn)';

  @override
  String get clearTimeTooltip => 'Xóa giờ';

  @override
  String get projectOptionalLabel => 'Dự án (tùy chọn)';

  @override
  String get tagOptionalLabel => 'Thẻ (tùy chọn)';

  @override
  String get defaultSubtasksLabel => 'Mục con mặc định';

  @override
  String get addTemplateSubtaskHint => 'Thêm mục con mẫu...';

  @override
  String get saveTemplate => 'Lưu mẫu';

  @override
  String subtasksTotalCount(int count) {
    return '$count mục con';
  }

  @override
  String get useTemplateButton => 'Dùng mẫu';

  @override
  String get pickTemplateTitle => 'Chọn mẫu';

  @override
  String get repeatingTaskDeleted => 'Đã xóa công việc lặp';

  @override
  String get noRepeatingTasksSubtitle =>
      'Chạm + để tạo thói quen hàng ngày, hàng tuần hoặc hàng tháng.';

  @override
  String get addRepeatingTaskTooltip => 'Thêm công việc lặp';

  @override
  String get editRepeatingTask => 'Sửa công việc lặp';

  @override
  String get newRepeatingTask => 'Công việc lặp mới';

  @override
  String get deleteTaskTooltip => 'Xóa công việc';

  @override
  String get scheduleLabel => 'Lịch trình';

  @override
  String get startAndTimeLabel => 'Bắt đầu & Giờ';

  @override
  String get dateRequiredForTime => 'Cần ngày';

  @override
  String get clearDateTooltip => 'Xóa ngày';

  @override
  String get pickTimeFirstReminder => 'Chọn giờ trước để bật lời nhắc.';

  @override
  String get notificationPermissionDenied =>
      'Quyền thông báo đang tắt. Hãy bật trong cài đặt thiết bị.';

  @override
  String get pickDateFirstRepeat => 'Chọn ngày trước để cài đặt lặp lại.';

  @override
  String get subtasksLabel => 'Mục con';

  @override
  String subtasksWithCount(int count) {
    return 'Mục con ($count)';
  }

  @override
  String get removeSubtaskTooltip => 'Xóa mục con';

  @override
  String get addSubtaskTooltip => 'Thêm mục con';

  @override
  String get moveAllOverdueMoved =>
      'Đã chuyển tất cả việc quá hạn sang hôm nay';

  @override
  String get moveAllShort => 'Chuyển tất cả';

  @override
  String get noOverdueTasksSubtitle =>
      'Tất cả công việc từ những ngày trước đã hoàn thành.';

  @override
  String get repeatingDeletePrompt => 'Bạn muốn xóa gì?';

  @override
  String get repeatingEditPrompt => 'Bạn muốn thay đổi gì?';

  @override
  String get repeatingDeleteSingleSub => 'Chỉ xóa lịch này';

  @override
  String get repeatingEditSingleSub => 'Chỉ sửa lịch này';

  @override
  String get repeatingDeleteFollowingSub =>
      'Xóa lịch này và tất cả lịch tiếp theo';

  @override
  String get repeatingEditFollowingSub =>
      'Áp dụng cho lịch này và tất cả lịch tiếp theo';

  @override
  String get deviceCalendarTitle => 'Lịch thiết bị';

  @override
  String get selectCalendarsLabel => 'Chọn lịch';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '$selected/$total đang bật';
  }

  @override
  String get showCalendarEventsTitle => 'Hiển thị sự kiện lịch';

  @override
  String get showCalendarEventsSubtitle =>
      'Sự kiện thiết bị hiển thị theo thứ tự thời gian ở chế độ chỉ đọc.';

  @override
  String get calendarPermDeniedPermanentTitle =>
      'Quyền lịch bị từ chối vĩnh viễn';

  @override
  String get calendarPermRequiredTitle => 'Cần quyền đọc lịch';

  @override
  String get calendarPermDeniedPermanentDesc =>
      'Bật quyền đọc lịch trong Cài đặt thiết bị, rồi chạm Kiểm tra lại.';

  @override
  String get calendarPermRequiredDesc =>
      'Zettask chỉ yêu cầu quyền đọc lịch để hiển thị sự kiện trên dòng thời gian.';

  @override
  String get openSettingsButton => 'Mở Cài đặt';

  @override
  String get checkAgainButton => 'Kiểm tra lại';

  @override
  String get noCalendarsFound => 'Không tìm thấy lịch nào trên thiết bị này.';

  @override
  String get eventDetailTitle => 'Chi tiết sự kiện';

  @override
  String get eventNotesLabel => 'Ghi chú';

  @override
  String get calendarEventReadOnlyBanner =>
      'Sự kiện từ lịch thiết bị (chỉ đọc).';

  @override
  String get markUncompletedSemantics => 'Đánh dấu chưa xong';

  @override
  String get markCompletedSemantics => 'Đánh dấu hoàn thành';

  @override
  String get deleteNoteTooltip => 'Xóa ghi chú';

  @override
  String repeatMonthlyDay(int day) {
    return 'Hàng tháng · ngày $day';
  }

  @override
  String get last30DaysSubtitle => '30 ngày qua';

  @override
  String get allTimeSubtitle => 'Mọi lúc';

  @override
  String get taskCancelled => 'Đã đánh dấu công việc bị hủy';

  @override
  String get taskRestored => 'Đã kích hoạt lại công việc';

  @override
  String get cancelledStatusLabel => 'Đã hủy';

  @override
  String get restoreTaskLabel => 'Khôi phục';

  @override
  String get markCancelledSemantics => 'Đánh dấu đã hủy';

  @override
  String get calendarPermFallbackHint =>
      'Nếu hộp thoại quyền không hiện ra, hãy mở Cài đặt ứng dụng để bật quyền Lịch thủ công.';

  @override
  String get calendarBadgeLabel => 'Lịch';

  @override
  String get calendarSourceLabel => 'Lịch';

  @override
  String get calendarLocationLabel => 'Địa điểm';

  @override
  String get calendarReadOnlyInfo =>
      'Đã đồng bộ từ lịch thiết bị. Mục này chỉ đọc và không thể chỉnh sửa trong Zettask.';

  @override
  String get proBrandTitle => 'Zettask Pro';

  @override
  String get proBadge => 'PRO';

  @override
  String get proPaywallSubtitle =>
      'Đồng bộ đám mây, lịch thiết bị, khóa ứng dụng và giao diện OLED.';

  @override
  String proActiveBannerTitle(String plan) {
    return 'Đang hoạt động — $plan';
  }

  @override
  String get proActiveBannerSubtitle => 'Cảm ơn bạn đã ủng hộ Zettask.';

  @override
  String get proUpgradeBannerSubtitle =>
      'Giao diện AMOLED, màu nhấn tùy chỉnh, kiểu widget & hơn thế';

  @override
  String get proBenefitCloudSync => 'Đồng bộ đám mây & đa thiết bị';

  @override
  String get proBenefitCalendar => 'Tích hợp lịch & ngày lễ quốc gia';

  @override
  String get proBenefitAppLock =>
      'Khóa sinh trắc học & ẩn xem trước ứng dụng gần đây';

  @override
  String get proBenefitProjectsCsv => 'Dự án không giới hạn & xuất CSV';

  @override
  String get proBenefitCustomization =>
      'AMOLED đen thuần, màu nhấn tùy chỉnh & kiểu widget';

  @override
  String get proPlanMonthlyTitle => 'Hàng tháng';

  @override
  String get proPlanMonthlyPrice => '49.000₫ / tháng';

  @override
  String get proPlanYearlyTitle => 'Hàng năm';

  @override
  String get proPlanYearlyPrice => '329.000₫ / năm';

  @override
  String get proPlanYearlyBadge => 'Tiết kiệm nhất';

  @override
  String get proPlanYearlySavings => 'Tiết kiệm ~43%';

  @override
  String get proPlanLifetimeTitle => 'Trọn đời';

  @override
  String get proPlanLifetimePrice => '749.000₫';

  @override
  String get proPlanLifetimeBadge => 'Trả một lần';

  @override
  String get proContinueButton => 'Tiếp tục';

  @override
  String get proAlreadyActiveButton => 'Zettask Pro đang bật';

  @override
  String get proRestorePurchasesButton => 'Khôi phục giao dịch';

  @override
  String get proLegalFootnote =>
      'Gói đăng ký tự động gia hạn trừ khi bạn hủy. Hủy bất kỳ lúc nào trên Google Play.';

  @override
  String get proStoreUnavailableMessage =>
      'Thanh toán Google Play chưa khả dụng trên thiết bị này. Vui lòng thử lại sau.';

  @override
  String get proPurchaseSuccessMessage => 'Zettask Pro đã được kích hoạt.';

  @override
  String get proRestoreSuccessMessage =>
      'Đã khôi phục giao dịch Zettask Pro của bạn.';

  @override
  String get proRestoreEmptyMessage =>
      'Không tìm thấy giao dịch Zettask Pro đang hoạt động trên tài khoản này.';

  @override
  String get proPurchaseFailedMessage =>
      'Không thể hoàn tất giao dịch lúc này. Vui lòng thử lại.';

  @override
  String get debugProSimulationLabel => 'Chế độ nhà phát triển: Giả lập Pro';

  @override
  String get amoledPureBlackTitle => 'AMOLED Đen Thuần';

  @override
  String get amoledPureBlackSubtitle =>
      'Nền tối #000000 thuần giúp tiết kiệm pin màn hình OLED';

  @override
  String get customAccentSection => 'Màu nhấn tùy chỉnh';

  @override
  String get accentMonochrome => 'Đơn sắc';

  @override
  String get accentSage => 'Xanh xô thơm';

  @override
  String get accentIndigo => 'Chàm';

  @override
  String get accentTerracotta => 'Đất nung';

  @override
  String get accentAmber => 'Hổ phách';

  @override
  String get widgetStyleSection => 'Kiểu Widget màn hình chính';

  @override
  String get widgetStyleStandard => 'Tiêu chuẩn';

  @override
  String get widgetStyleAmoled => 'AMOLED';

  @override
  String get widgetStyleTranslucent => 'Bán trong suốt';

  @override
  String get proContextUnlimitedProjects =>
      'Gói miễn phí hỗ trợ tối đa 3 dự án. Nâng cấp Zettask Pro để tạo dự án không giới hạn.';

  @override
  String get proContextCalendarSync =>
      'Đồng bộ lịch thiết bị và ngày lễ quốc gia có trong Zettask Pro.';

  @override
  String get proContextAppLock =>
      'Khóa sinh trắc học và ẩn ứng dụng gần đây có trong Zettask Pro.';

  @override
  String get proContextCsvExport =>
      'Xuất công việc và ghi chú ra CSV có trong Zettask Pro.';

  @override
  String get proContextCloudSync =>
      'Đồng bộ đám mây giữa các thiết bị có trong Zettask Pro.';

  @override
  String get proContextCustomThemes =>
      'AMOLED đen thuần và màu nhấn tùy chỉnh có trong Zettask Pro.';

  @override
  String get proContextWidgetStyles =>
      'Kiểu Widget AMOLED và bán trong suốt có trong Zettask Pro.';

  @override
  String get cloudSyncPausedShort =>
      'Tạm dừng đồng bộ · Dữ liệu cục bộ an toàn';

  @override
  String get cloudSyncPausedTitle => 'Đồng bộ đám mây đang tạm dừng';

  @override
  String get cloudSyncPausedBody =>
      'Gói Zettask Pro chưa hoạt động. Công việc và ghi chú cục bộ vẫn được lưu an toàn trên thiết bị này.';

  @override
  String get resumeSyncWithProButton => 'Tiếp tục đồng bộ với Pro';

  @override
  String get onboardingSkip => 'Bỏ qua';

  @override
  String get onboardingNext => 'Tiếp theo';

  @override
  String get onboardingGetStarted => 'Bắt đầu ngay';

  @override
  String get onboardingSlide1Title => 'Ghi việc nhanh, không xao nhãng';

  @override
  String get onboardingSlide1Body =>
      'Thêm việc hằng ngày trong vài giây, chia nhỏ thành danh sách kiểm tra và hoàn thành chỉ với một chạm.';

  @override
  String get onboardingSlide2Title => 'Dòng thời gian & dự án rõ ràng';

  @override
  String get onboardingSlide2Body =>
      'Xem lịch trình theo thứ tự thời gian, gom việc theo dự án và nhận lời nhắc cục bộ đúng giờ.';

  @override
  String get onboardingSlide3Title => 'Nhanh, ngoại tuyến và riêng tư';

  @override
  String get onboardingSlide3Body =>
      'Mọi dữ liệu được lưu cục bộ trên thiết bị của bạn trước. Không cần tài khoản và dùng ngay không cần mạng.';

  @override
  String get appGuideTitle => 'Hướng dẫn ứng dụng';

  @override
  String get appGuideSubtitle => 'Xem lại giới thiệu ngắn về Zettask';
}
