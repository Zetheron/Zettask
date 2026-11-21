(function () {
  'use strict';

  var LANG_KEY = 'zettask_docs_lang';
  var THEME_KEY = 'zettask_docs_theme';

  var COPY = {
    id: {
      heroKicker: 'ANDROID · OFFLINE-FIRST · SQLITE',
      heroTitle: 'Catat hari Anda. Selesaikan tanpa distraksi.',
      heroLead:
        'Daftar tugas timeline harian yang ringkas untuk Android. Berjalan lokal di perangkat dengan SQLite, cepat dibuka, tanpa paksaan login, dan siap dipakai bahkan saat offline.',
      ctaDownload: 'Unduh APK Beta (Android)',
      ctaGithub: 'Lihat di GitHub',
      specAdsLabel: 'Iklan & pelacak lintas aplikasi',
      specLangLabel: 'Bahasa antarmuka tersedia',
      specDbLabel: 'Penyimpanan lokal offline-first',

      phoneDateEyebrow: 'SAB, 21 NOV',
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
        'Seluruh tugas, proyek, dan catatan disimpan lokal di SQLite perangkat. Tidak wajib membuat akun, tanpa iklan, dan sinkronisasi cloud sepenuhnya opsional.',
      feat2Pill1: 'SQLite lokal',
      feat2Pill2: 'Tanpa wajib login',
      feat2Pill3: '0 SDK iklan',

      feat3Title: 'AMOLED Pure Black & 5 Warna Aksen',
      feat3Desc:
        'Nyaman dipakai malam hari dengan kanvas hitam murni #000000 yang hemat daya layar OLED, dipadukan dengan Monochrome, Sage, Indigo, Terracotta, dan Amber.',

      feat4Title: 'Home Screen Widget Android',
      feat4Desc:
        'Pantau dan centang agenda hari ini langsung dari layar beranda Android tanpa membuka aplikasi. Tersedia dalam gaya Standar, AMOLED, dan Transparan.',
      feat4WidgetHeader: 'ZETTASK · HARI INI',
      feat4WidgetTask1: 'Rapat produk',
      feat4WidgetTask2: 'Bayar tagihan listrik',

      feat5Title: 'Proyek, Prioritas & Statistik Produktivitas',
      feat5Desc:
        'Kelompokkan tugas ke dalam proyek di Board, tandai prioritas Rendah hingga Tinggi, dan pantau konsistensi mingguan lewat grafik ringkas.',

      feat6Title: 'Kunci Biometrik & Ekspor CSV',
      feat6Desc:
        'Lindungi catatan dengan sidik jari atau PIN bawaan Android serta sensor layar Recent Apps. Ekspor tugas dan catatan ke berkas CSV kapan saja.',
      feat6Pill1: 'Biometrik OS',
      feat6Pill2: 'Privasi Recent Apps',
      feat6Pill3: 'Ekspor CSV terbuka',

      proKicker: '02 / PERBANDINGAN PAKET',
      proTitle: 'Gratis untuk harian. Pro untuk kontrol penuh.',
      proSubtitle:
        'Versi Gratis sudah lengkap dipakai setiap hari tanpa batas waktu. Zettask Pro hadir bagi pengguna yang butuh sinkronisasi lintas perangkat dan kustomisasi lanjutan.',

      freeName: 'Gratis',
      freeTagline: 'Lengkap untuk rutinitas harian',
      freeBadge: 'Rp 0',
      freeItem1: 'Timeline harian, sub-tugas (checklist), dan tugas berulang',
      freeItem2: 'Pengingat lokal & alarm tepat waktu',
      freeItem3: 'Hingga 3 proyek di Board, tag warna, template, & catatan cepat',
      freeItem4: 'Statistik produktivitas mingguan & Home Screen Widget standar',
      freeItem5: '100% offline-first (SQLite lokal) tanpa iklan dan tanpa paksaan login',
      freeItem6: 'Mode Terang & Gelap dengan aksen Monochrome',

      proName: 'Zettask Pro',
      proTagline: 'Untuk power user & multi-perangkat',
      proBadge: 'PRO',
      proItem1: 'Semua fitur pada paket Gratis',
      proItem2: 'Proyek tanpa batas di Board',
      proItem3: 'Sinkronisasi Cloud & cadangan multi-perangkat (opsional via Firebase)',
      proItem4: 'Integrasi Kalender Perangkat (read-only) & Hari Libur Nasional',
      proItem5: 'Kunci Aplikasi Biometrik/PIN & privasi layar Recent Apps',
      proItem6: 'Ekspor tugas & catatan ke berkas CSV kapan saja',
      proItem7: 'Tema AMOLED Pure Black (#000000), 4 aksen kustom, & gaya Widget AMOLED/Transparan',

      guaranteeLabel: 'NO DATA LOSS & NO LOCKOUT',
      guaranteeText:
        'Jika langganan Zettask Pro berakhir atau dibatalkan, seluruh tugas, proyek, dan catatan yang sudah Anda buat tetap tersimpan aman di perangkat dan selalu bisa dibuka, diedit, atau dihapus. Tidak ada data yang dikunci atau dihapus.',

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
      heroKicker: 'ANDROID · OFFLINE-FIRST · SQLITE',
      heroTitle: 'Plan your day. Finish without noise.',
      heroLead:
        'A daily timeline to-do list for Android. Stored locally in SQLite, quick to open, no forced account, and built to work reliably even offline.',
      ctaDownload: 'Download Beta APK (Android)',
      ctaGithub: 'View on GitHub',
      specAdsLabel: 'Ads & cross-app trackers',
      specLangLabel: 'Interface languages included',
      specDbLabel: 'Local offline-first storage',

      phoneDateEyebrow: 'SAT, NOV 21',
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
        'Every task, project, and note lives locally in SQLite on your phone. No mandatory sign-in, zero ads, and cloud backup stays strictly optional.',
      feat2Pill1: 'Local SQLite',
      feat2Pill2: 'No forced login',
      feat2Pill3: '0 ad SDKs',

      feat3Title: 'AMOLED Pure Black & 5 Accent Colors',
      feat3Desc:
        'Easy on the eyes at night with a true #000000 canvas for OLED displays, paired with Monochrome, Sage, Indigo, Terracotta, and Amber accents.',

      feat4Title: 'Android Home Screen Widgets',
      feat4Desc:
        'Check today’s agenda and complete tasks straight from your Android home screen. Includes Standard, AMOLED, and Translucent widget styles.',
      feat4WidgetHeader: 'ZETTASK · TODAY',
      feat4WidgetTask1: 'Product sync',
      feat4WidgetTask2: 'Pay utility bill',

      feat5Title: 'Projects, Priorities & Productivity Stats',
      feat5Desc:
        'Group work into Board projects, set Low to High priority levels, and track weekly completion trends with clean tabular charts.',

      feat6Title: 'Biometric App Lock & CSV Export',
      feat6Desc:
        'Protect private lists with Android fingerprint or PIN lock and Recent Apps screen privacy. Export tasks and notes to CSV whenever you want.',
      feat6Pill1: 'OS Biometrics',
      feat6Pill2: 'Recent Apps shield',
      feat6Pill3: 'Open CSV export',

      proKicker: '02 / PLAN COMPARISON',
      proTitle: 'Free for daily use. Pro for power users.',
      proSubtitle:
        'The Free tier covers full everyday planning with no time limit. Zettask Pro adds multi-device cloud sync, calendar overlay, and deeper customization.',

      freeName: 'Free',
      freeTagline: 'Complete for daily routines',
      freeBadge: '$0',
      freeItem1: 'Daily timeline, subtasks (checklists), and repeating routines',
      freeItem2: 'Local notifications & exact reminders',
      freeItem3: 'Up to 3 Board projects, color tags, templates, & quick notes',
      freeItem4: 'Weekly productivity stats & Standard Home Screen Widget',
      freeItem5: '100% offline-first (local SQLite), zero ads, no forced login',
      freeItem6: 'Light & Dark modes with Monochrome accent',

      proName: 'Zettask Pro',
      proTagline: 'For power users & multi-device sync',
      proBadge: 'PRO',
      proItem1: 'Everything included in Free',
      proItem2: 'Unlimited Board projects',
      proItem3: 'Optional Cloud Sync & multi-device backup via Firebase',
      proItem4: 'Device Calendar integration (read-only) & National Holidays',
      proItem5: 'Biometric/PIN App Lock & Recent Apps privacy shield',
      proItem6: 'Export tasks & notes to CSV files anytime',
      proItem7: 'AMOLED Pure Black (#000000), 4 custom accents, & AMOLED/Translucent widgets',

      guaranteeLabel: 'NO DATA LOSS & NO LOCKOUT',
      guaranteeText:
        'If a Zettask Pro subscription ends or is cancelled, every task, project, and note you created remains safely on your device and stays readable, editable, and exportable. Your data is never locked away.',

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
      idTitle: 'Finalisasi catatan rilis v1.4',
      enTitle: 'Finalize v1.4 release notes',
      idTag: 'Kerja',
      enTag: 'Work',
      sub: '3/3'
    },
    {
      id: 't3',
      time: '11:30',
      done: false,
      idTitle: 'Uji notifikasi alarm tepat waktu',
      enTitle: 'Verify exact alarm reminders',
      idTag: 'Zettask',
      enTag: 'Zettask',
      sub: '1/3'
    },
    {
      id: 't4',
      time: '14:00',
      done: false,
      idTitle: 'Review arsitektur sinkronisasi lokal',
      enTitle: 'Review local sync schema',
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
