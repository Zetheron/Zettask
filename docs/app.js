(function () {
  'use strict';

  var STATE_KEY = 'zettask_web_state_v1';
  var THEME_KEY = 'zettask_docs_theme';
  var ACCENT_KEY = 'zettask_docs_accent';

  var VALID_THEMES = ['light', 'dark', 'amoled'];
  var VALID_ACCENTS = ['indigo', 'sage', 'terracotta', 'amber', 'monochrome'];
  var PRIORITY_ORDER = { high: 0, medium: 1, low: 2 };
  var PRIORITY_LABELS = {
    high: 'Tinggi',
    medium: 'Sedang',
    low: 'Rendah'
  };
  var DAY_LABELS = {
    today: 'Hari Ini',
    tomorrow: 'Besok',
    upcoming: 'Minggu Ini'
  };

  var RING_OUTER_CIRC = 301.59;
  var RING_INNER_CIRC = 207.35;

  function escapeHtml(value) {
    return String(value == null ? '' : value)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;');
  }

  function uid(prefix) {
    return prefix + '_' + Date.now().toString(36) + '_' + Math.random().toString(36).slice(2, 7);
  }

  function createStarterState() {
    return {
      userName: 'Rekan',
      focusMinutesToday: 25,
      projects: [
        { id: 'proj_ui', name: 'Produk & UI', color: '#3B5BDB' },
        { id: 'proj_android', name: 'Rilis Android', color: '#2F6B4F' },
        { id: 'proj_personal', name: 'Pribadi', color: '#D97706' }
      ],
      tasks: [
        {
          id: 'task_seed_1',
          title: 'Finalisasi antarmuka Zettask Web untuk GitHub Pages',
          done: false,
          priority: 'high',
          projectId: 'proj_ui',
          dayBucket: 'today',
          time: '09:30',
          expandedSubtasks: true,
          subtasks: [
            { id: 'sub_s1', title: 'Susun tata letak dashboard responsif', done: true, cancelled: false },
            { id: 'sub_s2', title: 'Uji fitur Cancel (✕) & Undo sub-tugas 5 detik', done: false, cancelled: false },
            { id: 'sub_s3', title: 'Tambahkan SDK analitik iklan (coba klik ✕)', done: false, cancelled: false }
          ]
        },
        {
          id: 'task_seed_2',
          title: 'Validasi kontras tema AMOLED Pure Black #000000',
          done: false,
          priority: 'high',
          projectId: 'proj_android',
          dayBucket: 'today',
          time: '13:30',
          expandedSubtasks: false,
          subtasks: [
            { id: 'sub_s4', title: 'Cek keterbacaan 5 warna aksen utama', done: true, cancelled: false },
            { id: 'sub_s5', title: 'Pastikan tautan Kebijakan Privasi Play Store utuh', done: true, cancelled: false }
          ]
        },
        {
          id: 'task_seed_3',
          title: 'Siapkan evaluasi mingguan dan baca buku 20 halaman',
          done: true,
          priority: 'medium',
          projectId: 'proj_personal',
          dayBucket: 'today',
          time: '19:00',
          expandedSubtasks: false,
          subtasks: []
        }
      ]
    };
  }

  function loadState() {
    try {
      var raw = localStorage.getItem(STATE_KEY);
      if (!raw) {
        var starter = createStarterState();
        saveState(starter);
        return starter;
      }
      var parsed = JSON.parse(raw);
      if (!parsed || !Array.isArray(parsed.tasks) || !Array.isArray(parsed.projects)) {
        var fallback = createStarterState();
        saveState(fallback);
        return fallback;
      }
      return parsed;
    } catch (_) {
      return createStarterState();
    }
  }

  function saveState(nextState) {
    try {
      localStorage.setItem(STATE_KEY, JSON.stringify(nextState));
    } catch (_) {}
  }

  var state = loadState();

  var ui = {
    activeView: 'today',
    statusFilter: 'all',
    projectFilter: null,
    searchQuery: '',
    editingTaskId: null,
    addingSubtaskForId: null,
    newProjectColor: '#3B5BDB',
    timerMode: 'pomodoro',
    timerSeconds: 25 * 60,
    timerRunning: false,
    timerIntervalId: null,
    undoPayload: null,
    undoTimeoutId: null
  };

  /* =========================
     DOM References
     ========================= */
  var els = {
    sidebar: document.getElementById('app-sidebar'),
    backdrop: document.getElementById('sidebar-backdrop'),
    btnOpenSidebar: document.getElementById('btn-open-sidebar'),
    btnCloseSidebar: document.getElementById('btn-close-sidebar'),
    btnSidebarNewTask: document.getElementById('btn-sidebar-new-task'),
    sidebarNav: document.getElementById('sidebar-nav'),
    badgeToday: document.getElementById('badge-today'),
    badgeAll: document.getElementById('badge-all'),
    badgeProjects: document.getElementById('badge-projects'),

    btnToggleProjForm: document.getElementById('btn-toggle-proj-form'),
    projForm: document.getElementById('sidebar-proj-form'),
    inputNewProj: document.getElementById('input-new-project'),
    projColorPicker: document.getElementById('proj-color-picker'),
    sidebarProjectList: document.getElementById('sidebar-project-list'),
    btnResetDemo: document.getElementById('btn-reset-demo'),

    searchInput: document.getElementById('search-input'),
    btnClearSearch: document.getElementById('btn-clear-search'),
    themeSwitcher: document.getElementById('theme-switcher'),
    accentSwitcher: document.getElementById('accent-switcher'),

    greetingPrefix: document.getElementById('greeting-prefix'),
    greetingUsername: document.getElementById('greeting-username'),
    btnEditUsername: document.getElementById('btn-edit-username'),
    greetingDate: document.getElementById('greeting-date'),
    filterBanner: document.getElementById('active-filter-banner'),
    filterLabel: document.getElementById('active-filter-label'),
    btnClearProjFilter: document.getElementById('btn-clear-project-filter'),

    viewTasksWorkspace: document.getElementById('view-tasks-workspace'),
    viewProjectsBoard: document.getElementById('view-projects-board'),
    viewStatsDetail: document.getElementById('view-stats-detail'),

    todoHeading: document.getElementById('todo-card-heading'),
    todoSummaryPill: document.getElementById('todo-summary-pill'),
    statusFilterTabs: document.getElementById('status-filter-tabs'),
    composerForm: document.getElementById('task-composer-form'),
    inputTaskTitle: document.getElementById('input-task-title'),
    selectTaskPrio: document.getElementById('select-task-priority'),
    selectTaskProj: document.getElementById('select-task-project'),
    selectTaskDay: document.getElementById('select-task-day'),
    inputTaskTime: document.getElementById('input-task-time'),
    taskListContainer: document.getElementById('task-list-container'),

    timerLiveDot: document.getElementById('timer-live-dot'),
    timerModeTabs: document.getElementById('timer-mode-tabs'),
    timerDisplay: document.getElementById('timer-display'),
    timerTaskSelect: document.getElementById('timer-task-select'),
    btnTimerToggle: document.getElementById('btn-timer-toggle'),
    timerToggleLabel: document.getElementById('timer-toggle-label'),
    btnTimerReset: document.getElementById('btn-timer-reset'),

    activityPctBadge: document.getElementById('activity-pct-badge'),
    svgRingTasks: document.getElementById('svg-ring-tasks'),
    svgRingSubtasks: document.getElementById('svg-ring-subtasks'),
    ringCenterRatio: document.getElementById('ring-center-ratio'),
    statTasksDone: document.getElementById('stat-tasks-done'),
    statTasksActive: document.getElementById('stat-tasks-active'),
    statSubsDone: document.getElementById('stat-subs-done'),
    statFocusMins: document.getElementById('stat-focus-mins'),

    highPrioCount: document.getElementById('high-prio-count'),
    remindersList: document.getElementById('reminders-list'),
    projectsBoardGrid: document.getElementById('projects-board-grid'),
    statsKpiGrid: document.getElementById('stats-kpi-grid'),
    statsByProject: document.getElementById('stats-by-project'),
    statsByPriority: document.getElementById('stats-by-priority'),

    snackbar: document.getElementById('app-snackbar'),
    snackbarMsg: document.getElementById('snackbar-message'),
    btnSnackbarUndo: document.getElementById('btn-snackbar-undo'),
    btnSnackbarClose: document.getElementById('btn-snackbar-close'),
    snackbarBar: document.getElementById('snackbar-progress-bar')
  };

  /* =========================
     Theme & Accent Management
     ========================= */
  function getStoredPref(key, fallback) {
    try {
      return localStorage.getItem(key) || fallback;
    } catch (_) {
      return fallback;
    }
  }

  function setStoredPref(key, val) {
    try {
      localStorage.setItem(key, val);
    } catch (_) {}
  }

  function applyTheme(theme, persist) {
    var clean = VALID_THEMES.indexOf(theme) !== -1 ? theme : 'light';
    document.documentElement.setAttribute('data-theme', clean);
    var meta = document.querySelector('meta[name="theme-color"]');
    if (meta) {
      var bgMap = { light: '#F5F5F4', dark: '#0E1014', amoled: '#000000' };
      meta.setAttribute('content', bgMap[clean]);
    }
    els.themeSwitcher.querySelectorAll('[data-set-theme]').forEach(function (btn) {
      btn.setAttribute('aria-pressed', btn.getAttribute('data-set-theme') === clean ? 'true' : 'false');
    });
    if (persist) setStoredPref(THEME_KEY, clean);
  }

  function applyAccent(accent, persist) {
    var clean = VALID_ACCENTS.indexOf(accent) !== -1 ? accent : 'indigo';
    document.documentElement.setAttribute('data-accent', clean);
    els.accentSwitcher.querySelectorAll('[data-set-accent]').forEach(function (btn) {
      btn.setAttribute('aria-pressed', btn.getAttribute('data-set-accent') === clean ? 'true' : 'false');
    });
    if (persist) setStoredPref(ACCENT_KEY, clean);
  }

  /* =========================
     Greeting & Date (Intl.DateTimeFormat)
     ========================= */
  function updateGreetingAndDate() {
    var now = new Date();
    var hour = now.getHours();
    var greet = 'Selamat malam,';
    if (hour >= 4 && hour < 11) {
      greet = 'Selamat pagi,';
    } else if (hour >= 11 && hour < 15) {
      greet = 'Selamat siang,';
    } else if (hour >= 15 && hour < 18) {
      greet = 'Selamat sore,';
    }
    els.greetingPrefix.textContent = greet;
    els.greetingUsername.textContent = state.userName || 'Rekan';

    if (typeof Intl !== 'undefined' && Intl.DateTimeFormat) {
      try {
        els.greetingDate.textContent = new Intl.DateTimeFormat('id-ID', {
          weekday: 'long',
          day: 'numeric',
          month: 'long',
          year: 'numeric'
        }).format(now);
      } catch (_) {}
    }
  }

  /* =========================
     Subtask Progress Math (Excluding Cancelled Subtasks)
     ========================= */
  function computeSubtaskStats(subtasks) {
    var list = Array.isArray(subtasks) ? subtasks : [];
    var active = list.filter(function (s) { return !s.cancelled; });
    var doneActive = active.filter(function (s) { return s.done; });
    var cancelledCount = list.length - active.length;
    var pct = active.length === 0 ? 0 : Math.round((doneActive.length / active.length) * 100);
    return {
      totalAll: list.length,
      activeCount: active.length,
      doneCount: doneActive.length,
      cancelledCount: cancelledCount,
      pct: pct
    };
  }

  function getProjectById(projectId) {
    for (var i = 0; i < state.projects.length; i++) {
      if (state.projects[i].id === projectId) return state.projects[i];
    }
    return state.projects[0] || { id: 'default', name: 'Umum', color: '#3B5BDB' };
  }

  /* =========================
     Filtering & Sorting
     ========================= */
  function getFilteredTasks() {
    var query = ui.searchQuery.trim().toLowerCase();

    return state.tasks
      .filter(function (task) {
        if (ui.activeView === 'today' && !ui.projectFilter && !query) {
          if (task.dayBucket && task.dayBucket !== 'today') return false;
        }
        if (ui.projectFilter && task.projectId !== ui.projectFilter) {
          return false;
        }
        if (ui.statusFilter === 'active' && task.done) return false;
        if (ui.statusFilter === 'done' && !task.done) return false;

        if (query) {
          var proj = getProjectById(task.projectId);
          var matchTitle = task.title.toLowerCase().indexOf(query) !== -1;
          var matchProj = proj.name.toLowerCase().indexOf(query) !== -1;
          var matchSub = (task.subtasks || []).some(function (s) {
            return s.title.toLowerCase().indexOf(query) !== -1;
          });
          if (!matchTitle && !matchProj && !matchSub) return false;
        }
        return true;
      })
      .slice()
      .sort(function (a, b) {
        if (a.done !== b.done) return a.done ? 1 : -1;
        var pa = PRIORITY_ORDER[a.priority] != null ? PRIORITY_ORDER[a.priority] : 1;
        var pb = PRIORITY_ORDER[b.priority] != null ? PRIORITY_ORDER[b.priority] : 1;
        if (pa !== pb) return pa - pb;
        return String(a.time || '23:59').localeCompare(String(b.time || '23:59'));
      });
  }

  /* =========================
     5-Second Undo Snackbar
     ========================= */
  function showUndoSnackbar(message, payload) {
    if (ui.undoTimeoutId) {
      window.clearTimeout(ui.undoTimeoutId);
      ui.undoTimeoutId = null;
    }
    ui.undoPayload = payload;
    els.snackbarMsg.textContent = message;
    els.snackbar.removeAttribute('hidden');

    els.snackbarBar.classList.remove('is-counting');
    void els.snackbarBar.offsetWidth;
    els.snackbarBar.classList.add('is-counting');

    ui.undoTimeoutId = window.setTimeout(function () {
      hideSnackbar();
    }, 5000);
  }

  function hideSnackbar() {
    if (ui.undoTimeoutId) {
      window.clearTimeout(ui.undoTimeoutId);
      ui.undoTimeoutId = null;
    }
    ui.undoPayload = null;
    els.snackbarBar.classList.remove('is-counting');
    els.snackbar.setAttribute('hidden', '');
  }

  function handleUndoAction() {
    if (!ui.undoPayload) return;
    var p = ui.undoPayload;

    if (p.type === 'cancel_subtask') {
      var parent = state.tasks.find(function (t) { return t.id === p.taskId; });
      if (parent && Array.isArray(parent.subtasks)) {
        var sub = parent.subtasks.find(function (s) { return s.id === p.subtaskId; });
        if (sub) {
          sub.cancelled = false;
          sub.done = Boolean(p.previousDone);
        }
      }
    } else if (p.type === 'delete_task' && p.taskCopy) {
      state.tasks.splice(p.index, 0, p.taskCopy);
    }

    saveState(state);
    hideSnackbar();
    renderAll();
  }

  /* =========================
     Rendering Functions
     ========================= */
  function renderSidebarAndSelects() {
    var todayActive = state.tasks.filter(function (t) {
      return !t.done && (!t.dayBucket || t.dayBucket === 'today');
    }).length;
    var allActive = state.tasks.filter(function (t) { return !t.done; }).length;

    els.badgeToday.textContent = String(todayActive);
    els.badgeAll.textContent = String(allActive);
    els.badgeProjects.textContent = String(state.projects.length);

    els.sidebarNav.querySelectorAll('[data-nav-view]').forEach(function (btn) {
      btn.classList.toggle('is-active', btn.getAttribute('data-nav-view') === ui.activeView && !ui.projectFilter);
    });

    // Sidebar projects list
    var projHtml = state.projects
      .map(function (proj) {
        var count = state.tasks.filter(function (t) {
          return !t.done && t.projectId === proj.id;
        }).length;
        var isSel = ui.projectFilter === proj.id;
        return (
          '<li>' +
          '<button type="button" class="proj-nav-btn' + (isSel ? ' is-selected' : '') + '" data-filter-project="' + escapeHtml(proj.id) + '">' +
          '<span class="proj-nav-left">' +
          '<span class="proj-dot" style="background-color:' + escapeHtml(proj.color) + '"></span>' +
          '<span class="proj-name-text">' + escapeHtml(proj.name) + '</span>' +
          '</span>' +
          '<span class="nav-badge tabular">' + count + '</span>' +
          '</button>' +
          '</li>'
        );
      })
      .join('');
    els.sidebarProjectList.innerHTML = projHtml;

    // Composer project dropdown
    var currentProjVal = els.selectTaskProj.value || (ui.projectFilter || (state.projects[0] && state.projects[0].id));
    els.selectTaskProj.innerHTML = state.projects
      .map(function (p) {
        return '<option value="' + escapeHtml(p.id) + '">' + escapeHtml(p.name) + '</option>';
      })
      .join('');
    if (currentProjVal && state.projects.some(function (p) { return p.id === currentProjVal; })) {
      els.selectTaskProj.value = currentProjVal;
    }

    // Active project filter banner
    if (ui.projectFilter) {
      var activeProj = getProjectById(ui.projectFilter);
      els.filterLabel.textContent = 'Proyek: ' + activeProj.name;
      els.filterBanner.removeAttribute('hidden');
    } else {
      els.filterBanner.setAttribute('hidden', '');
    }

    // Timer focus task select
    var prevTimerTask = els.timerTaskSelect.value;
    var activeTasks = state.tasks.filter(function (t) { return !t.done; });
    var timerOpts = '<option value="">Fokus umum (tanpa tugas spesifik)</option>' +
      activeTasks
        .map(function (t) {
          return '<option value="' + escapeHtml(t.id) + '">' + escapeHtml(t.title) + '</option>';
        })
        .join('');
    els.timerTaskSelect.innerHTML = timerOpts;
    if (prevTimerTask && activeTasks.some(function (t) { return t.id === prevTimerTask; })) {
      els.timerTaskSelect.value = prevTimerTask;
    }
  }

  function renderTaskList() {
    var tasks = getFilteredTasks();
    var activeInList = tasks.filter(function (t) { return !t.done; }).length;

    if (ui.projectFilter) {
      els.todoHeading.textContent = getProjectById(ui.projectFilter).name;
    } else if (ui.activeView === 'all') {
      els.todoHeading.textContent = 'Semua Tugas';
    } else {
      els.todoHeading.textContent = 'Tugas Hari Ini';
    }
    els.todoSummaryPill.textContent = activeInList + ' aktif · ' + tasks.length + ' total';

    els.statusFilterTabs.querySelectorAll('[data-status-filter]').forEach(function (tab) {
      tab.classList.toggle('is-active', tab.getAttribute('data-status-filter') === ui.statusFilter);
    });

    if (!tasks.length) {
      els.taskListContainer.innerHTML =
        '<div class="empty-state">' +
        '<p class="empty-state-title">Belum ada tugas yang cocok.</p>' +
        '<p class="empty-state-sub">Ketik judul di kolom atas untuk menambahkan tugas baru.</p>' +
        '</div>';
      return;
    }

    var html = tasks
      .map(function (task) {
        var proj = getProjectById(task.projectId);
        var subStats = computeSubtaskStats(task.subtasks);
        var isEditing = ui.editingTaskId === task.id;
        var isAddingSub = ui.addingSubtaskForId === task.id;
        var prioKey = PRIORITY_LABELS[task.priority] ? task.priority : 'medium';

        var titleControl = isEditing
          ? '<input type="text" class="inline-edit-input" data-edit-input="' + escapeHtml(task.id) + '" value="' + escapeHtml(task.title) + '" maxlength="140" />'
          : '<span class="task-title-text" data-action="start-edit" data-task-id="' + escapeHtml(task.id) + '" title="Klik dua kali atau tekan tombol edit untuk mengubah">' + escapeHtml(task.title) + '</span>';

        var subPillHtml = '';
        if (subStats.totalAll > 0) {
          var subLabel = subStats.activeCount > 0
            ? (subStats.doneCount + '/' + subStats.activeCount + ' sub-tugas (' + subStats.pct + '%)')
            : 'Semua sub-tugas dibatalkan';
          subPillHtml = '<span class="meta-pill sub-progress-pill tabular">' + escapeHtml(subLabel) + '</span>';
        }

        var subtasksRowsHtml = (task.subtasks || [])
          .map(function (sub) {
            var rowCls = 'subtask-row' + (sub.done && !sub.cancelled ? ' is-done' : '') + (sub.cancelled ? ' is-cancelled' : '');
            var boxIcon = sub.cancelled ? '✕' : (sub.done ? '✓' : '');
            var rightActions = sub.cancelled
              ? '<span class="subtask-cancelled-tag">Dibatalkan</span>' +
                '<button type="button" class="subtask-btn" data-action="restore-subtask" data-task-id="' + escapeHtml(task.id) + '" data-sub-id="' + escapeHtml(sub.id) + '" title="Pulihkan sub-tugas">Pulihkan</button>' +
                '<button type="button" class="subtask-btn is-cancel" data-action="delete-subtask" data-task-id="' + escapeHtml(task.id) + '" data-sub-id="' + escapeHtml(sub.id) + '" aria-label="Hapus sub-tugas">🗑</button>'
              : '<button type="button" class="subtask-btn is-cancel" data-action="cancel-subtask" data-task-id="' + escapeHtml(task.id) + '" data-sub-id="' + escapeHtml(sub.id) + '" title="Batalkan sub-tugas (dikecualikan dari progres aktif)" aria-label="Batalkan sub-tugas">✕</button>';

            return (
              '<div class="' + rowCls + '">' +
              '<button type="button" class="subtask-check-btn" data-action="toggle-subtask" data-task-id="' + escapeHtml(task.id) + '" data-sub-id="' + escapeHtml(sub.id) + '"' + (sub.cancelled ? ' disabled' : '') + ' aria-label="Centang sub-tugas">' +
              '<span class="subtask-box">' + boxIcon + '</span>' +
              '</button>' +
              '<span class="subtask-text">' + escapeHtml(sub.title) + '</span>' +
              rightActions +
              '</div>'
            );
          })
          .join('');

        var showSubArea = (task.subtasks && task.subtasks.length > 0) || isAddingSub;
        var subSectionHtml = showSubArea
          ? '<div class="subtasks-wrap">' +
            subtasksRowsHtml +
            '<form class="subtask-add-form" data-subtask-form="' + escapeHtml(task.id) + '"' + (isAddingSub ? '' : ' hidden') + '>' +
            '<input type="text" class="subtask-input" name="subTitle" placeholder="Tulis sub-tugas baru..." maxlength="100" autocomplete="off" />' +
            '<button type="submit" class="subtask-submit-btn">Simpan</button>' +
            '</form>' +
            '</div>'
          : '';

        return (
          '<article class="task-card' + (task.done ? ' is-completed' : '') + '" role="listitem" data-task-card="' + escapeHtml(task.id) + '">' +
          '<div class="task-main-row">' +
          '<button type="button" class="task-check-hit" role="checkbox" aria-checked="' + (task.done ? 'true' : 'false') + '" data-action="toggle-task" data-task-id="' + escapeHtml(task.id) + '" aria-label="Tandai selesai">' +
          '<span class="task-checkbox"><svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"><polyline points="3.5 8.5 6.5 11.5 12.5 4.5"/></svg></span>' +
          '</button>' +
          '<div class="task-content">' +
          '<div class="task-title-line">' +
          titleControl +
          '<div class="task-actions">' +
          '<button type="button" class="task-act-btn" data-action="open-subtask-input" data-task-id="' + escapeHtml(task.id) + '" title="Tambah sub-tugas">+ Sub</button>' +
          '<button type="button" class="task-act-btn" data-action="edit-btn" data-task-id="' + escapeHtml(task.id) + '" aria-label="Edit judul tugas" title="Edit judul">✎</button>' +
          '<button type="button" class="task-act-btn is-danger" data-action="delete-task" data-task-id="' + escapeHtml(task.id) + '" aria-label="Hapus tugas" title="Hapus tugas">✕</button>' +
          '</div>' +
          '</div>' +
          '<div class="task-meta-pills">' +
          '<button type="button" class="meta-pill prio-pill-btn is-' + prioKey + '" data-action="cycle-priority" data-task-id="' + escapeHtml(task.id) + '" title="Klik untuk ganti prioritas">' +
          escapeHtml(PRIORITY_LABELS[prioKey]) +
          '</button>' +
          '<span class="meta-pill">' +
          '<span class="proj-dot" style="background-color:' + escapeHtml(proj.color) + '"></span>' +
          escapeHtml(proj.name) +
          '</span>' +
          '<span class="meta-pill tabular">' +
          escapeHtml(DAY_LABELS[task.dayBucket] || 'Hari Ini') + (task.time ? ' · ' + escapeHtml(task.time) : '') +
          '</span>' +
          subPillHtml +
          '</div>' +
          subSectionHtml +
          '</div>' +
          '</div>' +
          '</article>'
        );
      })
      .join('');

    els.taskListContainer.innerHTML = html;

    if (ui.editingTaskId) {
      var editInput = els.taskListContainer.querySelector('[data-edit-input="' + ui.editingTaskId + '"]');
      if (editInput) {
        editInput.focus();
        editInput.select();
      }
    } else if (ui.addingSubtaskForId) {
      var subForm = els.taskListContainer.querySelector('[data-subtask-form="' + ui.addingSubtaskForId + '"]');
      if (subForm) {
        var subInp = subForm.querySelector('input[name="subTitle"]');
        if (subInp) subInp.focus();
      }
    }
  }

  function renderActivityAndReminders() {
    var totalTasks = state.tasks.length;
    var doneTasks = state.tasks.filter(function (t) { return t.done; }).length;
    var activeTasksCount = totalTasks - doneTasks;
    var taskPct = totalTasks === 0 ? 0 : Math.round((doneTasks / totalTasks) * 100);

    var totalActiveSubs = 0;
    var doneActiveSubs = 0;
    state.tasks.forEach(function (t) {
      var st = computeSubtaskStats(t.subtasks);
      totalActiveSubs += st.activeCount;
      doneActiveSubs += st.doneCount;
    });
    var subPct = totalActiveSubs === 0 ? (taskPct > 0 ? taskPct : 0) : Math.round((doneActiveSubs / totalActiveSubs) * 100);

    els.activityPctBadge.textContent = taskPct + '%';
    els.ringCenterRatio.textContent = doneTasks + '/' + totalTasks;
    els.statTasksDone.textContent = doneTasks + ' selesai';
    els.statTasksActive.textContent = activeTasksCount + ' aktif';
    els.statSubsDone.textContent = doneActiveSubs + '/' + totalActiveSubs;
    els.statFocusMins.textContent = (state.focusMinutesToday || 0) + ' mnt';

    var outerOffset = RING_OUTER_CIRC - (RING_OUTER_CIRC * taskPct) / 100;
    var innerOffset = RING_INNER_CIRC - (RING_INNER_CIRC * subPct) / 100;
    els.svgRingTasks.style.strokeDashoffset = outerOffset.toFixed(2);
    els.svgRingSubtasks.style.strokeDashoffset = innerOffset.toFixed(2);

    // High-Priority & Nearest Reminders
    var urgent = state.tasks
      .filter(function (t) {
        return !t.done && (t.priority === 'high' || Boolean(t.time));
      })
      .sort(function (a, b) {
        var pa = PRIORITY_ORDER[a.priority] != null ? PRIORITY_ORDER[a.priority] : 1;
        var pb = PRIORITY_ORDER[b.priority] != null ? PRIORITY_ORDER[b.priority] : 1;
        if (pa !== pb) return pa - pb;
        return String(a.time || '23:59').localeCompare(String(b.time || '23:59'));
      })
      .slice(0, 5);

    var highOnlyCount = state.tasks.filter(function (t) {
      return !t.done && t.priority === 'high';
    }).length;
    els.highPrioCount.textContent = String(highOnlyCount);

    if (!urgent.length) {
      els.remindersList.innerHTML =
        '<div class="empty-state">' +
        '<p class="empty-state-title">Semua prioritas utama sudah selesai.</p>' +
        '<p class="empty-state-sub">Nikmati sisa hari Anda atau tambahkan jadwal berikutnya.</p>' +
        '</div>';
      return;
    }

    els.remindersList.innerHTML = urgent
      .map(function (t) {
        var proj = getProjectById(t.projectId);
        return (
          '<div class="reminder-item">' +
          '<button type="button" class="reminder-check-btn" data-action="toggle-task" data-task-id="' + escapeHtml(t.id) + '" aria-label="Selesaikan tugas">' +
          '<span class="task-checkbox"><svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="2.4"><polyline points="3.5 8.5 6.5 11.5 12.5 4.5"/></svg></span>' +
          '</button>' +
          '<div class="reminder-body">' +
          '<div class="reminder-title">' + escapeHtml(t.title) + '</div>' +
          '<div class="reminder-meta tabular">' +
          '<span class="reminder-time-chip">' + escapeHtml(t.time || 'Tanpa jam') + '</span>' +
          '<span>&middot;</span>' +
          '<span>' + escapeHtml(proj.name) + '</span>' +
          (t.priority === 'high' ? '<span>&middot; Prioritas Tinggi</span>' : '') +
          '</div>' +
          '</div>' +
          '</div>'
        );
      })
      .join('');
  }

  function renderProjectsBoard() {
    if (ui.activeView !== 'projects') return;

    els.projectsBoardGrid.innerHTML = state.projects
      .map(function (proj) {
        var pTasks = state.tasks.filter(function (t) { return t.projectId === proj.id; });
        var doneCount = pTasks.filter(function (t) { return t.done; }).length;
        var itemsHtml = pTasks.length
          ? pTasks
              .map(function (t) {
                return (
                  '<div class="reminder-item">' +
                  '<button type="button" class="reminder-check-btn task-check-hit" aria-checked="' + (t.done ? 'true' : 'false') + '" data-action="toggle-task" data-task-id="' + escapeHtml(t.id) + '">' +
                  '<span class="task-checkbox"><svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="2.4"><polyline points="3.5 8.5 6.5 11.5 12.5 4.5"/></svg></span>' +
                  '</button>' +
                  '<div class="reminder-body">' +
                  '<div class="reminder-title" style="' + (t.done ? 'text-decoration:line-through;opacity:0.6;' : '') + '">' + escapeHtml(t.title) + '</div>' +
                  '<div class="reminder-meta tabular">' + escapeHtml(PRIORITY_LABELS[t.priority] || 'Sedang') + (t.time ? ' · ' + escapeHtml(t.time) : '') + '</div>' +
                  '</div>' +
                  '</div>'
                );
              })
              .join('')
          : '<p class="empty-state-sub">Belum ada tugas di proyek ini.</p>';

        return (
          '<article class="project-column-card">' +
          '<div class="project-col-head">' +
          '<div class="project-col-title">' +
          '<span class="proj-dot" style="background-color:' + escapeHtml(proj.color) + '"></span>' +
          '<span>' + escapeHtml(proj.name) + '</span>' +
          '</div>' +
          '<span class="widget-count-pill tabular">' + doneCount + '/' + pTasks.length + '</span>' +
          '</div>' +
          itemsHtml +
          '<button type="button" class="btn-reset-seed" data-open-proj-filter="' + escapeHtml(proj.id) + '">Kelola di Daftar Tugas &rarr;</button>' +
          '</article>'
        );
      })
      .join('');
  }

  function renderStatsView() {
    if (ui.activeView !== 'stats') return;

    var total = state.tasks.length;
    var done = state.tasks.filter(function (t) { return t.done; }).length;
    var pct = total === 0 ? 0 : Math.round((done / total) * 100);

    var activeSubs = 0;
    var doneSubs = 0;
    var cancelledSubs = 0;
    state.tasks.forEach(function (t) {
      var st = computeSubtaskStats(t.subtasks);
      activeSubs += st.activeCount;
      doneSubs += st.doneCount;
      cancelledSubs += st.cancelledCount;
    });

    els.statsKpiGrid.innerHTML =
      '<div class="kpi-card"><div class="kpi-label">Rasio Penyelesaian</div><div class="kpi-val">' + pct + '%</div></div>' +
      '<div class="kpi-card"><div class="kpi-label">Tugas Selesai</div><div class="kpi-val">' + done + ' / ' + total + '</div></div>' +
      '<div class="kpi-card"><div class="kpi-label">Sub-tugas Aktif Tuntas</div><div class="kpi-val">' + doneSubs + ' / ' + activeSubs + '</div></div>' +
      '<div class="kpi-card"><div class="kpi-label">Waktu Fokus Tercatat</div><div class="kpi-val">' + (state.focusMinutesToday || 0) + ' mnt</div></div>';

    els.statsByProject.innerHTML = state.projects
      .map(function (proj) {
        var pTasks = state.tasks.filter(function (t) { return t.projectId === proj.id; });
        var pDone = pTasks.filter(function (t) { return t.done; }).length;
        var pPct = pTasks.length === 0 ? 0 : Math.round((pDone / pTasks.length) * 100);
        return (
          '<div class="b-bar-row tabular">' +
          '<div class="b-bar-top"><span>' + escapeHtml(proj.name) + '</span><span>' + pDone + '/' + pTasks.length + ' (' + pPct + '%)</span></div>' +
          '<div class="b-bar-track"><div class="b-bar-fill" style="width:' + pPct + '%;background-color:' + escapeHtml(proj.color) + '"></div></div>' +
          '</div>'
        );
      })
      .join('');

    var prioRows = ['high', 'medium', 'low']
      .map(function (key) {
        var list = state.tasks.filter(function (t) { return t.priority === key; });
        var d = list.filter(function (t) { return t.done; }).length;
        var rPct = list.length === 0 ? 0 : Math.round((d / list.length) * 100);
        return (
          '<div class="b-bar-row tabular">' +
          '<div class="b-bar-top"><span>Prioritas ' + escapeHtml(PRIORITY_LABELS[key]) + '</span><span>' + d + '/' + list.length + ' selesai</span></div>' +
          '<div class="b-bar-track"><div class="b-bar-fill" style="width:' + rPct + '%"></div></div>' +
          '</div>'
        );
      })
      .join('');

    els.statsByPriority.innerHTML =
      prioRows +
      '<div class="b-bar-row tabular">' +
      '<div class="b-bar-top"><span>Sub-tugas Dibatalkan (Dikecualikan)</span><span>' + cancelledSubs + ' item</span></div>' +
      '</div>';
  }

  function syncActiveViewVisibility() {
    var isTasksView = ui.activeView === 'today' || ui.activeView === 'all';
    if (isTasksView) {
      els.viewTasksWorkspace.removeAttribute('hidden');
      els.viewProjectsBoard.setAttribute('hidden', '');
      els.viewStatsDetail.setAttribute('hidden', '');
    } else if (ui.activeView === 'projects') {
      els.viewTasksWorkspace.setAttribute('hidden', '');
      els.viewProjectsBoard.removeAttribute('hidden');
      els.viewStatsDetail.setAttribute('hidden', '');
    } else {
      els.viewTasksWorkspace.setAttribute('hidden', '');
      els.viewProjectsBoard.setAttribute('hidden', '');
      els.viewStatsDetail.removeAttribute('hidden');
    }
  }

  function renderAll() {
    updateGreetingAndDate();
    syncActiveViewVisibility();
    renderSidebarAndSelects();
    renderTaskList();
    renderActivityAndReminders();
    renderProjectsBoard();
    renderStatsView();
  }

  /* =========================
     Focus Timer Engine
     ========================= */
  function formatClock(totalSeconds) {
    var hrs = Math.floor(totalSeconds / 3600);
    var mins = Math.floor((totalSeconds % 3600) / 60);
    var secs = totalSeconds % 60;
    return (
      String(hrs).padStart(2, '0') + ':' +
      String(mins).padStart(2, '0') + ':' +
      String(secs).padStart(2, '0')
    );
  }

  function syncTimerUI() {
    els.timerDisplay.textContent = formatClock(ui.timerSeconds);
    els.btnTimerToggle.classList.toggle('is-running', ui.timerRunning);
    els.timerLiveDot.classList.toggle('is-running', ui.timerRunning);
    els.timerToggleLabel.textContent = ui.timerRunning ? 'Jeda' : 'Mulai';
    els.timerModeTabs.querySelectorAll('[data-timer-mode]').forEach(function (b) {
      b.classList.toggle('is-active', b.getAttribute('data-timer-mode') === ui.timerMode);
    });
  }

  function setTimerMode(mode) {
    stopTimer();
    ui.timerMode = mode;
    if (mode === 'pomodoro') {
      ui.timerSeconds = 25 * 60;
    } else if (mode === 'break') {
      ui.timerSeconds = 5 * 60;
    } else {
      ui.timerSeconds = 0;
    }
    syncTimerUI();
  }

  function stopTimer() {
    if (ui.timerIntervalId) {
      window.clearInterval(ui.timerIntervalId);
      ui.timerIntervalId = null;
    }
    ui.timerRunning = false;
    syncTimerUI();
  }

  function toggleTimer() {
    if (ui.timerRunning) {
      stopTimer();
      return;
    }
    ui.timerRunning = true;
    var elapsedFocusTicks = 0;
    syncTimerUI();

    ui.timerIntervalId = window.setInterval(function () {
      if (ui.timerMode === 'stopwatch') {
        ui.timerSeconds += 1;
        elapsedFocusTicks += 1;
      } else {
        if (ui.timerSeconds > 0) {
          ui.timerSeconds -= 1;
          if (ui.timerMode === 'pomodoro') elapsedFocusTicks += 1;
        } else {
          stopTimer();
          showUndoSnackbar('Sesi waktu selesai!', null);
          return;
        }
      }

      if (elapsedFocusTicks > 0 && elapsedFocusTicks % 60 === 0) {
        state.focusMinutesToday = (state.focusMinutesToday || 0) + 1;
        saveState(state);
        renderActivityAndReminders();
      }
      els.timerDisplay.textContent = formatClock(ui.timerSeconds);
    }, 1000);
  }

  /* =========================
     Task & Subtask Mutations
     ========================= */
  function commitInlineTaskEdit(taskId, newValue) {
    var task = state.tasks.find(function (t) { return t.id === taskId; });
    if (task) {
      var trimmed = String(newValue || '').trim();
      if (trimmed) {
        task.title = trimmed;
        saveState(state);
      }
    }
    ui.editingTaskId = null;
    renderAll();
  }

  function toggleTaskDone(taskId) {
    var task = state.tasks.find(function (t) { return t.id === taskId; });
    if (!task) return;
    task.done = !task.done;
    saveState(state);
    renderAll();
  }

  function cycleTaskPriority(taskId) {
    var order = ['high', 'medium', 'low'];
    var task = state.tasks.find(function (t) { return t.id === taskId; });
    if (!task) return;
    var nextIdx = (order.indexOf(task.priority) + 1) % order.length;
    task.priority = order[nextIdx];
    saveState(state);
    renderAll();
  }

  function deleteTask(taskId) {
    var idx = state.tasks.findIndex(function (t) { return t.id === taskId; });
    if (idx === -1) return;
    var removed = state.tasks.splice(idx, 1)[0];
    saveState(state);
    renderAll();
    showUndoSnackbar('Tugas dihapus.', {
      type: 'delete_task',
      index: idx,
      taskCopy: removed
    });
  }

  function toggleSubtaskDone(taskId, subId) {
    var task = state.tasks.find(function (t) { return t.id === taskId; });
    if (!task || !Array.isArray(task.subtasks)) return;
    var sub = task.subtasks.find(function (s) { return s.id === subId; });
    if (!sub || sub.cancelled) return;
    sub.done = !sub.done;
    saveState(state);
    renderAll();
  }

  function cancelSubtask(taskId, subId) {
    var task = state.tasks.find(function (t) { return t.id === taskId; });
    if (!task || !Array.isArray(task.subtasks)) return;
    var sub = task.subtasks.find(function (s) { return s.id === subId; });
    if (!sub || sub.cancelled) return;

    var prevDone = sub.done;
    sub.cancelled = true;
    sub.done = false;
    saveState(state);
    renderAll();

    showUndoSnackbar('Sub-tugas dibatalkan · Dikecualikan dari progres', {
      type: 'cancel_subtask',
      taskId: taskId,
      subtaskId: subId,
      previousDone: prevDone
    });
  }

  function restoreSubtask(taskId, subId) {
    var task = state.tasks.find(function (t) { return t.id === taskId; });
    if (!task || !Array.isArray(task.subtasks)) return;
    var sub = task.subtasks.find(function (s) { return s.id === subId; });
    if (!sub) return;
    sub.cancelled = false;
    saveState(state);
    renderAll();
  }

  function deleteSubtask(taskId, subId) {
    var task = state.tasks.find(function (t) { return t.id === taskId; });
    if (!task || !Array.isArray(task.subtasks)) return;
    task.subtasks = task.subtasks.filter(function (s) { return s.id !== subId; });
    saveState(state);
    renderAll();
  }

  /* =========================
     Mobile Sidebar Drawer Helpers
     ========================= */
  function openMobileSidebar() {
    els.sidebar.classList.add('is-open');
    els.backdrop.removeAttribute('hidden');
  }

  function closeMobileSidebar() {
    els.sidebar.classList.remove('is-open');
    els.backdrop.setAttribute('hidden', '');
  }

  /* =========================
     Event Delegation & Listeners
     ========================= */
  function bindEvents() {
    // Mobile sidebar controls
    els.btnOpenSidebar.addEventListener('click', openMobileSidebar);
    els.btnCloseSidebar.addEventListener('click', closeMobileSidebar);
    els.backdrop.addEventListener('click', closeMobileSidebar);

    els.btnSidebarNewTask.addEventListener('click', function () {
      ui.activeView = 'today';
      closeMobileSidebar();
      renderAll();
      els.inputTaskTitle.focus();
    });

    // Main Sidebar Nav
    els.sidebarNav.addEventListener('click', function (e) {
      var btn = e.target.closest('[data-nav-view]');
      if (!btn) return;
      ui.activeView = btn.getAttribute('data-nav-view');
      ui.projectFilter = null;
      closeMobileSidebar();
      renderAll();
    });

    // Sidebar Project Filtering
    els.sidebarProjectList.addEventListener('click', function (e) {
      var btn = e.target.closest('[data-filter-project]');
      if (!btn) return;
      var pid = btn.getAttribute('data-filter-project');
      ui.projectFilter = ui.projectFilter === pid ? null : pid;
      if (ui.activeView === 'projects' || ui.activeView === 'stats') {
        ui.activeView = 'all';
      }
      closeMobileSidebar();
      renderAll();
    });

    els.btnClearProjFilter.addEventListener('click', function () {
      ui.projectFilter = null;
      renderAll();
    });

    // Add New Project
    els.btnToggleProjForm.addEventListener('click', function () {
      var isHidden = els.projForm.hasAttribute('hidden');
      if (isHidden) {
        els.projForm.removeAttribute('hidden');
        els.btnToggleProjForm.setAttribute('aria-expanded', 'true');
        els.inputNewProj.focus();
      } else {
        els.projForm.setAttribute('hidden', '');
        els.btnToggleProjForm.setAttribute('aria-expanded', 'false');
      }
    });

    els.projColorPicker.addEventListener('click', function (e) {
      var choice = e.target.closest('[data-proj-color]');
      if (!choice) return;
      ui.newProjectColor = choice.getAttribute('data-proj-color');
      els.projColorPicker.querySelectorAll('[data-proj-color]').forEach(function (b) {
        b.classList.toggle('is-selected', b === choice);
      });
    });

    els.projForm.addEventListener('submit', function (e) {
      e.preventDefault();
      var name = els.inputNewProj.value.trim();
      if (!name) return;
      var newProj = {
        id: uid('proj'),
        name: name,
        color: ui.newProjectColor
      };
      state.projects.push(newProj);
      saveState(state);
      els.inputNewProj.value = '';
      els.projForm.setAttribute('hidden', '');
      els.btnToggleProjForm.setAttribute('aria-expanded', 'false');
      renderAll();
    });

    // Reset Demo Seed
    els.btnResetDemo.addEventListener('click', function () {
      state = createStarterState();
      saveState(state);
      ui.projectFilter = null;
      ui.statusFilter = 'all';
      ui.searchQuery = '';
      els.searchInput.value = '';
      els.btnClearSearch.setAttribute('hidden', '');
      closeMobileSidebar();
      renderAll();
      showUndoSnackbar('Tugas contoh berhasil dipulihkan.', null);
    });

    // Search Real-time
    els.searchInput.addEventListener('input', function () {
      ui.searchQuery = els.searchInput.value;
      if (ui.searchQuery) {
        els.btnClearSearch.removeAttribute('hidden');
      } else {
        els.btnClearSearch.setAttribute('hidden', '');
      }
      if (ui.activeView === 'projects' || ui.activeView === 'stats') {
        ui.activeView = 'all';
      }
      renderAll();
    });

    els.btnClearSearch.addEventListener('click', function () {
      ui.searchQuery = '';
      els.searchInput.value = '';
      els.btnClearSearch.setAttribute('hidden', '');
      els.searchInput.focus();
      renderAll();
    });

    // Theme & Accent Switchers
    els.themeSwitcher.addEventListener('click', function (e) {
      var btn = e.target.closest('[data-set-theme]');
      if (!btn) return;
      applyTheme(btn.getAttribute('data-set-theme'), true);
    });

    els.accentSwitcher.addEventListener('click', function (e) {
      var btn = e.target.closest('[data-set-accent]');
      if (!btn) return;
      applyAccent(btn.getAttribute('data-set-accent'), true);
    });

    // Personalize Greeting Username
    els.btnEditUsername.addEventListener('click', function () {
      var nextName = window.prompt('Masukkan nama sapaan Anda:', state.userName || 'Rekan');
      if (nextName !== null) {
        var clean = nextName.trim().slice(0, 28);
        state.userName = clean || 'Rekan';
        saveState(state);
        updateGreetingAndDate();
      }
    });

    // Status Filter Tabs
    els.statusFilterTabs.addEventListener('click', function (e) {
      var tab = e.target.closest('[data-status-filter]');
      if (!tab) return;
      ui.statusFilter = tab.getAttribute('data-status-filter');
      renderTaskList();
    });

    // New Task Composer
    els.composerForm.addEventListener('submit', function (e) {
      e.preventDefault();
      var title = els.inputTaskTitle.value.trim();
      if (!title) return;

      var newTask = {
        id: uid('task'),
        title: title,
        done: false,
        priority: els.selectTaskPrio.value || 'medium',
        projectId: els.selectTaskProj.value || (state.projects[0] && state.projects[0].id) || 'proj_ui',
        dayBucket: els.selectTaskDay.value || 'today',
        time: els.inputTaskTime.value || '',
        expandedSubtasks: false,
        subtasks: []
      };

      state.tasks.unshift(newTask);
      saveState(state);
      els.inputTaskTitle.value = '';
      renderAll();
    });

    // Event Delegation on Task List
    els.taskListContainer.addEventListener('click', function (e) {
      var actionEl = e.target.closest('[data-action]');
      if (!actionEl) return;

      var action = actionEl.getAttribute('data-action');
      var taskId = actionEl.getAttribute('data-task-id');
      var subId = actionEl.getAttribute('data-sub-id');

      if (action === 'toggle-task') {
        toggleTaskDone(taskId);
      } else if (action === 'edit-btn') {
        ui.editingTaskId = taskId;
        renderTaskList();
      } else if (action === 'delete-task') {
        deleteTask(taskId);
      } else if (action === 'cycle-priority') {
        cycleTaskPriority(taskId);
      } else if (action === 'open-subtask-input') {
        ui.addingSubtaskForId = ui.addingSubtaskForId === taskId ? null : taskId;
        renderTaskList();
      } else if (action === 'toggle-subtask') {
        toggleSubtaskDone(taskId, subId);
      } else if (action === 'cancel-subtask') {
        cancelSubtask(taskId, subId);
      } else if (action === 'restore-subtask') {
        restoreSubtask(taskId, subId);
      } else if (action === 'delete-subtask') {
        deleteSubtask(taskId, subId);
      }
    });

    els.taskListContainer.addEventListener('dblclick', function (e) {
      var titleSpan = e.target.closest('[data-action="start-edit"]');
      if (!titleSpan) return;
      ui.editingTaskId = titleSpan.getAttribute('data-task-id');
      renderTaskList();
    });

    els.taskListContainer.addEventListener('keydown', function (e) {
      var editInput = e.target.closest('[data-edit-input]');
      if (!editInput) return;
      var taskId = editInput.getAttribute('data-edit-input');
      if (e.key === 'Enter') {
        e.preventDefault();
        commitInlineTaskEdit(taskId, editInput.value);
      } else if (e.key === 'Escape') {
        ui.editingTaskId = null;
        renderTaskList();
      }
    });

    els.taskListContainer.addEventListener(
      'blur',
      function (e) {
        var editInput = e.target.closest('[data-edit-input]');
        if (!editInput) return;
        var taskId = editInput.getAttribute('data-edit-input');
        if (ui.editingTaskId === taskId) {
          commitInlineTaskEdit(taskId, editInput.value);
        }
      },
      true
    );

    els.taskListContainer.addEventListener('submit', function (e) {
      var subForm = e.target.closest('[data-subtask-form]');
      if (!subForm) return;
      e.preventDefault();
      var taskId = subForm.getAttribute('data-subtask-form');
      var inp = subForm.querySelector('input[name="subTitle"]');
      var text = inp ? inp.value.trim() : '';
      if (!text) {
        ui.addingSubtaskForId = null;
        renderTaskList();
        return;
      }
      var task = state.tasks.find(function (t) { return t.id === taskId; });
      if (task) {
        if (!Array.isArray(task.subtasks)) task.subtasks = [];
        task.subtasks.push({
          id: uid('sub'),
          title: text,
          done: false,
          cancelled: false
        });
        saveState(state);
      }
      ui.addingSubtaskForId = taskId;
      renderAll();
    });

    // Reminders & Projects Board Delegation
    els.remindersList.addEventListener('click', function (e) {
      var btn = e.target.closest('[data-action="toggle-task"]');
      if (!btn) return;
      toggleTaskDone(btn.getAttribute('data-task-id'));
    });

    els.projectsBoardGrid.addEventListener('click', function (e) {
      var toggleBtn = e.target.closest('[data-action="toggle-task"]');
      if (toggleBtn) {
        toggleTaskDone(toggleBtn.getAttribute('data-task-id'));
        return;
      }
      var jumpBtn = e.target.closest('[data-open-proj-filter]');
      if (jumpBtn) {
        ui.projectFilter = jumpBtn.getAttribute('data-open-proj-filter');
        ui.activeView = 'all';
        renderAll();
      }
    });

    // Focus Timer Controls
    els.timerModeTabs.addEventListener('click', function (e) {
      var btn = e.target.closest('[data-timer-mode]');
      if (!btn) return;
      setTimerMode(btn.getAttribute('data-timer-mode'));
    });

    els.btnTimerToggle.addEventListener('click', toggleTimer);
    els.btnTimerReset.addEventListener('click', function () {
      setTimerMode(ui.timerMode);
    });

    // Snackbar Controls
    els.btnSnackbarUndo.addEventListener('click', handleUndoAction);
    els.btnSnackbarClose.addEventListener('click', hideSnackbar);

    // Global Keyboard Shortcuts ('/' to search, 'Escape' to close drawer/snackbar)
    document.addEventListener('keydown', function (e) {
      var tag = (e.target && e.target.tagName) || '';
      if (e.key === '/' && tag !== 'INPUT' && tag !== 'TEXTAREA' && tag !== 'SELECT') {
        e.preventDefault();
        els.searchInput.focus();
      } else if (e.key === 'Escape') {
        closeMobileSidebar();
      }
    });
  }

  /* =========================
     Bootstrap
     ========================= */
  var initTheme = getStoredPref(
    THEME_KEY,
    window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
  );
  var initAccent = getStoredPref(ACCENT_KEY, 'indigo');

  applyTheme(initTheme, false);
  applyAccent(initAccent, false);
  bindEvents();
  syncTimerUI();
  renderAll();
})();
