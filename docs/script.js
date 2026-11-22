(function () {
  'use strict';

  var LANG_KEY = 'zettask_docs_lang';
  var THEME_KEY = 'zettask_docs_theme';

  var COPY = {
    id: {
      heroBadge: 'Android Beta • 100% Gratis & Bebas Iklan',
      heroTitle: 'Catat hari Anda. Selesaikan tanpa distraksi.',
      heroLead:
        'Daftar tugas timeline harian yang ringkas untuk Android. Berjalan lokal di perangkat secara offline-first, ringan dibuka, tanpa paksaan login, dan mendukung Material You serta AMOLED Pure Black.',
      ctaDownload: 'Unduh APK Beta (Android)',
      ctaGithub: 'Lihat di GitHub',
      specAdsLabel: 'Iklan & pelacak lintas aplikasi',
      specLangLabel: 'Bahasa antarmuka tersedia',
      specDbLabel: 'Penyimpanan lokal offline-first',

      phoneDateEyebrow: 'MIN, 22 NOV',
      phoneDayTitle: 'Hari Ini',
      phoneAccentLabel: 'AKSEN MOCKUP',
      phoneHint: 'Ketuk tugas untuk mencentang · Klik titik aksen untuk ganti warna',
      phoneAddPlaceholder: 'Tambah tugas demo...',
      phoneAddBtn: 'Tambah',
      phoneFabAria: 'Tambah tugas demo baru',

      featuresKicker: '01 / FITUR UTAMA',
      featuresTitle: 'Dirancang untuk ritme harian.',
      featuresSubtitle:
        'Setiap bagian Zettask dibuat cepat dibaca, nyaman dijangkau satu tangan, dan menjaga data tetap di kendali Anda.',

      feat1Title: 'Timeline & Pengingat Tepat Waktu',
      feat1Desc:
        'Susun tugas harian secara kronologis lengkap dengan checklist sub-tugas, rutinitas berulang, dan alarm lokal Android yang berbunyi tepat waktu.',
      feat1Item1: 'Review desain sprint',
      feat1Item2: 'Kirim ringkasan mingguan',
      feat1Item3: 'Belanja kebutuhan rumah',

      feat2Title: 'Offline-First & Privasi Terjaga',
      feat2Desc:
        'Penyimpanan lokal cepat berbasis SQLite langsung di perangkat Anda. Tanpa paksaan login, bisa dipakai penuh tanpa internet, dan cadangan cloud sepenuhnya opsional.',
      feat2Pill1: 'SQLite lokal',
      feat2Pill2: 'Tanpa wajib login',
      feat2Pill3: 'Ekspor CSV',

      feat3Title: 'Material You & AMOLED Pure Black',
      feat3Desc:
        'Dukungan Dynamic Color Android 12+ yang mengikuti warna wallpaper, kanvas gelap pekat #000000 untuk layar OLED, dan 5 aksen kustom pilihan.',

      feat4Title: 'Home Screen Widget Android',
      feat4Desc:
        'Pantau dan centang agenda hari ini langsung dari layar beranda Android tanpa membuka aplikasi. Tersedia dalam gaya Standar, AMOLED, dan Transparan.',
      feat4WidgetHeader: 'ZETTASK · HARI INI',
      feat4WidgetTask1: 'Rapat produk',
      feat4WidgetTask2: 'Bayar tagihan listrik',

      feat5Title: 'Proyek, Prioritas & Statistik Konsistensi',
      feat5Desc:
        'Kelompokkan tugas ke dalam proyek di Board, tandai prioritas Rendah hingga Tinggi, dan pantau konsistensi penyelesaian 7 dan 30 hari lewat grafik ringkas.',

      feat6Title: 'Ringan & Tanpa Distraksi',
      feat6Desc:
        '100% gratis dan bebas iklan dengan animasi vektor ringan yang tetap mulus di 60fps. Dilengkapi kunci biometrik OS agar catatan pribadi tetap aman.',
      feat6Pill1: '100% Gratis',
      feat6Pill2: 'Bebas Iklan',
      feat6Pill3: 'Animasi Vektor 60fps',

      principlesKicker: '02 / PRINSIP ZETTASK',
      principlesTitle: 'Dibangun dengan janji yang jelas.',
      principlesSubtitle:
        'Alat catatan harian seharusnya tetap tenang, menghormati privasi Anda, dan langsung siap bekerja saat dibuka.',

      prin1Eyebrow: '100% GRATIS · 0 IKLAN',
      prin1Title: 'Tanpa Iklan & Distraksi',
      prin1Desc:
        'Tidak ada banner iklan, pop-up promosi, atau SDK pelacak lintas aplikasi. Ruang layar sepenuhnya milik jadwal dan daftar tugas Anda.',

      prin2Eyebrow: 'NO DATA LOSS & NO LOCKOUT',
      prin2Title: 'Data Milikmu',
      prin2Desc:
        'Seluruh tugas, proyek, dan catatan tetap tersimpan aman di perangkat dan dapat diekspor ke CSV atau dihapus permanen kapan saja tanpa penguncian data.',

      prin3Eyebrow: 'OFFLINE-FIRST · SQLITE',
      prin3Title: 'Cepat Secara Instan',
      prin3Desc:
        'Membaca dan menulis langsung ke database SQLite lokal sehingga Zettask terbuka dalam sekejap dan bekerja normal tanpa sinyal internet maupun akun.',

      footerDesc:
        'Aplikasi daftar tugas timeline harian offline-first untuk Android. Dibangun oleh Zetheron dengan fokus pada kecepatan, kejelasan, dan privasi.',
      footerColProduct: 'Produk',
      footerColLegal: 'Kepatuhan & Kontak',
      footerLinkReleases: 'GitHub Releases (APK Beta)',
      footerLinkRepo: 'Repositori GitHub',
      footerLinkPrivacy: 'Kebijakan Privasi',
      footerLinkDelete: 'Permintaan Hapus Akun',
      footerBottomRight: 'Dibangun untuk Android · Offline-First'
    },
    en: {
      heroBadge: 'Android Beta • 100% Free & Ad-Free',
      heroTitle: 'Plan your day. Finish without noise.',
      heroLead:
        'A minimalist daily timeline to-do list for Android. Built offline-first on your device, quick to open, no forced account, with Material You and AMOLED Pure Black support.',
      ctaDownload: 'Download Beta APK (Android)',
      ctaGithub: 'View on GitHub',
      specAdsLabel: 'Ads & cross-app trackers',
      specLangLabel: 'Interface languages included',
      specDbLabel: 'Local offline-first storage',

      phoneDateEyebrow: 'SUN, NOV 22',
      phoneDayTitle: 'Today',
      phoneAccentLabel: 'MOCKUP ACCENT',
      phoneHint: 'Tap tasks to check them off · Tap a dot to switch accents',
      phoneAddPlaceholder: 'Add a demo task...',
      phoneAddBtn: 'Add',
      phoneFabAria: 'Add new demo task',

      featuresKicker: '01 / CORE FEATURES',
      featuresTitle: 'Built for daily focus.',
      featuresSubtitle:
        'Every screen in Zettask is designed for quick scanning, one-handed comfort, and full ownership of your data.',

      feat1Title: 'Timeline & Exact Reminders',
      feat1Desc:
        'Organize your day chronologically with nested checklists, repeating routines, and local Android exact alarms that fire on time.',
      feat1Item1: 'Sprint design review',
      feat1Item2: 'Send weekly summary',
      feat1Item3: 'Pick up groceries',

      feat2Title: 'Offline-First & Private by Default',
      feat2Desc:
        'Fast local SQLite storage right on your phone. No forced login, full functionality without internet, and cloud backup stays strictly optional.',
      feat2Pill1: 'Local SQLite',
      feat2Pill2: 'No forced login',
      feat2Pill3: 'CSV export',

      feat3Title: 'Material You & AMOLED Pure Black',
      feat3Desc:
        'Android 12+ Dynamic Color that follows your wallpaper palette, true #000000 black canvas for OLED screens, and 5 curated custom accents.',

      feat4Title: 'Android Home Screen Widgets',
      feat4Desc:
        'Check today’s agenda and complete tasks straight from your Android home screen. Includes Standard, AMOLED, and Translucent widget styles.',
      feat4WidgetHeader: 'ZETTASK · TODAY',
      feat4WidgetTask1: 'Product sync',
      feat4WidgetTask2: 'Pay utility bill',

      feat5Title: 'Projects, Priorities & Consistency Stats',
      feat5Desc:
        'Group work into Board projects, set Low to High priority levels, and review 7-day and 30-day completion consistency with clean tabular charts.',

      feat6Title: 'Lightweight & Distraction-Free',
      feat6Desc:
        '100% free and ad-free with crisp 60fps vector motion. Includes Android OS biometric app lock so private lists stay protected.',
      feat6Pill1: '100% Free',
      feat6Pill2: 'Ad-Free',
      feat6Pill3: '60fps Vector Motion',

      principlesKicker: '02 / ZETTASK PRINCIPLES',
      principlesTitle: 'Built on clear promises.',
      principlesSubtitle:
        'A daily task tool should stay calm, respect your privacy, and respond the moment you open it.',

      prin1Eyebrow: '100% FREE · 0 ADS',
      prin1Title: 'No Ads, No Clutter',
      prin1Desc:
        'Zero ad banners, promo pop-ups, or cross-app tracking SDKs. Your screen stays dedicated exclusively to your schedule and tasks.',

      prin2Eyebrow: 'NO DATA LOSS & NO LOCKOUT',
      prin2Title: 'Your Data Stays Yours',
      prin2Desc:
        'Every task, project, and note stays safe on your device and can be exported to CSV or permanently deleted anytime without data lock-in.',

      prin3Eyebrow: 'OFFLINE-FIRST · SQLITE',
      prin3Title: 'Instant by Default',
      prin3Desc:
        'Reads and writes directly to a local SQLite database so Zettask launches in an instant and works reliably with no internet or account required.',

      footerDesc:
        'Minimalist offline-first daily timeline to-do list for Android. Built by Zetheron with a focus on speed, clarity, and privacy.',
      footerColProduct: 'Product',
      footerColLegal: 'Compliance & Contact',
      footerLinkReleases: 'GitHub Releases (Beta APK)',
      footerLinkRepo: 'GitHub Repository',
      footerLinkPrivacy: 'Privacy Policy',
      footerLinkDelete: 'Account Deletion Request',
      footerBottomRight: 'Built for Android · Offline-First'
    }
  };

  var ACCENT_LABELS = {
    monochrome: 'Monochrome',
    sage: 'Sage',
    indigo: 'Indigo',
    terracotta: 'Terracotta',
    amber: 'Amber'
  };

  var MOCK_TASKS = [
    {
      id: 't1',
      time: '07:30',
      done: true,
      idTitle: 'Olahraga pagi 30 menit',
      enTitle: '30-min morning workout',
      idTag: 'Pribadi',
      enTag: 'Personal',
      sub: '2/2'
    },
    {
      id: 't2',
      time: '09:00',
      done: true,
      idTitle: 'Finalisasi catatan rilis Beta',
      enTitle: 'Finalize Beta release notes',
      idTag: 'Kerja',
      enTag: 'Work',
      sub: '3/3'
    },
    {
      id: 't3',
      time: '11:30',
      done: false,
      idTitle: 'Uji tema Material You & AMOLED',
      enTitle: 'Test Material You & AMOLED theme',
      idTag: 'Zettask',
      enTag: 'Zettask',
      sub: '1/3'
    },
    {
      id: 't4',
      time: '14:00',
      done: false,
      idTitle: 'Review arsitektur SQLite lokal',
      enTitle: 'Review local SQLite schema',
      idTag: 'Kerja',
      enTag: 'Work',
      sub: null
    },
    {
      id: 't5',
      time: '18:30',
      done: false,
      idTitle: 'Siapkan agenda besok & baca 20 hlm',
      enTitle: 'Plan tomorrow & read 20 pages',
      idTag: 'Rutinitas',
      enTag: 'Routine',
      sub: null
    }
  ];

  var activeLang = 'id';
  var activeTheme = 'light';

  function getSaved(key) {
    try {
      return localStorage.getItem(key);
    } catch (_) {
      return null;
    }
  }

  function setSaved(key, val) {
    try {
      localStorage.setItem(key, val);
    } catch (_) {}
  }

  function detectInitialLang() {
    var params = new URLSearchParams(window.location.search);
    var q = params.get('lang');
    if (q === 'id' || q === 'en') return q;
    var saved = getSaved(LANG_KEY);
    if (saved === 'id' || saved === 'en') return saved;
    var browserLang = (navigator.language || '').toLowerCase();
    return browserLang.startsWith('en') ? 'en' : 'id';
  }

  function detectInitialTheme() {
    var saved = getSaved(THEME_KEY);
    if (saved === 'light' || saved === 'amoled') return saved;
    if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      return 'amoled';
    }
    return 'light';
  }

  function applyTheme(theme, persist) {
    activeTheme = theme === 'amoled' ? 'amoled' : 'light';
    document.documentElement.setAttribute('data-theme', activeTheme);

    var metaTheme = document.querySelector('meta[name="theme-color"]');
    if (metaTheme) {
      metaTheme.setAttribute('content', activeTheme === 'amoled' ? '#000000' : '#FAFAFA');
    }

    document.querySelectorAll('[data-theme-toggle]').forEach(function (btn) {
      var isAmoled = activeTheme === 'amoled';
      btn.setAttribute('aria-pressed', isAmoled ? 'true' : 'false');
      var labelEl = btn.querySelector('.theme-label');
      if (labelEl) {
        labelEl.textContent = isAmoled ? 'AMOLED' : 'Light';
      }
      btn.setAttribute(
        'aria-label',
        isAmoled
          ? (activeLang === 'en' ? 'Switch to Light theme' : 'Ganti ke tema Terang')
          : (activeLang === 'en' ? 'Switch to AMOLED Pure Black theme' : 'Ganti ke tema AMOLED Pure Black')
      );
    });

    if (persist) {
      setSaved(THEME_KEY, activeTheme);
    }
  }

  function applyLang(lang, persist) {
    activeLang = lang === 'en' ? 'en' : 'id';
    document.documentElement.setAttribute('data-active-lang', activeLang);
    document.documentElement.setAttribute('lang', activeLang);

    var titleAttr = document.body.getAttribute(activeLang === 'en' ? 'data-title-en' : 'data-title-id');
    if (titleAttr) {
      document.title = titleAttr;
    }

    document.querySelectorAll('[data-set-lang]').forEach(function (btn) {
      btn.setAttribute('aria-pressed', btn.getAttribute('data-set-lang') === activeLang ? 'true' : 'false');
    });

    var dict = COPY[activeLang];
    if (dict) {
      document.querySelectorAll('[data-i18n]').forEach(function (el) {
        var key = el.getAttribute('data-i18n');
        if (Object.prototype.hasOwnProperty.call(dict, key)) {
          el.textContent = dict[key];
        }
      });

      document.querySelectorAll('[data-i18n-placeholder]').forEach(function (el) {
        var key = el.getAttribute('data-i18n-placeholder');
        if (Object.prototype.hasOwnProperty.call(dict, key)) {
          el.setAttribute('placeholder', dict[key]);
        }
      });

      document.querySelectorAll('[data-i18n-aria]').forEach(function (el) {
        var key = el.getAttribute('data-i18n-aria');
        if (Object.prototype.hasOwnProperty.call(dict, key)) {
          el.setAttribute('aria-label', dict[key]);
        }
      });
    }

    applyTheme(activeTheme, false);
    renderMockTasks();

    if (persist) {
      setSaved(LANG_KEY, activeLang);
    }
  }

  /* =========================
     Interactive Phone Mockup
     ========================= */
  var taskListEl = document.getElementById('mock-task-list');
  var progressPillEl = document.getElementById('mock-progress-pill');
  var progressFillEl = document.getElementById('mock-progress-fill');
  var phoneDemoEl = document.querySelector('.phone-demo');
  var accentNameEl = document.getElementById('mock-accent-name');
  var quickAddForm = document.getElementById('mock-quick-add');
  var quickAddInput = document.getElementById('mock-quick-input');
  var fabBtn = document.getElementById('mock-fab');

  function updateMockProgress() {
    if (!progressPillEl || !progressFillEl) return;
    var total = MOCK_TASKS.length;
    var doneCount = MOCK_TASKS.filter(function (t) { return t.done; }).length;
    var pct = total === 0 ? 0 : Math.round((doneCount / total) * 100);
    progressPillEl.textContent = doneCount + '/' + total;
    progressFillEl.style.width = pct + '%';
  }

  function renderMockTasks() {
    if (!taskListEl) return;
    taskListEl.innerHTML = '';

    MOCK_TASKS.forEach(function (task) {
      var li = document.createElement('li');
      var btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'mock-task-btn';
      btn.setAttribute('role', 'checkbox');
      btn.setAttribute('aria-checked', task.done ? 'true' : 'false');

      var titleText = task.customTitle
        ? task.customTitle
        : (activeLang === 'en' ? task.enTitle : task.idTitle);
      var tagText = task.customTag
        ? task.customTag
        : (activeLang === 'en' ? task.enTag : task.idTag);

      var checkBox = document.createElement('span');
      checkBox.className = 'mock-checkbox';
      checkBox.setAttribute('aria-hidden', 'true');
      checkBox.innerHTML =
        '<svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M3.5 8.5L6.5 11.5L12.5 4.5"/></svg>';

      var body = document.createElement('span');
      body.className = 'mock-task-body';

      var titleSpan = document.createElement('span');
      titleSpan.className = 'mock-task-title';
      titleSpan.textContent = titleText;

      var meta = document.createElement('span');
      meta.className = 'mock-task-meta';

      var timeSpan = document.createElement('span');
      timeSpan.textContent = task.time;
      meta.appendChild(timeSpan);

      if (tagText) {
        var tagSpan = document.createElement('span');
        tagSpan.className = 'mock-tag';
        var dot = document.createElement('span');
        dot.className = 'mock-tag-dot';
        tagSpan.appendChild(dot);
        tagSpan.appendChild(document.createTextNode(tagText));
        meta.appendChild(tagSpan);
      }

      if (task.sub) {
        var subSpan = document.createElement('span');
        subSpan.textContent = '✓ ' + task.sub;
        meta.appendChild(subSpan);
      }

      body.appendChild(titleSpan);
      body.appendChild(meta);
      btn.appendChild(checkBox);
      btn.appendChild(body);

      btn.addEventListener('click', function () {
        task.done = !task.done;
        btn.setAttribute('aria-checked', task.done ? 'true' : 'false');
        updateMockProgress();
      });

      li.appendChild(btn);
      taskListEl.appendChild(li);
    });

    updateMockProgress();
  }

  function setMockupAccent(accentKey) {
    if (!phoneDemoEl || !Object.prototype.hasOwnProperty.call(ACCENT_LABELS, accentKey)) return;
    phoneDemoEl.setAttribute('data-mockup-accent', accentKey);
    if (accentNameEl) {
      accentNameEl.textContent = ACCENT_LABELS[accentKey];
    }
    document.querySelectorAll('[data-set-accent]').forEach(function (btn) {
      btn.setAttribute('aria-pressed', btn.getAttribute('data-set-accent') === accentKey ? 'true' : 'false');
    });
  }

  function initMockupControls() {
    document.querySelectorAll('[data-set-accent]').forEach(function (btn) {
      btn.addEventListener('click', function () {
        setMockupAccent(btn.getAttribute('data-set-accent'));
      });
    });

    if (fabBtn && quickAddForm && quickAddInput) {
      fabBtn.addEventListener('click', function () {
        var isHidden = quickAddForm.hasAttribute('hidden');
        if (isHidden) {
          quickAddForm.removeAttribute('hidden');
          fabBtn.setAttribute('aria-expanded', 'true');
          quickAddInput.focus();
        } else {
          quickAddForm.setAttribute('hidden', '');
          fabBtn.setAttribute('aria-expanded', 'false');
        }
      });

      quickAddForm.addEventListener('submit', function (e) {
        e.preventDefault();
        var value = quickAddInput.value.trim();
        if (!value) {
          quickAddForm.setAttribute('hidden', '');
          fabBtn.setAttribute('aria-expanded', 'false');
          return;
        }

        var now = new Date();
        var hh = String(now.getHours()).padStart(2, '0');
        var mm = String(now.getMinutes()).padStart(2, '0');

        if (MOCK_TASKS.length >= 6) {
          MOCK_TASKS.shift();
        }

        MOCK_TASKS.push({
          id: 'custom-' + Date.now(),
          time: hh + ':' + mm,
          done: false,
          customTitle: value,
          customTag: 'Demo',
          sub: null
        });

        quickAddInput.value = '';
        quickAddForm.setAttribute('hidden', '');
        fabBtn.setAttribute('aria-expanded', 'false');
        renderMockTasks();
      });

      document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape' && !quickAddForm.hasAttribute('hidden')) {
          quickAddForm.setAttribute('hidden', '');
          fabBtn.setAttribute('aria-expanded', 'false');
          fabBtn.focus();
        }
      });
    }
  }

  /* =========================
     Scroll Reveal Observer
     ========================= */
  function initScrollReveal() {
    var targets = document.querySelectorAll('[data-reveal]');
    if (!targets.length) return;

    var reducedMotion =
      window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    if (reducedMotion || !('IntersectionObserver' in window)) {
      return;
    }

    document.documentElement.classList.add('js-reveal-ready');

    var observer = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add('is-visible');
            observer.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.1, rootMargin: '0px 0px -28px 0px' }
    );

    targets.forEach(function (el) {
      observer.observe(el);
    });
  }

  /* =========================
     Bootstrap
     ========================= */
  document.querySelectorAll('[data-set-lang]').forEach(function (btn) {
    btn.addEventListener('click', function () {
      applyLang(btn.getAttribute('data-set-lang'), true);
    });
  });

  document.querySelectorAll('[data-theme-toggle]').forEach(function (btn) {
    btn.addEventListener('click', function () {
      applyTheme(activeTheme === 'amoled' ? 'light' : 'amoled', true);
    });
  });

  if (window.matchMedia) {
    var mq = window.matchMedia('(prefers-color-scheme: dark)');
    var onSystemChange = function (e) {
      if (!getSaved(THEME_KEY)) {
        applyTheme(e.matches ? 'amoled' : 'light', false);
      }
    };
    if (typeof mq.addEventListener === 'function') {
      mq.addEventListener('change', onSystemChange);
    }
  }

  activeTheme = detectInitialTheme();
  activeLang = detectInitialLang();
  initMockupControls();
  applyTheme(activeTheme, false);
  applyLang(activeLang, false);
  initScrollReveal();
})();
