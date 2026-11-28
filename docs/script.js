(function () {
  'use strict';

  var LANG_KEY = 'zettask_docs_lang';
  var THEME_KEY = 'zettask_docs_theme';
  var ACCENT_KEY = 'zettask_docs_accent';
  var DEMO_STATE_KEY = 'zettask_landing_demo_v2';

  var THEME_ORDER = ['light', 'dark', 'amoled'];
  var THEME_LABELS = { light: 'Light', dark: 'Dark', amoled: 'AMOLED' };
  var ACCENT_NAMES = {
    indigo: 'Indigo',
    sage: 'Sage',
    terracotta: 'Terracotta',
    amber: 'Amber',
    monochrome: 'Monochrome'
  };

  var HERO_RING_CIRC = 125.66;
  var BENTO_RING_CIRC = 289.03;

  var COPY = {
    id: {
      skipLink: 'Lompat ke konten utama',
      navFeatures: 'Fitur',
      navSolutions: 'Solusi',
      navPrinciples: 'Prinsip',
      navPrivacy: 'Privasi',
      navDelete: 'Hapus Akun',
      navDownloadApk: 'Unduh APK',
      navOpenWeb: 'Buka Web App',

      heroBadge: 'Android Beta • 100% Gratis & Offline-First',
      heroTitleMain: 'Atur harimu.',
      heroTitleSub: 'Selesaikan tanpa distraksi.',
      heroLead:
        'Timeline tugas harian dengan sub-tugas Cancel & Undo, Focus Timer bawaan, serta kanvas AMOLED Pure Black #000000. Cepat dibuka dan tersimpan langsung di perangkat Anda.',
      heroCtaWeb: 'Buka Web App',
      heroCtaApk: 'Unduh APK Beta',
      heroPill1: 'Offline SQLite',
      heroPill3: '16 Bahasa',
      heroPill4: 'Tanpa Wajib Login',

      heroNotifMeta: 'Pengingat · 13:30',
      heroNotifTitle: 'Persiapan Rilis Android',
      heroNotifSub1: '○ Uji kontras AMOLED #000000',
      heroNotifSub2: '○ Cek alarm pengingat lokal',
      heroCardTitle: 'Timeline Hari Ini',
      heroSubHeader: 'Sub-tugas aktif',
      heroSubDoneItem: 'Susun skema database SQLite lokal',
      heroSubCancelItem: 'Tambahkan SDK iklan pihak ketiga',
      heroSubToast: 'Dibatalkan · Dikecualikan dari progres',
      heroFloatRingSub: 'Progres harian',

      timerStart: 'Mulai',
      timerPause: 'Jeda',

      solKicker: 'Solusi',
      solTitle: 'Dirancang untuk ritme kerja yang tenang dan terukur',
      solSub:
        'Tiga fondasi praktis yang membuat pencatatan harian di Web maupun Android terasa ringan sejak detik pertama dibuka.',
      sol1Title: 'Penyimpanan Lokal Offline-First',
      sol1Desc:
        'Bekerja penuh tanpa sinyal internet menggunakan SQLite di Android dan penyimpanan lokal di Web. Tidak ada paksaan membuat akun sebelum mencatat.',
      sol2Title: 'Sub-tugas Cerdas (Cancel & Undo)',
      sol2Desc:
        'Rencana berubah di tengah hari? Batalkan sub-tugas tanpa menghapus riwayatnya dan tanpa merusak persentase penyelesaian tugas utama.',
      sol3Title: 'Material You & AMOLED #000000',
      sol3Desc:
        'Menyatu dengan palet Dynamic Color Android 12+, hemat baterai di layar OLED lewat kanvas hitam murni #000000, serta memiliki 5 warna aksen pilihan.',

      featKicker: 'Fitur Interaktif',
      featTitle: 'Coba langsung fitur inti Zettask di halaman ini',
      featSub:
        'Setiap kartu di bawah ini aktif dan interaktif. Batalkan sub-tugas, jalankan pengatur waktu fokus, atau ganti warna seluruh halaman.',

      bento1Parent: 'Persiapan Rilis Produk',
      bento1Toast: 'Sub-tugas dibatalkan · Dikecualikan dari progres',
      bento1Undo: 'Urungkan',
      bento1Title: 'Sub-tugas dengan Cancel (✕) & Undo Snackbar',
      bento1Desc:
        'Klik centang atau tombol ✕ di atas. Sub-tugas yang dibatalkan langsung dikecualikan dari hitungan progres aktif dan dilengkapi tombol Urungkan.',

      bento2Title: 'Focus Timer (Pomodoro & Stopwatch)',
      bento2Desc:
        'Mulai sesi fokus 25 menit, istirahat singkat 5 menit, atau hitung waktu kerja secara presisi tanpa berpindah tab.',

      bento3CompletedLabel: 'Tugas Demo Selesai',
      bento3TriggerBtn: 'Centang Tugas Berikutnya',
      bento3Title: 'Live Progress Ring & Statistik Konsistensi',
      bento3Desc:
        'Grafik cincin vektor mulus dengan angka tabular-nums yang terhubung langsung ke penyelesaian daftar tugas Anda secara real-time.',

      studioSurfaceLabel: 'MODE KANVAS',
      studioAccentLabel: '5 WARNA AKSEN HALAMAN',
      bento4Title: 'Theme Studio (Light, Dark, AMOLED & 5 Aksen)',
      bento4Desc:
        'Klik salah satu warna aksen atau mode latar di atas untuk mengubah tampilan seluruh halaman ini sekaligus menyimpannya ke Zettask Web App.',

      prinKicker: 'Prinsip & Ekosistem Android',
      prinTitle: 'Janji privasi tegas dan akses cepat dari layar beranda',
      prinSub:
        'Dibangun tanpa iklan dan dilengkapi widget layar beranda Android agar agenda hari ini selalu terlihat dalam sekali pandang.',
      prin1Title: 'Tanpa Iklan & Tanpa Keramaian',
      prin1Desc:
        'Nol banner promosi, nol pop-up pengganggu, dan nol SDK pelacak lintas aplikasi. Ruang layar murni didedikasikan untuk daftar tugas Anda.',
      prin2Title: 'Data Sepenuhnya Milik Anda',
      prin2Desc:
        'Tersimpan aman di perangkat lokal, dapat diekspor ke CSV kapan saja, dan tidak pernah mengunci akses catatan Anda di balik kewajiban login.',
      prin3Title: 'Terbuka Instan & Responsif',
      prin3Desc:
        'Pembacaan database lokal yang instan dipadukan dengan transisi pegas ringan dan kunci keamanan biometrik bawaan Android.',

      widgetBadge: 'Android Home Screen Widget',
      widgetTitle: 'Centang agenda hari ini langsung dari layar utama Android',
      widgetDesc:
        'Hadir dalam tiga gaya permukaan: Standard terang bersih, AMOLED hitam pekat #000000, dan Translucent yang menyatu dengan wallpaper favorit Anda.',
      widgetCtaApk: 'Pasang APK Android Beta',
      widgetCtaWeb: 'Coba Zettask Web',
      widgetSysDate: 'Sabtu, 28 Nov',
      widgetHeader: 'Zettask · Hari Ini',
      widgetItem1: 'Olahraga pagi 25 menit',
      widgetItem2: 'Sinkronisasi desain produk',
      widgetItem3: 'Bayar tagihan internet',

      footerDesc:
        'Aplikasi daftar tugas timeline harian offline-first untuk Android dan Web. Dibangun oleh Zetheron dengan fokus pada kecepatan, kejelasan, dan privasi.',
      footerColProduct: 'Produk',
      footerColLegal: 'Kepatuhan & Kontak',
      footerLinkWeb: 'Zettask Web App',
      footerLinkReleases: 'GitHub Releases (APK Beta)',
      footerLinkRepo: 'Repositori GitHub',
      footerLinkPrivacy: 'Kebijakan Privasi',
      footerLinkDelete: 'Permintaan Hapus Akun',
      footerBottomRight: 'Offline-First · Android & Web'
    },
    en: {
      skipLink: 'Skip to main content',
      navFeatures: 'Features',
      navSolutions: 'Solutions',
      navPrinciples: 'Principles',
      navPrivacy: 'Privacy',
      navDelete: 'Delete Account',
      navDownloadApk: 'Download APK',
      navOpenWeb: 'Open Web App',

      heroBadge: 'Android Beta • 100% Free & Offline-First',
      heroTitleMain: 'Plan your day.',
      heroTitleSub: 'Finish without noise.',
      heroLead:
        'Daily task timeline with Cancel & Undo sub-tasks, a built-in Focus Timer, and a true #000000 AMOLED Pure Black canvas. Opens in an instant and stays local on your device.',
      heroCtaWeb: 'Open Web App',
      heroCtaApk: 'Download Beta APK',
      heroPill1: 'Offline SQLite',
      heroPill3: '16 Languages',
      heroPill4: 'No Forced Login',

      heroNotifMeta: 'Reminder · 13:30',
      heroNotifTitle: 'Android Release Prep',
      heroNotifSub1: '○ Verify AMOLED #000000 contrast',
      heroNotifSub2: '○ Test exact local reminder alarm',
      heroCardTitle: "Today's Timeline",
      heroSubHeader: 'Active sub-tasks',
      heroSubDoneItem: 'Finalize local SQLite schema',
      heroSubCancelItem: 'Add third-party ad tracker SDK',
      heroSubToast: 'Cancelled · Excluded from progress',
      heroFloatRingSub: 'Daily progress',

      timerStart: 'Start',
      timerPause: 'Pause',

      solKicker: 'Solutions',
      solTitle: 'Built for a calm, measurable daily workflow',
      solSub:
        'Three practical foundations that keep daily planning fast on both Web and Android the moment you open it.',
      sol1Title: 'Local Offline-First Storage',
      sol1Desc:
        'Works reliably with zero internet using SQLite on Android and local storage on Web. No forced account creation before you start planning.',
      sol2Title: 'Smart Sub-tasks (Cancel & Undo)',
      sol2Desc:
        'Plans shifted mid-day? Cancel a sub-task without deleting history and without distorting your active completion percentage.',
      sol3Title: 'Material You & AMOLED #000000',
      sol3Desc:
        'Adapts to Android 12+ Dynamic Color palettes, saves OLED power with a true #000000 black canvas, and ships with 5 custom accents.',

      featKicker: 'Interactive Features',
      featTitle: 'Test core Zettask tools right on this page',
      featSub:
        'Every card below is live. Cancel sub-tasks, run a focus session, or re-theme the entire page in one click.',

      bento1Parent: 'Product Release Checklist',
      bento1Toast: 'Sub-task cancelled · Excluded from active progress',
      bento1Undo: 'Undo',
      bento1Title: 'Sub-tasks with Cancel (✕) & Undo Snackbar',
      bento1Desc:
        'Click any checkbox or ✕ button above. Cancelled sub-tasks are excluded from active progress math and trigger an instant Undo bar.',

      bento2Title: 'Focus Timer (Pomodoro & Stopwatch)',
      bento2Desc:
        'Run a 25-minute focus block, take a 5-minute breather, or track open-ended work sessions without leaving your task view.',

      bento3CompletedLabel: 'Completed Demo Tasks',
      bento3TriggerBtn: 'Complete Next Task',
      bento3Title: 'Live Progress Ring & Consistency Stats',
      bento3Desc:
        'Smooth vector ring animation with crisp tabular-nums counters wired directly to your live task completion state.',

      studioSurfaceLabel: 'CANVAS MODE',
      studioAccentLabel: '5 LIVE PAGE ACCENTS',
      bento4Title: 'Theme Studio (Light, Dark, AMOLED & 5 Accents)',
      bento4Desc:
        'Pick any accent dot or canvas mode above to recolor this entire landing page live and sync your choice into Zettask Web App.',

      prinKicker: 'Principles & Android Ecosystem',
      prinTitle: 'Clear privacy promises and home screen speed',
      prinSub:
        'Built completely ad-free and paired with native Android home screen widgets so today’s schedule stays one glance away.',
      prin1Title: 'No Ads & No Clutter',
      prin1Desc:
        'Zero ad banners, zero promo pop-ups, and zero cross-app tracking SDKs. Every pixel belongs to your daily schedule.',
      prin2Title: 'Your Data Stays Yours',
      prin2Desc:
        'Stored locally on your device, exportable to CSV anytime, and never locked behind mandatory cloud sign-ins.',
      prin3Title: 'Instant Speed & 60fps Motion',
      prin3Desc:
        'Direct local database reads paired with responsive spring transitions and native Android biometric app lock.',

      widgetBadge: 'Android Home Screen Widget',
      widgetTitle: 'Check off today’s tasks straight from your Android home screen',
      widgetDesc:
        'Available in three crisp finishes: clean light Standard, true #000000 AMOLED black, and Translucent glass that blends into your wallpaper.',
      widgetCtaApk: 'Install Android Beta APK',
      widgetCtaWeb: 'Launch Zettask Web',
      widgetSysDate: 'Saturday, Nov 28',
      widgetHeader: 'Zettask · Today',
      widgetItem1: '25-min morning run',
      widgetItem2: 'Product design sync',
      widgetItem3: 'Pay fiber internet bill',

      footerDesc:
        'Offline-first daily timeline to-do list for Android and Web. Built by Zetheron with a focus on speed, clarity, and privacy.',
      footerColProduct: 'Product',
      footerColLegal: 'Compliance & Contact',
      footerLinkWeb: 'Zettask Web App',
      footerLinkReleases: 'GitHub Releases (Beta APK)',
      footerLinkRepo: 'GitHub Repository',
      footerLinkPrivacy: 'Privacy Policy',
      footerLinkDelete: 'Account Deletion Request',
      footerBottomRight: 'Offline-First · Android & Web'
    }
  };

  var activeLang = 'id';
  var activeTheme = 'light';
  var activeAccent = 'indigo';

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

  function createDefaultDemoState() {
    return {
      heroTasks: [
        {
          id: 'ht1',
          done: true,
          time: '08:30',
          idText: 'Susun prioritas sprint mingguan',
          enText: 'Plan weekly sprint priorities'
        },
        {
          id: 'ht2',
          done: true,
          time: '10:00',
          idText: 'Uji kontras tema AMOLED #000000',
          enText: 'Verify AMOLED #000000 contrast'
        },
        {
          id: 'ht3',
          done: false,
          time: '13:30',
          idText: 'Coba sub-tugas Cancel & Undo 5 detik',
          enText: 'Test sub-task Cancel & 5s Undo'
        },
        {
          id: 'ht4',
          done: false,
          time: '16:00',
          idText: 'Publikasi Zettask Web ke GitHub Pages',
          enText: 'Deploy Zettask Web to GitHub Pages'
        }
      ],
      bentoSubtasks: [
        {
          id: 'bs1',
          done: true,
          cancelled: false,
          idText: 'Validasi penyimpanan lokal offline',
          enText: 'Validate local offline storage'
        },
        {
          id: 'bs2',
          done: false,
          cancelled: false,
          idText: 'Audit responsivitas mobile 375px',
          enText: 'Audit 375px mobile responsiveness'
        },
        {
          id: 'bs3',
          done: false,
          cancelled: false,
          idText: 'Pasang banner iklan pihak ketiga',
          enText: 'Add third-party ad banner SDK'
        }
      ]
    };
  }

  function loadDemoState() {
    try {
      var raw = getSaved(DEMO_STATE_KEY);
      if (!raw) return createDefaultDemoState();
      var parsed = JSON.parse(raw);
      if (!parsed || !Array.isArray(parsed.heroTasks) || !Array.isArray(parsed.bentoSubtasks)) {
        return createDefaultDemoState();
      }
      return parsed;
    } catch (_) {
      return createDefaultDemoState();
    }
  }

  function saveDemoState() {
    setSaved(DEMO_STATE_KEY, JSON.stringify(demoState));
  }

  var demoState = loadDemoState();

  /* =========================
     Theme, Accent & Language Engine
     ========================= */
  function detectInitialLang() {
    var params = new URLSearchParams(window.location.search);
    var q = params.get('lang');
    if (q === 'id' || q === 'en') return q;
    var saved = getSaved(LANG_KEY);
    if (saved === 'id' || saved === 'en') return saved;
    var nav = (navigator.language || '').toLowerCase();
    return nav.indexOf('en') === 0 ? 'en' : 'id';
  }

  function detectInitialTheme() {
    var saved = getSaved(THEME_KEY);
    if (saved === 'light' || saved === 'dark' || saved === 'amoled') return saved;
    if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      return 'amoled';
    }
    return 'light';
  }

  function detectInitialAccent() {
    var saved = getSaved(ACCENT_KEY);
    return Object.prototype.hasOwnProperty.call(ACCENT_NAMES, saved) ? saved : 'indigo';
  }

  function updateStudioStatusText() {
    var statusEl = document.getElementById('studio-status-text');
    if (statusEl) {
      statusEl.textContent = (ACCENT_NAMES[activeAccent] || 'Indigo') + ' · ' + THEME_LABELS[activeTheme];
    }
  }

  function applyTheme(theme, persist) {
    activeTheme = THEME_ORDER.indexOf(theme) !== -1 ? theme : 'light';
    document.documentElement.setAttribute('data-theme', activeTheme);

    var metaTheme = document.querySelector('meta[name="theme-color"]');
    if (metaTheme) {
      var map = { light: '#F5F5F4', dark: '#0D0F13', amoled: '#000000' };
      metaTheme.setAttribute('content', map[activeTheme]);
    }

    document.querySelectorAll('[data-theme-toggle]').forEach(function (btn) {
      btn.setAttribute('aria-pressed', activeTheme !== 'light' ? 'true' : 'false');
      var label = btn.querySelector('.theme-label');
      if (label) label.textContent = THEME_LABELS[activeTheme];
    });

    document.querySelectorAll('[data-page-theme]').forEach(function (btn) {
      btn.setAttribute('aria-pressed', btn.getAttribute('data-page-theme') === activeTheme ? 'true' : 'false');
    });

    updateStudioStatusText();
    if (persist) setSaved(THEME_KEY, activeTheme);
  }

  function applyAccent(accent, persist) {
    activeAccent = Object.prototype.hasOwnProperty.call(ACCENT_NAMES, accent) ? accent : 'indigo';
    document.documentElement.setAttribute('data-accent', activeAccent);

    document.querySelectorAll('[data-page-accent]').forEach(function (btn) {
      btn.setAttribute('aria-pressed', btn.getAttribute('data-page-accent') === activeAccent ? 'true' : 'false');
    });

    updateStudioStatusText();
    if (persist) setSaved(ACCENT_KEY, activeAccent);
  }

  function applyLang(lang, persist, withFade) {
    var nextLang = lang === 'en' ? 'en' : 'id';

    function commitLang() {
      activeLang = nextLang;
      document.documentElement.setAttribute('data-active-lang', activeLang);
      document.documentElement.setAttribute('lang', activeLang);

      var titleAttr = document.body.getAttribute(activeLang === 'en' ? 'data-title-en' : 'data-title-id');
      if (titleAttr) document.title = titleAttr;

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

      updateLiveDatesAndGreeting();
      renderHeroTasks();
      renderBentoSubtasks();
      syncHeroTimerButtonLabel();
      syncBentoTimerButtonLabel();

      if (persist) setSaved(LANG_KEY, activeLang);
    }

    if (withFade) {
      document.documentElement.classList.add('is-lang-fading');
      window.setTimeout(function () {
        commitLang();
        document.documentElement.classList.remove('is-lang-fading');
      }, 130);
    } else {
      commitLang();
    }
  }

  /* =========================
     Dynamic Date Strip & Eyebrow in Hero Timeline Card
     ========================= */
  var selectedDateOffset = 0;

  function renderHeroDateStrip() {
    var stripEl = document.getElementById('hero-date-strip');
    if (!stripEl) return;

    var base = new Date();
    var locale = activeLang === 'en' ? 'en-US' : 'id-ID';
    stripEl.innerHTML = '';

    for (var offset = -2; offset <= 2; offset++) {
      var d = new Date(base);
      d.setDate(base.getDate() + offset);
      var dow = String(d.getDate());
      try {
        dow = new Intl.DateTimeFormat(locale, { weekday: 'short' }).format(d).slice(0, 3);
      } catch (_) {}

      var chip = document.createElement('button');
      chip.type = 'button';
      chip.className = 'htc-date-chip' + (offset === selectedDateOffset ? ' is-today' : '');
      chip.setAttribute('data-date-offset', String(offset));

      var sDow = document.createElement('span');
      sDow.className = 'htc-chip-dow';
      sDow.textContent = dow;

      var sNum = document.createElement('span');
      sNum.className = 'htc-chip-num tabular';
      sNum.textContent = String(d.getDate());

      chip.appendChild(sDow);
      chip.appendChild(sNum);
      stripEl.appendChild(chip);
    }
  }

  function updateLiveDatesAndGreeting() {
    var now = new Date();
    var dateEl = document.getElementById('hero-mock-date');

    if (dateEl && typeof Intl !== 'undefined' && Intl.DateTimeFormat) {
      try {
        dateEl.textContent = new Intl.DateTimeFormat(activeLang === 'en' ? 'en-US' : 'id-ID', {
          weekday: 'short',
          day: 'numeric',
          month: 'short'
        }).format(now).toUpperCase();
      } catch (_) {}
    }

    renderHeroDateStrip();
    syncHeroSubtaskBadge();
  }

  /* =========================
     Mouse-Move Radial Spotlight + Scroll Depth Parallax
     ========================= */
  function initHeroParallaxAndSpotlight() {
    var stage = document.getElementById('hero-spotlight-stage');
    var archGrid = document.getElementById('hero-arch-grid');
    var progressBar = document.getElementById('scroll-progress');
    var floatCards = document.querySelectorAll('[data-parallax-y]');
    var reducedMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    var mouseOffsetX = 0;
    var mouseOffsetY = 0;
    var scrollYVal = window.scrollY || 0;
    var rafPending = false;

    function applyTransforms() {
      var docHeight = document.documentElement.scrollHeight - window.innerHeight;
      if (progressBar) {
        var ratio = docHeight > 0 ? Math.min(1, Math.max(0, scrollYVal / docHeight)) : 0;
        progressBar.style.transform = 'scaleX(' + ratio.toFixed(4) + ')';
      }

      if (!reducedMotion) {
        if (archGrid) {
          var gridShiftY = Math.min(scrollYVal * 0.1, 28);
          archGrid.style.transform =
            'translate3d(' + (mouseOffsetX * -6).toFixed(1) + 'px, ' + (gridShiftY + mouseOffsetY * -6).toFixed(1) + 'px, 0)';
        }

        if (window.innerWidth > 1080) {
          var cappedScroll = Math.min(scrollYVal, 520) / 520;
          floatCards.forEach(function (el) {
            var py = parseFloat(el.getAttribute('data-parallax-y') || '0');
            var pm = parseFloat(el.getAttribute('data-parallax-mouse') || '0');
            var tx = mouseOffsetX * pm;
            var ty = cappedScroll * py + mouseOffsetY * pm;
            el.style.transform = 'translate3d(' + tx.toFixed(1) + 'px, ' + ty.toFixed(1) + 'px, 0)';
          });
        }
      }

      rafPending = false;
    }

    function requestTick() {
      if (!rafPending) {
        rafPending = true;
        window.requestAnimationFrame(applyTransforms);
      }
    }

    if (stage && !reducedMotion) {
      stage.addEventListener('pointermove', function (e) {
        var rect = stage.getBoundingClientRect();
        var relX = ((e.clientX - rect.left) / rect.width) * 100;
        var relY = ((e.clientY - rect.top) / rect.height) * 100;
        stage.style.setProperty('--spot-x', relX.toFixed(1) + '%');
        stage.style.setProperty('--spot-y', relY.toFixed(1) + '%');

        mouseOffsetX = (e.clientX - rect.left) / rect.width - 0.5;
        mouseOffsetY = (e.clientY - rect.top) / rect.height - 0.5;
        requestTick();
      });
    }

    window.addEventListener(
      'scroll',
      function () {
        scrollYVal = window.scrollY || document.documentElement.scrollTop || 0;
        requestTick();
      },
      { passive: true }
    );

    applyTransforms();
  }

  function syncHeroSubtaskBadge() {
    var row = document.getElementById('hero-cancellable-sub');
    var badge = document.getElementById('hero-sub-badge');
    var icon = document.getElementById('hero-cancellable-icon');
    var btn = document.getElementById('hero-sub-cancel-btn');
    if (!row || !badge || !icon || !btn) return;

    var isCancelled = row.getAttribute('data-cancelled') === 'true';
    if (isCancelled) {
      badge.textContent = '1/1 · 100%';
      icon.textContent = '✕';
      btn.textContent = '↺';
    } else {
      badge.textContent = '1/2 · 50%';
      icon.textContent = '○';
      btn.textContent = '✕';
    }
  }

  /* =========================
     Hero Interactive Tasks + Synced Progress Rings (Hero & Bento 3)
     ========================= */
  function renderHeroTasks() {
    var listEl = document.getElementById('hero-task-list');
    if (!listEl) return;

    listEl.innerHTML = '';
    demoState.heroTasks.forEach(function (task) {
      var li = document.createElement('li');
      var btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'hero-task-item-btn';
      btn.setAttribute('role', 'checkbox');
      btn.setAttribute('aria-checked', task.done ? 'true' : 'false');
      btn.setAttribute('data-hero-task-id', task.id);

      var box = document.createElement('span');
      box.className = 'hero-check-box';
      box.textContent = task.done ? '✓' : '';

      var label = document.createElement('span');
      label.className = 'hero-task-label';
      label.textContent = task.customText || (activeLang === 'en' ? task.enText : task.idText);

      var time = document.createElement('span');
      time.className = 'hero-task-time tabular';
      time.textContent = task.time || '12:00';

      btn.appendChild(box);
      btn.appendChild(label);
      btn.appendChild(time);
      li.appendChild(btn);
      listEl.appendChild(li);
    });

    updateSyncedProgressRings();
  }

  function updateSyncedProgressRings() {
    var total = demoState.heroTasks.length;
    var done = demoState.heroTasks.filter(function (t) { return t.done; }).length;
    var pct = total === 0 ? 0 : Math.round((done / total) * 100);

    var heroCounter = document.getElementById('hero-task-counter');
    var heroTimelineBar = document.getElementById('hero-timeline-bar');
    var heroPct = document.getElementById('hero-ring-pct');
    var heroDoneLabel = document.getElementById('hero-ring-done-label');
    var heroCircle = document.getElementById('hero-ring-circle');

    if (heroCounter) heroCounter.textContent = done + '/' + total;
    if (heroTimelineBar) heroTimelineBar.style.width = pct + '%';
    if (heroPct) heroPct.textContent = pct + '%';
    if (heroDoneLabel) {
      heroDoneLabel.textContent = activeLang === 'en' ? (done + ' completed') : (done + ' selesai');
    }
    if (heroCircle) {
      var hOffset = HERO_RING_CIRC - (HERO_RING_CIRC * pct) / 100;
      heroCircle.style.strokeDashoffset = hOffset.toFixed(2);
    }

    var bentoCircle = document.getElementById('bento-live-ring');
    var bentoPct = document.getElementById('bento-ring-pct');
    var bentoFrac = document.getElementById('bento-ring-fraction');
    if (bentoPct) bentoPct.textContent = pct + '%';
    if (bentoFrac) bentoFrac.textContent = done + ' / ' + total;
    if (bentoCircle) {
      var bOffset = BENTO_RING_CIRC - (BENTO_RING_CIRC * pct) / 100;
      bentoCircle.style.strokeDashoffset = bOffset.toFixed(2);
    }
  }

  /* =========================
     Bento 1: Sub-tasks Cancel (✕) & Sliding Undo Snackbar
     ========================= */
  var bentoUndoTimer = null;
  var lastCancelledSubId = null;

  function renderBentoSubtasks() {
    var container = document.getElementById('bento-subtask-list');
    var badge = document.getElementById('bento-sub-progress');
    if (!container || !badge) return;

    container.innerHTML = '';
    var activeSubs = demoState.bentoSubtasks.filter(function (s) { return !s.cancelled; });
    var doneActive = activeSubs.filter(function (s) { return s.done; });
    var pct = activeSubs.length === 0 ? 0 : Math.round((doneActive.length / activeSubs.length) * 100);

    badge.textContent =
      activeLang === 'en'
        ? (doneActive.length + '/' + activeSubs.length + ' active (' + pct + '%)')
        : (doneActive.length + '/' + activeSubs.length + ' aktif (' + pct + '%)');

    demoState.bentoSubtasks.forEach(function (sub) {
      var row = document.createElement('div');
      row.className = 'b-sub-row' + (sub.done && !sub.cancelled ? ' is-done' : '') + (sub.cancelled ? ' is-cancelled' : '');

      var checkBtn = document.createElement('button');
      checkBtn.type = 'button';
      checkBtn.className = 'b-sub-check';
      checkBtn.setAttribute('data-bento-sub-toggle', sub.id);
      checkBtn.setAttribute('aria-label', 'Toggle sub-task');

      var box = document.createElement('span');
      box.className = 'b-sub-box';
      box.textContent = sub.cancelled ? '✕' : (sub.done ? '✓' : '');
      checkBtn.appendChild(box);

      var txt = document.createElement('span');
      txt.className = 'b-sub-txt';
      txt.textContent = activeLang === 'en' ? sub.enText : sub.idText;

      var cancelBtn = document.createElement('button');
      cancelBtn.type = 'button';
      cancelBtn.className = 'b-sub-cancel-btn spring-btn';
      cancelBtn.setAttribute('data-bento-sub-cancel', sub.id);
      cancelBtn.textContent = sub.cancelled ? '↺' : '✕';
      cancelBtn.title = sub.cancelled
        ? (activeLang === 'en' ? 'Restore sub-task' : 'Pulihkan sub-tugas')
        : (activeLang === 'en' ? 'Cancel sub-task' : 'Batalkan sub-tugas');

      row.appendChild(checkBtn);
      row.appendChild(txt);
      row.appendChild(cancelBtn);
      container.appendChild(row);
    });
  }

  function triggerBentoSnackbar(subId) {
    var snackbar = document.getElementById('bento-snackbar');
    if (!snackbar) return;
    lastCancelledSubId = subId;
    snackbar.removeAttribute('hidden');
    if (bentoUndoTimer) window.clearTimeout(bentoUndoTimer);
    bentoUndoTimer = window.setTimeout(function () {
      snackbar.setAttribute('hidden', '');
      lastCancelledSubId = null;
    }, 5000);
  }

  /* =========================
     Interactive Focus Timers (Hero & Bento 2)
     ========================= */
  var heroTimer = { seconds: 25 * 60, running: false, id: null };
  var bentoTimer = { mode: 'pomodoro', seconds: 25 * 60, running: false, id: null };

  function fmtMMSS(sec) {
    var m = Math.floor(sec / 60);
    var s = sec % 60;
    return String(m).padStart(2, '0') + ':' + String(s).padStart(2, '0');
  }

  function syncHeroTimerButtonLabel() {
    var btn = document.getElementById('hero-timer-toggle');
    if (!btn) return;
    var dict = COPY[activeLang] || COPY.id;
    btn.textContent = heroTimer.running ? dict.timerPause : dict.timerStart;
  }

  function syncBentoTimerButtonLabel() {
    var btn = document.getElementById('bento-clock-toggle');
    if (!btn) return;
    var dict = COPY[activeLang] || COPY.id;
    btn.textContent = bentoTimer.running ? dict.timerPause : dict.timerStart;
  }

  function initInteractiveWidgets() {
    // Hero Date Strip selection
    var dateStrip = document.getElementById('hero-date-strip');
    if (dateStrip) {
      dateStrip.addEventListener('click', function (e) {
        var chip = e.target.closest('[data-date-offset]');
        if (!chip) return;
        selectedDateOffset = parseInt(chip.getAttribute('data-date-offset') || '0', 10);
        renderHeroDateStrip();
      });
    }

    // Hero live task list toggle
    var heroList = document.getElementById('hero-task-list');
    if (heroList) {
      heroList.addEventListener('click', function (e) {
        var btn = e.target.closest('[data-hero-task-id]');
        if (!btn) return;
        var id = btn.getAttribute('data-hero-task-id');
        var item = demoState.heroTasks.find(function (t) { return t.id === id; });
        if (item) {
          item.done = !item.done;
          saveDemoState();
          renderHeroTasks();
        }
      });
    }

    // Hero embedded Sub-task Cancel (✕) & Undo
    var heroSubCancelBtn = document.getElementById('hero-sub-cancel-btn');
    var heroSubRow = document.getElementById('hero-cancellable-sub');
    var heroSubToast = document.getElementById('hero-sub-toast');
    var heroSubUndoBtn = document.getElementById('hero-sub-undo-btn');
    var heroSubTimer = null;

    if (heroSubCancelBtn && heroSubRow && heroSubToast) {
      heroSubCancelBtn.addEventListener('click', function () {
        var cancelled = heroSubRow.getAttribute('data-cancelled') === 'true';
        if (cancelled) {
          heroSubRow.setAttribute('data-cancelled', 'false');
          heroSubToast.setAttribute('hidden', '');
          if (heroSubTimer) window.clearTimeout(heroSubTimer);
        } else {
          heroSubRow.setAttribute('data-cancelled', 'true');
          heroSubToast.removeAttribute('hidden');
          if (heroSubTimer) window.clearTimeout(heroSubTimer);
          heroSubTimer = window.setTimeout(function () {
            heroSubToast.setAttribute('hidden', '');
          }, 5000);
        }
        syncHeroSubtaskBadge();
      });
    }

    if (heroSubUndoBtn && heroSubRow && heroSubToast) {
      heroSubUndoBtn.addEventListener('click', function () {
        heroSubRow.setAttribute('data-cancelled', 'false');
        heroSubToast.setAttribute('hidden', '');
        if (heroSubTimer) window.clearTimeout(heroSubTimer);
        syncHeroSubtaskBadge();
      });
    }

    // Hero Floating Focus Timer Pill
    var heroDigits = document.getElementById('hero-timer-digits');
    var heroToggle = document.getElementById('hero-timer-toggle');
    var heroDot = document.getElementById('hero-timer-dot');
    if (heroDigits && heroToggle) {
      heroToggle.addEventListener('click', function () {
        if (heroTimer.running) {
          window.clearInterval(heroTimer.id);
          heroTimer.running = false;
          if (heroDot) heroDot.classList.remove('is-running');
        } else {
          heroTimer.running = true;
          if (heroDot) heroDot.classList.add('is-running');
          heroTimer.id = window.setInterval(function () {
            if (heroTimer.seconds > 0) {
              heroTimer.seconds -= 1;
              heroDigits.textContent = fmtMMSS(heroTimer.seconds);
            } else {
              window.clearInterval(heroTimer.id);
              heroTimer.running = false;
              heroTimer.seconds = 25 * 60;
              heroDigits.textContent = '25:00';
              if (heroDot) heroDot.classList.remove('is-running');
              syncHeroTimerButtonLabel();
            }
          }, 1000);
        }
        syncHeroTimerButtonLabel();
      });
    }

    // Bento 1: Subtask toggle, cancel & undo
    var bentoSubList = document.getElementById('bento-subtask-list');
    var bentoUndoBtn = document.getElementById('bento-undo-btn');
    var bentoSnackbar = document.getElementById('bento-snackbar');
    if (bentoSubList) {
      bentoSubList.addEventListener('click', function (e) {
        var toggleBtn = e.target.closest('[data-bento-sub-toggle]');
        if (toggleBtn) {
          var tid = toggleBtn.getAttribute('data-bento-sub-toggle');
          var tSub = demoState.bentoSubtasks.find(function (s) { return s.id === tid; });
          if (tSub && !tSub.cancelled) {
            tSub.done = !tSub.done;
            saveDemoState();
            renderBentoSubtasks();
          }
          return;
        }

        var cancelBtn = e.target.closest('[data-bento-sub-cancel]');
        if (cancelBtn) {
          var cid = cancelBtn.getAttribute('data-bento-sub-cancel');
          var cSub = demoState.bentoSubtasks.find(function (s) { return s.id === cid; });
          if (!cSub) return;
          if (cSub.cancelled) {
            cSub.cancelled = false;
            if (bentoSnackbar) bentoSnackbar.setAttribute('hidden', '');
          } else {
            cSub.cancelled = true;
            cSub.done = false;
            triggerBentoSnackbar(cSub.id);
          }
          saveDemoState();
          renderBentoSubtasks();
        }
      });
    }

    if (bentoUndoBtn && bentoSnackbar) {
      bentoUndoBtn.addEventListener('click', function () {
        if (lastCancelledSubId) {
          var sub = demoState.bentoSubtasks.find(function (s) { return s.id === lastCancelledSubId; });
          if (sub) {
            sub.cancelled = false;
            saveDemoState();
            renderBentoSubtasks();
          }
        }
        bentoSnackbar.setAttribute('hidden', '');
        lastCancelledSubId = null;
      });
    }

    // Bento 2: Multi-mode Focus Timer
    var bentoModes = document.getElementById('bento-timer-modes');
    var bentoReadout = document.getElementById('bento-clock-readout');
    var bentoToggle = document.getElementById('bento-clock-toggle');
    var bentoReset = document.getElementById('bento-clock-reset');

    function resetBentoClock(mode) {
      if (bentoTimer.id) window.clearInterval(bentoTimer.id);
      bentoTimer.running = false;
      bentoTimer.mode = mode;
      bentoTimer.seconds = mode === 'pomodoro' ? 25 * 60 : (mode === 'break' ? 5 * 60 : 0);
      if (bentoReadout) bentoReadout.textContent = fmtMMSS(bentoTimer.seconds);
      syncBentoTimerButtonLabel();
    }

    if (bentoModes && bentoReadout && bentoToggle && bentoReset) {
      bentoModes.addEventListener('click', function (e) {
        var tab = e.target.closest('[data-bento-mode]');
        if (!tab) return;
        bentoModes.querySelectorAll('[data-bento-mode]').forEach(function (b) {
          b.classList.toggle('is-active', b === tab);
        });
        resetBentoClock(tab.getAttribute('data-bento-mode'));
      });

      bentoToggle.addEventListener('click', function () {
        if (bentoTimer.running) {
          window.clearInterval(bentoTimer.id);
          bentoTimer.running = false;
        } else {
          bentoTimer.running = true;
          bentoTimer.id = window.setInterval(function () {
            if (bentoTimer.mode === 'stopwatch') {
              bentoTimer.seconds += 1;
              bentoReadout.textContent = fmtMMSS(bentoTimer.seconds);
            } else if (bentoTimer.seconds > 0) {
              bentoTimer.seconds -= 1;
              bentoReadout.textContent = fmtMMSS(bentoTimer.seconds);
            } else {
              window.clearInterval(bentoTimer.id);
              bentoTimer.running = false;
              syncBentoTimerButtonLabel();
            }
          }, 1000);
        }
        syncBentoTimerButtonLabel();
      });

      bentoReset.addEventListener('click', function () {
        resetBentoClock(bentoTimer.mode);
      });
    }

    // Bento 3: Step task completion trigger
    var stepTaskBtn = document.getElementById('bento-step-task-btn');
    if (stepTaskBtn) {
      stepTaskBtn.addEventListener('click', function () {
        var nextUnchecked = demoState.heroTasks.find(function (t) { return !t.done; });
        if (nextUnchecked) {
          nextUnchecked.done = true;
        } else {
          demoState.heroTasks.forEach(function (t, idx) {
            t.done = idx === 0;
          });
        }
        saveDemoState();
        renderHeroTasks();
      });
    }

    // Bento 4: Live Page-Wide Theme Studio
    var studio = document.getElementById('bento-theme-studio');
    if (studio) {
      studio.addEventListener('click', function (e) {
        var themeBtn = e.target.closest('[data-page-theme]');
        if (themeBtn) {
          applyTheme(themeBtn.getAttribute('data-page-theme'), true);
          return;
        }
        var accBtn = e.target.closest('[data-page-accent]');
        if (accBtn) {
          applyAccent(accBtn.getAttribute('data-page-accent'), true);
        }
      });
    }

    // Section 4: Android Home Screen Widget interactive preview
    var widgetStyleWrap = document.getElementById('android-widget-styles');
    var homeWidget = document.getElementById('zettask-home-widget');
    var zhwList = document.getElementById('zhw-task-list');
    var zhwCount = document.getElementById('zhw-count');

    if (widgetStyleWrap && homeWidget) {
      widgetStyleWrap.addEventListener('click', function (e) {
        var btn = e.target.closest('[data-widget-style]');
        if (!btn) return;
        homeWidget.setAttribute('data-w-style', btn.getAttribute('data-widget-style'));
        widgetStyleWrap.querySelectorAll('[data-widget-style]').forEach(function (b) {
          b.classList.toggle('is-active', b === btn);
        });
      });
    }

    if (zhwList && zhwCount) {
      zhwList.addEventListener('click', function (e) {
        var item = e.target.closest('[data-zhw-item]');
        if (!item) return;
        item.classList.toggle('is-done');
        var box = item.querySelector('.zhw-box');
        if (box) box.textContent = item.classList.contains('is-done') ? '✓' : '';
        var all = zhwList.querySelectorAll('[data-zhw-item]').length;
        var done = zhwList.querySelectorAll('[data-zhw-item].is-done').length;
        zhwCount.textContent = done + '/' + all;
      });
    }
  }

  /* =========================
     IntersectionObserver Scroll Reveal
     ========================= */
  function initScrollReveal() {
    var targets = document.querySelectorAll('[data-reveal]');
    if (!targets.length) return;

    var reducedMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    if (reducedMotion || !('IntersectionObserver' in window)) return;

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
      { threshold: 0.1, rootMargin: '0px 0px -32px 0px' }
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
      var targetLang = btn.getAttribute('data-set-lang');
      if (targetLang !== activeLang) {
        applyLang(targetLang, true, true);
      }
    });
  });

  document.querySelectorAll('[data-theme-toggle]').forEach(function (btn) {
    btn.addEventListener('click', function () {
      var idx = THEME_ORDER.indexOf(activeTheme);
      var next = THEME_ORDER[(idx + 1) % THEME_ORDER.length];
      applyTheme(next, true);
    });
  });

  activeTheme = detectInitialTheme();
  activeAccent = detectInitialAccent();
  activeLang = detectInitialLang();

  applyTheme(activeTheme, false);
  applyAccent(activeAccent, false);
  applyLang(activeLang, false, false);

  initHeroParallaxAndSpotlight();
  initInteractiveWidgets();
  initScrollReveal();
})();
