(function () {
  'use strict';

  var LANG_KEY = 'zettask_docs_lang';
  var THEME_KEY = 'zettask_docs_theme';
  var THEME_ORDER = ['light', 'dark', 'amoled'];
  var THEME_LABELS = {
    light: 'Light',
    dark: 'Dark',
    amoled: 'AMOLED'
  };

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
    return 'id';
  }

  function detectInitialTheme() {
    var saved = getSaved(THEME_KEY);
    if (saved === 'light' || saved === 'dark' || saved === 'amoled') return saved;
    if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      return 'dark';
    }
    return 'light';
  }

  function applyTheme(theme, persist) {
    activeTheme = THEME_ORDER.indexOf(theme) !== -1 ? theme : 'light';
    document.documentElement.setAttribute('data-theme', activeTheme);

    var metaTheme = document.querySelector('meta[name="theme-color"]');
    if (metaTheme) {
      var colorMap = { light: '#F5F5F4', dark: '#0D0F12', amoled: '#000000' };
      metaTheme.setAttribute('content', colorMap[activeTheme] || '#F5F5F4');
    }

    document.querySelectorAll('[data-theme-toggle]').forEach(function (btn) {
      btn.setAttribute('aria-pressed', activeTheme !== 'light' ? 'true' : 'false');
      var labelEl = btn.querySelector('.theme-label');
      if (labelEl) {
        labelEl.textContent = THEME_LABELS[activeTheme];
      }
      btn.setAttribute('aria-label', 'Tema aktif: ' + THEME_LABELS[activeTheme] + '. Klik untuk mengganti tema.');
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

    if (persist) {
      setSaved(LANG_KEY, activeLang);
    }
  }

  /* =========================
     Scroll Progress & Subtle Parallax Drift
     ========================= */
  function initScrollMotion() {
    var progressBar = document.getElementById('scroll-progress');
    var driftCards = document.querySelectorAll('[data-drift]');
    var reducedMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var ticking = false;

    function updateOnScroll() {
      var scrollTop = window.scrollY || document.documentElement.scrollTop || 0;
      var docHeight = document.documentElement.scrollHeight - window.innerHeight;

      if (progressBar) {
        var ratio = docHeight > 0 ? Math.min(1, Math.max(0, scrollTop / docHeight)) : 0;
        progressBar.style.transform = 'scaleX(' + ratio.toFixed(4) + ')';
      }

      if (!reducedMotion && window.innerWidth > 1120 && driftCards.length) {
        var capped = Math.min(scrollTop, 520);
        driftCards.forEach(function (card) {
          var factor = parseFloat(card.getAttribute('data-drift') || '0');
          var offset = (capped / 520) * factor;
          card.style.transform = 'translate3d(0, ' + offset.toFixed(1) + 'px, 0)';
        });
      }

      ticking = false;
    }

    window.addEventListener(
      'scroll',
      function () {
        if (!ticking) {
          window.requestAnimationFrame(updateOnScroll);
          ticking = true;
        }
      },
      { passive: true }
    );

    updateOnScroll();
  }

  /* =========================
     Scroll Reveal & Counter/Ring Trigger
     ========================= */
  function initScrollReveal() {
    var targets = document.querySelectorAll('[data-reveal]');
    if (!targets.length) return;

    var reducedMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    if (reducedMotion || !('IntersectionObserver' in window)) {
      return;
    }

    document.documentElement.classList.add('js-reveal-ready');

    var observer = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add('is-visible');
            animateInnerMetrics(entry.target);
            observer.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.12, rootMargin: '0px 0px -32px 0px' }
    );

    targets.forEach(function (el) {
      observer.observe(el);
    });
  }

  function animateInnerMetrics(container) {
    container.querySelectorAll('[data-ring-target]').forEach(function (circle) {
      var targetOffset = circle.getAttribute('data-ring-target');
      var dashArray = circle.getAttribute('stroke-dasharray') || '200';
      circle.style.strokeDashoffset = dashArray;
      window.requestAnimationFrame(function () {
        window.requestAnimationFrame(function () {
          circle.style.strokeDashoffset = targetOffset;
        });
      });
    });

    container.querySelectorAll('[data-count-target]').forEach(function (counterEl) {
      var target = parseInt(counterEl.getAttribute('data-count-target') || '0', 10);
      var start = performance.now();
      var duration = 700;
      function step(now) {
        var progress = Math.min(1, (now - start) / duration);
        var eased = 1 - Math.pow(1 - progress, 3);
        counterEl.textContent = Math.round(target * eased) + '%';
        if (progress < 1) {
          window.requestAnimationFrame(step);
        }
      }
      window.requestAnimationFrame(step);
    });
  }

  /* =========================
     Interactive Landing Previews
     ========================= */
  function initLandingDemos() {
    // Live Date in Dashboard Showcase
    var now = new Date();
    var dayNumEl = document.getElementById('showcase-day-num');
    var fullDateEl = document.getElementById('showcase-full-date');
    if (dayNumEl) {
      dayNumEl.textContent = String(now.getDate());
    }
    if (fullDateEl && typeof Intl !== 'undefined' && Intl.DateTimeFormat) {
      try {
        fullDateEl.textContent = new Intl.DateTimeFormat('id-ID', {
          weekday: 'long',
          day: 'numeric',
          month: 'long',
          year: 'numeric'
        }).format(now);
      } catch (_) {}
    }

    // Hero floating checkbox toggle
    var heroCheck = document.getElementById('hero-check-toggle');
    if (heroCheck) {
      heroCheck.addEventListener('click', function () {
        var pressed = heroCheck.getAttribute('aria-pressed') === 'true';
        heroCheck.setAttribute('aria-pressed', pressed ? 'false' : 'true');
      });
    }

    // Dashboard Preview Interactive Checkboxes
    var prevList = document.getElementById('prev-interactive-tasks');
    var prevCounter = document.getElementById('prev-todo-counter');
    if (prevList && prevCounter) {
      prevList.addEventListener('click', function (e) {
        var btn = e.target.closest('[data-prev-task]');
        if (!btn) return;
        btn.classList.toggle('is-done');
        var all = prevList.querySelectorAll('[data-prev-task]');
        var done = prevList.querySelectorAll('[data-prev-task].is-done');
        prevCounter.textContent = done.length + '/' + all.length + ' selesai';
      });
    }

    // Bento 1: Subtask Cancel & Undo Demo
    var cancelBtn = document.getElementById('bento-cancel-btn');
    var cancelRow = document.getElementById('bento-cancellable-row');
    var subBadge = document.getElementById('bento-sub-badge');
    var subToast = document.getElementById('bento-mini-toast');
    if (cancelBtn && cancelRow && subBadge && subToast) {
      cancelBtn.addEventListener('click', function () {
        var isCancelled = cancelRow.getAttribute('data-cancelled') === 'true';
        var box = cancelRow.querySelector('.ct-mini-check-box');
        if (isCancelled) {
          cancelRow.setAttribute('data-cancelled', 'false');
          cancelBtn.textContent = 'Batalkan ✕';
          if (box) {
            box.className = 'ct-mini-check-box is-empty';
            box.textContent = '';
          }
          subBadge.textContent = '1/3 aktif (33%)';
          subToast.textContent = 'Sub-tugas dipulihkan ke hitungan aktif';
          subToast.classList.add('is-hidden');
        } else {
          cancelRow.setAttribute('data-cancelled', 'true');
          cancelBtn.textContent = 'Urungkan';
          if (box) {
            box.className = 'ct-mini-check-box is-cancelled';
            box.textContent = '✕';
          }
          subBadge.textContent = '1/2 aktif (50%)';
          subToast.textContent = 'Sub-tugas dibatalkan · Dikecualikan dari progres';
          subToast.classList.remove('is-hidden');
        }
      });
    }

    // Bento 2: Mini Focus Timer Demo
    var timerDisplay = document.getElementById('bento-timer-display');
    var timerToggle = document.getElementById('bento-timer-toggle');
    var timerReset = document.getElementById('bento-timer-reset');
    if (timerDisplay && timerToggle && timerReset) {
      var remaining = 25 * 60;
      var timerId = null;

      function formatMMSS(sec) {
        var m = Math.floor(sec / 60);
        var s = sec % 60;
        return String(m).padStart(2, '0') + ':' + String(s).padStart(2, '0');
      }

      timerToggle.addEventListener('click', function () {
        if (timerId) {
          window.clearInterval(timerId);
          timerId = null;
          timerToggle.textContent = 'Lanjut';
        } else {
          timerToggle.textContent = 'Jeda';
          timerId = window.setInterval(function () {
            if (remaining > 0) {
              remaining -= 1;
              timerDisplay.textContent = formatMMSS(remaining);
            } else {
              window.clearInterval(timerId);
              timerId = null;
              timerToggle.textContent = 'Mulai Fokus';
            }
          }, 1000);
        }
      });

      timerReset.addEventListener('click', function () {
        if (timerId) {
          window.clearInterval(timerId);
          timerId = null;
        }
        remaining = 25 * 60;
        timerDisplay.textContent = '25:00';
        timerToggle.textContent = 'Mulai Fokus';
      });
    }

    // Bento 4: Interactive Theme & Accent Studio
    var studio = document.getElementById('bento-theme-studio');
    if (studio) {
      studio.addEventListener('click', function (e) {
        var modeBtn = e.target.closest('[data-studio-mode]');
        if (modeBtn) {
          var mode = modeBtn.getAttribute('data-studio-mode');
          studio.setAttribute('data-preview-mode', mode);
          studio.querySelectorAll('[data-studio-mode]').forEach(function (b) {
            b.classList.toggle('is-active', b === modeBtn);
          });
          applyTheme(mode, true);
          return;
        }

        var swatchBtn = e.target.closest('[data-studio-accent]');
        if (swatchBtn) {
          var acc = swatchBtn.getAttribute('data-studio-accent');
          studio.setAttribute('data-preview-accent', acc);
          studio.querySelectorAll('[data-studio-accent]').forEach(function (b) {
            b.classList.toggle('is-selected', b === swatchBtn);
          });
          setSaved('zettask_docs_accent', acc);
        }
      });
    }
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
      var idx = THEME_ORDER.indexOf(activeTheme);
      var next = THEME_ORDER[(idx + 1) % THEME_ORDER.length];
      applyTheme(next, true);
    });
  });

  activeTheme = detectInitialTheme();
  activeLang = detectInitialLang();
  applyTheme(activeTheme, false);
  applyLang(activeLang, false);
  initScrollMotion();
  initScrollReveal();
  initLandingDemos();
})();
