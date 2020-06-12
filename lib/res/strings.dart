///字符串常量维护

///为所有widget指定唯一id，便于国际化字体切换
class Ids {
  static const String titleHome = 'title_home';
  static const String titleRepos = 'title_repos';
  static const String titleEvents = 'title_events';
  static const String titleSystem = 'title_system';

  static const String titleBookmarks = 'title_bookmarks';
  static const String titleCollection = 'title_collection';
  static const String titleSetting = 'title_setting';
  static const String titleAbout = 'title_about';
  static const String titleShare = 'title_share';
  static const String titleSignOut = 'title_signout';
  static const String titleLanguage = 'title_language';
  static const String titleTheme = 'title_theme';
  static const String titleAuthor = 'title_author';
  static const String titleOther = 'title_other';

  static const String languageAuto = 'language_auto';
  static const String languageZH = 'language_zh';
  static const String languageTW = 'language_tw';
  static const String languageHK = 'language_hk';
  static const String languageEN = 'language_en';

  static const String save = 'save';
  static const String more = 'more';

  static const String recRepos = 'rec_repos';
  static const String recWxArticle = 'rec_wxarticle';

  static const String titleReposTree = 'title_repos_tree';
  static const String titleWxArticleTree = 'title_wxarticle_tree';
  static const String titleSystemTree = 'title_system_tree';

  static const String user_name = 'user_name';
  static const String user_pwd = 'user_pwd';
  static const String user_re_pwd = 'user_re_pwd';
  static const String user_login = 'user_login';
  static const String user_register = 'user_register';
  static const String user_forget_pwd = 'user_forget_pwd';
  static const String user_new_user_hint = 'user_new_user_hint';
  static const String user_login_name_empty = 'user_login_name_empty';
  static const String user_login_pwd_empty = 'user_login_pwd_empty';
  static const String user_login_re_pwd_empty = 'user_login_re_pwd_empty';
  static const String user_login_name_length_too_short =
      'user_login_name_length_too_short';
  static const String user_login_pwd_length_too_short = 'user_login_pwd_length_too_short';
  static const String user_login_re_pwd_length_too_short =
      'user_login_re_pwd_length_too_short';
  static const String user_login_success = 'user_login_success';
  static const String user_register_success = 'user_register_success';
  static const String user_register_pwd_not_equal = 'user_register_pwd_not_equal';

  static const String confirm = 'confirm';
  static const String cancel = 'cancel';

  static const String jump_count = 'jump_count';
}

///国际化常量
Map<String, Map<String, String>> localizedSimpleValues = {
  'en': {
    Ids.titleHome: 'Home',
    Ids.titleRepos: 'Repos',
    Ids.titleEvents: 'Events',
    Ids.titleSystem: 'System',
    Ids.titleBookmarks: 'Bookmarks',
    Ids.titleSetting: 'Setting',
    Ids.titleAbout: 'About',
    Ids.titleShare: 'Share',
    Ids.titleSignOut: 'Sign Out',
    Ids.titleLanguage: 'Language',
    Ids.languageAuto: 'Auto',
  },
  'zh': {
    Ids.titleHome: '主页',
    Ids.titleRepos: '项目',
    Ids.titleEvents: '动态',
    Ids.titleSystem: '体系',
    Ids.titleBookmarks: '书签',
    Ids.titleSetting: '设置',
    Ids.titleAbout: '关于',
    Ids.titleShare: '分享',
    Ids.titleSignOut: '注销',
    Ids.titleLanguage: '多语言',
    Ids.languageAuto: '跟随系统',
  },
};

