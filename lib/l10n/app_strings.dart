import 'package:flutter/material.dart';

class AppStrings extends InheritedWidget {
  const AppStrings({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
    required super.child,
  });

  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  static AppStrings of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppStrings>();
    assert(result != null, 'AppStrings not found in context');
    return result!;
  }

  bool get isVi => locale.languageCode == 'vi';

  String t(String key) {
    if (!isVi) return key;
    return _vi[key] ?? key;
  }

  static const _vi = <String, String>{
    'Homepage': 'Trang chủ',
    'Campaigns': 'Chiến dịch',
    'Incidents': 'Sự cố',
    'Organizations': 'Tổ chức',
    'Gifts': 'Quà tặng',
    'Profile': 'Hồ sơ',
    'Maps': 'Bản đồ',
    'Sign in': 'Đăng nhập',
    'Sign up': 'Đăng ký',
    'Sign out': 'Đăng xuất',
    'Notifications': 'Thông báo',
    'Menu': 'Menu',
    'Account': 'Tài khoản',
    'Notification settings': 'Cài đặt thông báo',
    'My points': 'Điểm của tôi',
    'Orders': 'Đơn hàng',
    'Create': 'Tạo mới',
    'Search': 'Tìm kiếm',
    'Filter': 'Lọc',
    'Status': 'Trạng thái',
    'Priority': 'Độ ưu tiên',
    'Save': 'Lưu',
    'Cancel': 'Hủy',
    'Submit': 'Gửi',
    'Loading...': 'Đang tải...',
    'No data': 'Không có dữ liệu',
    'Email': 'Email',
    'Password': 'Mật khẩu',
    'Confirm password': 'Xác nhận mật khẩu',
    'Full name': 'Họ và tên',
    'Forgot password?': 'Quên mật khẩu?',
    'Reset password': 'Đặt lại mật khẩu',
    'Request reset password': 'Yêu cầu đặt lại mật khẩu',
    'Continue with Google': 'Tiếp tục với Google',
    'Don\'t have an account?': 'Chưa có tài khoản?',
    'Already have an account?': 'Đã có tài khoản?',
    'Connecting communities for a cleaner environment.':
        'Kết nối cộng đồng vì môi trường sạch hơn.',
    'Take action': 'Hành động ngay',
    'Explore campaigns': 'Khám phá chiến dịch',
    'My campaigns': 'Chiến dịch của tôi',
    'My incidents': 'Sự cố của tôi',
    'My organizations': 'Tổ chức của tôi',
    'Report an incident': 'Báo cáo sự cố',
    'Join': 'Tham gia',
    'Redeem': 'Đổi quà',
    'Details': 'Chi tiết',
    'Members': 'Thành viên',
    'Tasks': 'Nhiệm vụ',
    'Overview': 'Tổng quan',
    'Location': 'Địa điểm',
    'Description': 'Mô tả',
    'Title': 'Tiêu đề',
    'Page not found': 'Không tìm thấy trang',
    'Back to home': 'Về trang chủ',
    'Language': 'Ngôn ngữ',
    'Points': 'Điểm',
    'Transaction history': 'Lịch sử giao dịch',
    'General information': 'Thông tin chung',
    'SOS': 'SOS',
    'Apply filters': 'Áp dụng bộ lọc',
  };

  @override
  bool updateShouldNotify(AppStrings oldWidget) => locale != oldWidget.locale;
}