Map<String, Map<String, Map<String, String>>> localizedValues = {
  'en': {
    'US': {
      Ids.titleHome: 'Home',
      Ids.titleRepos: 'Repos',
      Ids.titleEvents: 'Events',
      Ids.titleSystem: 'System',
      Ids.titleBookmarks: 'Bookmarks',
      Ids.titleCollection: 'Collection',
      Ids.titleSetting: 'Setting',
      Ids.titleAbout: 'About',
      Ids.titleShare: 'Share',
      Ids.titleSignOut: 'Sign Out',
      Ids.titleLanguage: 'Language',
      Ids.languageAuto: 'Auto',
      Ids.save: 'Save',
      Ids.more: 'More',
      Ids.recRepos: 'Reco Repos',
      Ids.recWxArticle: 'Reco WxArticle',
      Ids.titleReposTree: 'Repos Tree',
      Ids.titleWxArticleTree: 'Wx Article',
      Ids.titleTheme: 'Theme',
      Ids.user_name: 'user name',
      Ids.user_pwd: 'password',
      Ids.user_re_pwd: 'confirm password',
      Ids.user_login: 'Login',
      Ids.user_register: 'Register',
      Ids.user_forget_pwd: 'Forget the password?',
      Ids.user_new_user_hint: 'New users? ',
      Ids.confirm: 'Confirm',
      Ids.cancel: 'Cancel',
      Ids.jump_count: 'Jump %\$0\$s',
      Ids.user_login_name_empty: 'User name is empty',
      Ids.user_login_pwd_empty: 'Password is empty',
      Ids.user_login_re_pwd_empty: 'RePassword is empty',
      Ids.user_login_name_length_too_short: 'User name at least 6 words',
      Ids.user_login_pwd_length_too_short: 'Password at least 6 words',
      Ids.user_login_re_pwd_length_too_short: 'RePassword at least 6 words',
      Ids.user_login_success: 'Login success',
      Ids.user_register_success: 'Register success',
      Ids.user_register_pwd_not_equal: 'Two passwords are inconsistent',
    }
  },
  'zh': {
    'CN': {
      Ids.titleHome: '主页',
      Ids.titleRepos: '项目',
      Ids.titleEvents: '动态',
      Ids.titleSystem: '体系',
      Ids.titleBookmarks: '书签',
      Ids.titleCollection: '收藏',
      Ids.titleSetting: '设置',
      Ids.titleAbout: '关于',
      Ids.titleShare: '分享',
      Ids.titleSignOut: '注销',
      Ids.titleLanguage: '多语言',
      Ids.languageAuto: '跟随系统',
      Ids.languageZH: '简体中文',
      Ids.languageTW: '繁體中文（台灣）',
      Ids.languageHK: '繁體中文（香港）',
      Ids.languageEN: 'English',
      Ids.save: '保存',
      Ids.more: '更多',
      Ids.recRepos: '推荐项目',
      Ids.recWxArticle: '推荐公众号',
      Ids.titleReposTree: '项目分类',
      Ids.titleWxArticleTree: '公众号',
      Ids.titleTheme: '主题',
      Ids.user_name: '用户名',
      Ids.user_pwd: '密码',
      Ids.user_re_pwd: '确认密码',
      Ids.user_login: '登录',
      Ids.user_register: '注册',
      Ids.user_forget_pwd: '忘记密码？',
      Ids.user_new_user_hint: '新用户？',
      Ids.confirm: '确认',
      Ids.cancel: '取消',
      Ids.jump_count: '跳过 %\$0\$s',
      Ids.user_login_name_empty: '用户名不能为空',
      Ids.user_login_pwd_empty: '密码不能为空',
      Ids.user_login_re_pwd_empty: '确认密码不能为空',
      Ids.user_login_name_length_too_short: '用户名至少6位',
      Ids.user_login_pwd_length_too_short: '密码至少6位',
      Ids.user_login_re_pwd_length_too_short: '确认密码至少6位',
      Ids.user_login_success: '登录成功',
      Ids.user_register_success: '注册成功',
      Ids.user_register_pwd_not_equal: '两次密码不一致',
    },
    'HK': {
      Ids.titleHome: '主頁',
      Ids.titleRepos: '項目',
      Ids.titleEvents: '動態',
      Ids.titleSystem: '體系',
      Ids.titleBookmarks: '書簽',
      Ids.titleCollection: '收藏',
      Ids.titleSetting: '設置',
      Ids.titleAbout: '關於',
      Ids.titleShare: '分享',
      Ids.titleSignOut: '註銷',
      Ids.titleLanguage: '語言',
      Ids.languageAuto: '與系統同步',
      Ids.save: '儲存',
      Ids.more: '更多',
      Ids.recRepos: '推荐项目',
      Ids.recWxArticle: '推荐公众号',
      Ids.titleReposTree: '项目分类',
      Ids.titleWxArticleTree: '公众号',
      Ids.titleTheme: '主題',
      Ids.user_name: '用户名',
      Ids.user_pwd: '密码',
      Ids.user_re_pwd: '确认密码',
      Ids.user_login: '登录',
      Ids.user_register: '注册',
      Ids.user_forget_pwd: '忘记密码？',
      Ids.user_new_user_hint: '新用户？',
      Ids.confirm: '确认',
      Ids.cancel: '取消',
      Ids.jump_count: '跳过 %\$0\$s',
      Ids.user_login_name_empty: '用戶名不能為空',
      Ids.user_login_pwd_empty: '密碼不能為空',
      Ids.user_login_re_pwd_empty: '確認密碼不能為空',
      Ids.user_login_name_length_too_short: '用戶名至少6位',
      Ids.user_login_pwd_length_too_short: '密碼至少6位',
      Ids.user_login_re_pwd_length_too_short: '確認密碼至少6位',
      Ids.user_login_success: '登錄成功',
      Ids.user_register_success: '註冊成功',
      Ids.user_register_pwd_not_equal: '兩次密碼不一致',
    },
    'TW': {
      Ids.titleHome: '主頁',
      Ids.titleRepos: '項目',
      Ids.titleEvents: '動態',
      Ids.titleSystem: '體系',
      Ids.titleBookmarks: '書簽',
      Ids.titleCollection: '收藏',
      Ids.titleSetting: '設置',
      Ids.titleAbout: '關於',
      Ids.titleShare: '分享',
      Ids.titleSignOut: '註銷',
      Ids.titleLanguage: '語言',
      Ids.languageAuto: '與系統同步',
      Ids.save: '儲存',
      Ids.more: '更多',
      Ids.recRepos: '推荐项目',
      Ids.recWxArticle: '推荐公众号',
      Ids.titleReposTree: '项目分类',
      Ids.titleWxArticleTree: '公众号',
      Ids.titleTheme: '主題',
      Ids.user_name: '用户名',
      Ids.user_pwd: '密码',
      Ids.user_re_pwd: '确认密码',
      Ids.user_login: '登录',
      Ids.user_register: '注册',
      Ids.user_forget_pwd: '忘记密码？',
      Ids.user_new_user_hint: '新用户？',
      Ids.confirm: '确认',
      Ids.cancel: '取消',
      Ids.jump_count: '跳过 %\$0\$s',
      Ids.user_login_name_empty: '用戶名不能為空',
      Ids.user_login_pwd_empty: '密碼不能為空',
      Ids.user_login_re_pwd_empty: '確認密碼不能為空',
      Ids.user_login_name_length_too_short: '用戶名至少6位',
      Ids.user_login_pwd_length_too_short: '密碼至少6位',
      Ids.user_login_re_pwd_length_too_short: '確認密碼至少6位',
      Ids.user_login_success: '登錄成功',
      Ids.user_register_success: '註冊成功',
      Ids.user_register_pwd_not_equal: '兩次密碼不一致',
    }
  }
};
