// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => 'Agenda';

  @override
  String get navBoard => 'Tablero';

  @override
  String get navUnplanned => 'Sin fecha';

  @override
  String get navMore => 'Más';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get close => 'Cerrar';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit => 'Editar';

  @override
  String get undo => 'Deshacer';

  @override
  String get back => 'Volver';

  @override
  String get retry => 'Reintentar';

  @override
  String get clear => 'Limpiar';

  @override
  String get all => 'Todos';

  @override
  String get or => 'o';

  @override
  String get continueAction => 'Continuar';

  @override
  String get understand => 'Entendido';

  @override
  String get useAction => 'Usar';

  @override
  String get today => 'Hoy';

  @override
  String get tomorrow => 'Mañana';

  @override
  String get yesterday => 'Ayer';

  @override
  String get toDo => 'Pendientes';

  @override
  String get overdue => 'Atrasadas';

  @override
  String get unplanned => 'Sin fecha';

  @override
  String get allDay => 'Todo el día';

  @override
  String get scheduled => 'Programadas';

  @override
  String get addTaskToday => 'Añadir tarea para hoy';

  @override
  String get addTask => 'Añadir tarea';

  @override
  String get noTasksForDate => 'No hay tareas para esta fecha.';

  @override
  String get savedToUnplanned => 'Guardada en Sin fecha';

  @override
  String get savedToUnplannedNoDate => 'Guardada en Sin fecha (sin fecha)';

  @override
  String scheduledForDate(String date) {
    return 'Programada para el $date';
  }

  @override
  String taskScheduledForDate(String date) {
    return 'Tarea programada para el $date';
  }

  @override
  String get taskDeleted => 'Tarea eliminada';

  @override
  String get searchTasksTooltip => 'Buscar tareas';

  @override
  String get timelineOptionsTooltip => 'Opciones de agenda';

  @override
  String get addTaskTooltip => 'Añadir tarea';

  @override
  String get completedLabel => 'Completada';

  @override
  String get uncompleteLabel => 'Marcar activa';

  @override
  String subtasksCount(int done, int total) {
    return '$done/$total subtareas';
  }

  @override
  String get repeatingTaskLabel => 'Tarea recurrente';

  @override
  String get quickAddHint => 'Añade una nueva tarea...';

  @override
  String get expandTooltip => 'Ampliar';

  @override
  String get saveTaskTooltip => 'Guardar tarea';

  @override
  String get newTask => 'Nueva tarea';

  @override
  String get editTask => 'Editar tarea';

  @override
  String get taskTitleLabel => 'Título de la tarea';

  @override
  String get taskTitleHint => 'Ej.: Revisar notas del sprint';

  @override
  String get taskTitleRequired => 'El título es obligatorio';

  @override
  String get descriptionLabel => 'Descripción';

  @override
  String get descriptionHint => 'Añade notas o contexto...';

  @override
  String get pickDate => 'Elegir fecha';

  @override
  String get pickOnCalendar => 'Elegir en calendario...';

  @override
  String get noDateUnplanned => 'Sin fecha (Sin planificar)';

  @override
  String get noDate => 'Sin fecha';

  @override
  String get taskTime => 'Hora de la tarea';

  @override
  String get changeTime => 'Cambiar hora';

  @override
  String get clearTimeAllDay => 'Quitar hora (Todo el día)';

  @override
  String get timeLabel => 'Hora';

  @override
  String get reminderLabel => 'Recordatorio';

  @override
  String get noReminder => 'Sin recordatorio';

  @override
  String get atTime => 'A la hora';

  @override
  String get minutesBefore10 => '10 min antes';

  @override
  String get minutesBefore30 => '30 min antes';

  @override
  String get hourBefore1 => '1 hora antes';

  @override
  String get reminderShort10m => '10 m';

  @override
  String get reminderShort30m => '30 m';

  @override
  String get reminderShort1h => '1 h';

  @override
  String get projectLabel => 'Proyecto';

  @override
  String get noProject => 'Sin proyecto';

  @override
  String get tagLabel => 'Etiqueta';

  @override
  String get noTag => 'Sin etiqueta';

  @override
  String get priorityLabel => 'Prioridad';

  @override
  String get priorityLow => 'Baja';

  @override
  String get priorityMedium => 'Media';

  @override
  String get priorityHigh => 'Alta';

  @override
  String get saveTask => 'Guardar tarea';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get checklistLabel => 'Lista de verificación';

  @override
  String get addChecklistHint => 'Añadir elemento...';

  @override
  String get repeatLabel => 'Repetir';

  @override
  String get noRepeat => 'No se repite';

  @override
  String get repeatDaily => 'Cada día';

  @override
  String get repeatWeekly => 'Cada semana';

  @override
  String get repeatMonthly => 'Cada mes';

  @override
  String get colorLabel => 'Color';

  @override
  String get timelineOptionsTitle => 'Opciones de agenda';

  @override
  String get viewModeLabel => 'Modo de vista';

  @override
  String get modeTimeline => 'Modo Agenda';

  @override
  String get modeDaily => 'Modo Diario';

  @override
  String get firstDayOfWeek => 'Inicio de semana';

  @override
  String get monday => 'Lunes';

  @override
  String get sunday => 'Domingo';

  @override
  String get firstDayMondayOrder => 'Lun · Mar · Mié · Jue · Vie · Sáb · Dom';

  @override
  String get firstDaySundayOrder => 'Dom · Lun · Mar · Mié · Jue · Vie · Sáb';

  @override
  String get showCompletedTasks => 'Mostrar tareas completadas';

  @override
  String get showCompletedTasksSubtitle =>
      'Oculta las tareas marcadas para enfocarte en las activas.';

  @override
  String get showCompletedWorkspaceSubtitle =>
      'Mostrar u ocultar tareas completadas.';

  @override
  String get overdueTasksTitle => 'Tareas atrasadas';

  @override
  String get noOverdueTasks => 'Sin tareas atrasadas';

  @override
  String get moveToToday => 'Mover a Hoy';

  @override
  String get moveAllToToday => 'Mover todas a Hoy';

  @override
  String get searchTasksHint => 'Buscar tareas...';

  @override
  String get searchTasksEmpty =>
      'Escribe para buscar tareas, descripciones o listas.';

  @override
  String searchNoResults(String query) {
    return 'Ninguna tarea coincide con \"$query\".';
  }

  @override
  String get calendarEventReadOnly => 'Evento de calendario · solo lectura';

  @override
  String get prevWeekTooltip => 'Semana anterior';

  @override
  String get nextWeekTooltip => 'Semana siguiente';

  @override
  String get boardTitle => 'Tablero';

  @override
  String get allProjects => 'Todos los proyectos';

  @override
  String get searchProjectHint => 'Buscar proyecto...';

  @override
  String get searchProjectTooltip => 'Buscar proyectos';

  @override
  String get closeSearchTooltip => 'Cerrar búsqueda';

  @override
  String get createProject => 'Crear proyecto';

  @override
  String get editProject => 'Editar proyecto';

  @override
  String get deleteProject => 'Eliminar proyecto';

  @override
  String get projectOptionsTooltip => 'Opciones de proyecto';

  @override
  String projectDeleted(String name) {
    return 'Proyecto \"$name\" eliminado';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return '$done/$total completadas';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return '$done/$total tareas completadas';
  }

  @override
  String get projectNotFound => 'Proyecto no encontrado';

  @override
  String get noProjectsYet => 'Aún no hay proyectos';

  @override
  String projectSearchEmpty(String query) {
    return 'Ningún proyecto coincide con \"$query\".';
  }

  @override
  String get noProjectsSubtitle =>
      'Toca el botón de carpeta abajo para crear tu primer proyecto.';

  @override
  String get newProject => 'Nuevo proyecto';

  @override
  String get projectNameLabel => 'Nombre del proyecto';

  @override
  String get projectNameHint => 'Ej.: Lanzamiento Zettask';

  @override
  String get projectNameRequired => 'El nombre del proyecto es obligatorio';

  @override
  String get projectColorLabel => 'Color del proyecto';

  @override
  String get unplannedTitle => 'Sin fecha';

  @override
  String activeCountLabel(int count) {
    return '$count activas';
  }

  @override
  String get noUnplannedTitle => 'Sin tareas sin fecha';

  @override
  String get noUnplannedSubtitle => 'Toca + para anotar una tarea sin fecha.';

  @override
  String get addUnplannedTooltip => 'Añadir tarea sin fecha';

  @override
  String get workspaceTitle => 'Espacio de trabajo';

  @override
  String get organizeSection => 'Organizar';

  @override
  String get automationSection => 'Automatización';

  @override
  String get insightsSection => 'Estadísticas y personalización';

  @override
  String get settingsInfoSection => 'Ajustes e información';

  @override
  String get tagsTitle => 'Etiquetas';

  @override
  String get tagsSubtitleEmpty => 'Etiquetas de color para tareas y notas';

  @override
  String tagsCountSubtitle(int count) {
    return '$count etiquetas guardadas';
  }

  @override
  String get newTag => 'Nueva etiqueta';

  @override
  String get editTag => 'Editar etiqueta';

  @override
  String get tagNameLabel => 'Nombre de etiqueta';

  @override
  String get tagNameRequired => 'El nombre de etiqueta es obligatorio';

  @override
  String get tagDeleted => 'Etiqueta eliminada';

  @override
  String get noTagsYet => 'Aún no hay etiquetas';

  @override
  String tagTasksCount(int count) {
    return '$count tareas';
  }

  @override
  String get templatesTitle => 'Plantillas';

  @override
  String get templatesSubtitleEmpty => 'Guarda estructuras de tareas y listas';

  @override
  String templatesCountSubtitle(int count) {
    return '$count plantillas listas';
  }

  @override
  String get newTemplate => 'Nueva plantilla';

  @override
  String get editTemplate => 'Editar plantilla';

  @override
  String get templateNameLabel => 'Nombre de plantilla';

  @override
  String get templateNameRequired => 'El nombre de plantilla es obligatorio';

  @override
  String get templateDeleted => 'Plantilla eliminada';

  @override
  String get noTemplatesYet => 'Aún no hay plantillas';

  @override
  String get taskFromTemplateSaved => 'Tarea guardada desde plantilla';

  @override
  String get notesTitle => 'Notas';

  @override
  String get notesSubtitleEmpty => 'Notas rápidas sin fecha';

  @override
  String notesCountSubtitle(int count) {
    return '$count notas guardadas';
  }

  @override
  String get newNote => 'Nueva nota';

  @override
  String get editNote => 'Editar nota';

  @override
  String get noteTitleLabel => 'Título de la nota';

  @override
  String get noteTitleHint => 'Ej.: Resumen de reunión';

  @override
  String get noteTitleRequired => 'El título es obligatorio';

  @override
  String get noteContentLabel => 'Contenido';

  @override
  String get noteContentHint => 'Escribe tu nota aquí...';

  @override
  String get noteDeleted => 'Nota eliminada';

  @override
  String get searchNotesHint => 'Buscar notas...';

  @override
  String get noteNotFound => 'Nota no encontrada';

  @override
  String get noNotesYet => 'Aún no hay notas';

  @override
  String noteSearchEmpty(String query) {
    return 'Ninguna nota coincide con \"$query\".';
  }

  @override
  String get noNotesSubtitle => 'Toca + para escribir una nota rápida.';

  @override
  String get saveNote => 'Guardar nota';

  @override
  String get repeatingTasksTitle => 'Tareas recurrentes';

  @override
  String get repeatingTasksSubtitleEmpty =>
      'Gestiona rutinas diarias, semanales y mensuales';

  @override
  String repeatingActiveCount(int count) {
    return '$count rutinas activas';
  }

  @override
  String get noRepeatingTasks => 'Aún no hay tareas recurrentes';

  @override
  String get repeatingActionTitle => 'Esta es una tarea recurrente';

  @override
  String get repeatingThisOnly => 'Solo esta tarea';

  @override
  String get repeatingThisAndFollowing => 'Esta y todas las siguientes';

  @override
  String get last7DaysUpper => 'ÚLTIMOS 7 DÍAS';

  @override
  String weeklySummary(int tasks, int checklists) {
    return '$tasks tareas, más $checklists elementos de lista';
  }

  @override
  String get statsTitle => 'Estadísticas';

  @override
  String get range7Days => '7 días';

  @override
  String get range30Days => '30 días';

  @override
  String get completedToday => 'Hechas hoy';

  @override
  String get last7DaysLabel => 'Últimos 7 días';

  @override
  String get last30DaysLabel => 'Últimos 30 días';

  @override
  String get allTimeLabel => 'Histórico';

  @override
  String get completionRateLabel => 'Tasa de logro';

  @override
  String get activity7Days => 'Actividad últimos 7 días';

  @override
  String get activity30Days => 'Actividad últimos 30 días';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks tareas · $checklists listas';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return 'Total $days días: $tasks tareas, más $checklists elementos';
  }

  @override
  String get completedByPriority => 'Completadas por prioridad';

  @override
  String get progressByProject => 'Progreso por proyecto';

  @override
  String get breakdownByTag => 'Desglose por etiqueta';

  @override
  String get habits30Days => 'Hábitos · 30 días';

  @override
  String get noProjectsCreated => 'Aún no se han creado proyectos.';

  @override
  String get noTagsCreated => 'Aún no se han creado etiquetas.';

  @override
  String get noActiveHabits => 'No hay rutinas activas.';

  @override
  String completedCountLabel(int count) {
    return '$count hechas';
  }

  @override
  String tagBreakdownTrailing(int done, int total) {
    return '$done/$total hechas';
  }

  @override
  String habitCompletedRatio(String summary, int done, int scheduled) {
    return '$summary · $done/$scheduled hechas';
  }

  @override
  String statsSubtitle(int completed, int percent) {
    return '$completed completadas · $percent% tasa';
  }

  @override
  String get themeTitle => 'Tema';

  @override
  String get themeAndColorsTitle => 'Tema y colores';

  @override
  String get livePreviewSection => 'Vista previa';

  @override
  String get appearanceModeSection => 'Modo de apariencia';

  @override
  String get colorPaletteSection => 'Paleta de colores';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeSystemLight => 'Sistema (Claro)';

  @override
  String get themeSystemDark => 'Sistema (Oscuro)';

  @override
  String get presetDefault => 'Predeterminado';

  @override
  String get presetDefaultDesc => 'Índigo y pizarra';

  @override
  String get presetOcean => 'Océano';

  @override
  String get presetOceanDesc => 'Azul sereno';

  @override
  String get presetForest => 'Bosque';

  @override
  String get presetForestDesc => 'Salvia y esmeralda';

  @override
  String get presetTerracotta => 'Terracota';

  @override
  String get presetTerracottaDesc => 'Naranja cálido';

  @override
  String get presetPlum => 'Ciruela';

  @override
  String get presetPlumDesc => 'Violeta suave';

  @override
  String get presetMonochrome => 'Monocromo';

  @override
  String get presetMonochromeDesc => 'Carbón y negro';

  @override
  String get previewActiveTask => 'Revisar diseño de interfaz';

  @override
  String get previewCompletedTask => 'Sincronizar agenda semanal';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get deviceLanguageOption =>
      'Idioma del dispositivo (si es compatible)';

  @override
  String get appLockTitle => 'Bloqueo de app';

  @override
  String get appLockSubtitle => 'Huella, rostro o PIN del dispositivo';

  @override
  String get appLockLockedTitle => 'Zettask bloqueada';

  @override
  String get appLockLockedSubtitle =>
      'Usa tu huella, rostro o PIN del dispositivo para continuar.';

  @override
  String get unlockButton => 'Desbloquear';

  @override
  String get verifyingButton => 'Verificando...';

  @override
  String get appLockUnsupportedError =>
      'Este dispositivo no tiene biometría ni PIN activado.';

  @override
  String get appLockCancelledError => 'Verificación cancelada o fallida.';

  @override
  String get appLockUnlockFailedError =>
      'Autenticación fallida. Toca Desbloquear para reintentar.';

  @override
  String get calendarSyncTitle => 'Sincronización de calendario';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return 'Activa · $count calendarios';
  }

  @override
  String get calendarSyncInactiveSubtitle =>
      'Desactivada · muestra eventos en solo lectura';

  @override
  String get grantCalendarPermission => 'Conceder permiso de calendario';

  @override
  String get exportCsvTitle => 'Exportar CSV';

  @override
  String get exportCsvSubtitle => 'Comparte tareas o notas en CSV';

  @override
  String get exportDataCsvTitle => 'Exportar datos CSV';

  @override
  String get exportTasksTitle => 'Exportar tareas';

  @override
  String get exportTasksSubtitle =>
      'Todas las tareas programadas, sin fecha y de proyectos';

  @override
  String get exportNotesTitle => 'Exportar notas';

  @override
  String get exportNotesSubtitle => 'Todas las notas rápidas';

  @override
  String get exportBothTitle => 'Exportar ambos';

  @override
  String get exportBothSubtitle => 'Archivos CSV de tareas y notas juntos';

  @override
  String get aboutPrivacyTitle => 'Acerca de y Privacidad';

  @override
  String aboutPrivacySubtitle(String version) {
    return 'Versión $version · Local primero y nube opcional';
  }

  @override
  String get aboutTitle => 'Acerca de Zettask';

  @override
  String versionLabel(String version) {
    return 'Versión $version';
  }

  @override
  String get privacySyncTitle => 'Privacidad y sincronización';

  @override
  String get privacySyncDescription =>
      'Por defecto tus datos permanecen en el dispositivo. La sincronización con Firebase es opcional al iniciar sesión y puedes eliminar tu cuenta y datos en la nube en cualquier momento.';

  @override
  String get privacyPolicyLabel => 'Política de privacidad';

  @override
  String get privacyLinkCopied => 'Enlace de Política de privacidad copiado';

  @override
  String get accountAndSyncTitle => 'Cuenta y sincronización';

  @override
  String get signInToZettask => 'Iniciar sesión en Zettask';

  @override
  String get accountBannerSubtitle =>
      'Opcional · respalda y sincroniza en la nube';

  @override
  String get authWelcomeTitle => 'Guarda tu progreso y tareas';

  @override
  String get authWelcomeSubtitle =>
      'Respalda agendas, proyectos y notas automáticamente en la nube. También puedes usar Zettask localmente sin cuenta.';

  @override
  String get createNewAccount => 'Crear cuenta nueva';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get authTermsNotice =>
      'Al continuar, aceptas los Términos y la Política de privacidad de Zettask.';

  @override
  String get signInToAccountTitle => 'Iniciar sesión en Zettask';

  @override
  String get signInToAccountSubtitle =>
      'Los datos locales se combinarán con tu copia en la nube.';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get emailHint => 'nombre@correo.com';

  @override
  String get emailRequired => 'El correo es obligatorio.';

  @override
  String get emailInvalid => 'Formato de correo no válido.';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get passwordHint => 'Introduce tu contraseña';

  @override
  String get passwordNewHint => 'Mínimo 6 caracteres';

  @override
  String get passwordRequired => 'La contraseña es obligatoria.';

  @override
  String get passwordTooShort =>
      'La contraseña debe tener al menos 6 caracteres.';

  @override
  String get forgotPassword => '¿Olvidaste?';

  @override
  String get enterValidEmailFirst => 'Introduce primero un correo válido.';

  @override
  String passwordResetSent(String email) {
    return 'Enlace de recuperación enviado a $email.';
  }

  @override
  String get showPasswordTooltip => 'Mostrar contraseña';

  @override
  String get hidePasswordTooltip => 'Ocultar contraseña';

  @override
  String get noAccountPrompt => '¿No tienes cuenta?';

  @override
  String get createAccountLink => 'Crear cuenta';

  @override
  String get createAccountTitle => 'Crear cuenta';

  @override
  String get createAccountSubtitle =>
      'Respalda todas tus tareas, rutinas y notas en la nube.';

  @override
  String get haveAccountPrompt => '¿Ya tienes cuenta?';

  @override
  String signedInVia(String provider) {
    return 'Conectado con $provider';
  }

  @override
  String get syncNowButton => 'Sincronizar ahora';

  @override
  String get syncingLabel => 'Sincronizando...';

  @override
  String get syncDoneMessage => 'Sincronización completada.';

  @override
  String get syncFailedMessage =>
      'Error al sincronizar. Comprueba tu conexión.';

  @override
  String get syncStatusIdle => 'Sin sincronizar aún';

  @override
  String get syncStatusSyncing => 'Sincronizando...';

  @override
  String get syncStatusSynced => 'Sincronizado';

  @override
  String get syncStatusError => 'Error de sincronización';

  @override
  String lastSyncedPrefix(String time) {
    return 'Última: $time';
  }

  @override
  String get neverSynced => 'Nunca sincronizado';

  @override
  String get signOutButton => 'Cerrar sesión';

  @override
  String get signedOutMessage =>
      'Sesión cerrada. Los datos locales siguen en tu dispositivo.';

  @override
  String get deleteAccountButton => 'Eliminar cuenta';

  @override
  String get deleteAccountStep1Title => '¿Eliminar cuenta?';

  @override
  String get deleteAccountStep1Body =>
      'Todas las copias en la nube y tu cuenta se eliminarán permanentemente. Los datos locales del dispositivo permanecen intactos.';

  @override
  String get deleteAccountStep2Title => 'Confirmar eliminación permanente';

  @override
  String get deleteAccountStep2Body =>
      'Esta acción no se puede deshacer. ¿Eliminar tu cuenta y datos en la nube permanentemente ahora?';

  @override
  String get deleteAccountConfirmButton => 'Sí, eliminar permanentemente';

  @override
  String get accountDeletedMessage =>
      'Cuenta y datos en la nube eliminados permanentemente.';

  @override
  String get reloginRequiredTitle => 'Inicia sesión de nuevo';

  @override
  String get authErrUserNotFound => 'No existe ninguna cuenta con este correo.';

  @override
  String get authErrWrongPassword => 'Contraseña incorrecta.';

  @override
  String get authErrInvalidCredential => 'Correo o contraseña no válidos.';

  @override
  String get authErrInvalidEmail => 'Formato de correo no válido.';

  @override
  String get authErrEmailInUse => 'Este correo ya está registrado.';

  @override
  String get authErrWeakPassword =>
      'Contraseña débil. Usa al menos 6 caracteres.';

  @override
  String get authErrNetwork => 'Error de red. Revisa tu conexión a internet.';

  @override
  String get authErrRequiresRecentLogin =>
      'Por seguridad, cierra sesión y vuelve a entrar antes de eliminar tu cuenta.';

  @override
  String get authErrTooManyRequests =>
      'Demasiados intentos. Inténtalo más tarde.';

  @override
  String get authErrUserDisabled => 'Esta cuenta está desactivada.';

  @override
  String get authErrAccountExistsDifferent =>
      'Este correo ya está vinculado a otro método de acceso.';

  @override
  String get authErrOperationNotAllowed =>
      'Este método de acceso no está habilitado.';

  @override
  String get authErrFirebaseUnavailable => 'Servicio de cuentas no disponible.';

  @override
  String get authErrUnknown => 'Error de autenticación. Inténtalo de nuevo.';

  @override
  String get widgetTitle => 'Zettask · Hoy';

  @override
  String get widgetEmptyText => 'Todas las tareas de hoy están listas.';

  @override
  String get repeatingTasksAndFollowingDeleted =>
      'Tarea recurrente y siguientes eliminadas';

  @override
  String get noProjectTasksTitle => 'Aún no hay tareas en este proyecto';

  @override
  String noProjectTasksSubtitle(String project) {
    return 'Toca + para añadir una tarea a $project.';
  }

  @override
  String get addTaskToProjectTooltip => 'Añadir tarea al proyecto';

  @override
  String get noTagsSubtitle =>
      'Toca + para crear etiquetas de color para tareas y notas.';

  @override
  String get tagOptionsTooltip => 'Opciones de etiqueta';

  @override
  String get deleteTag => 'Eliminar etiqueta';

  @override
  String get addTagTooltip => 'Añadir etiqueta';

  @override
  String get noTasksWithTag => 'Aún no hay tareas con esta etiqueta.';

  @override
  String get addTaskWithTagTooltip => 'Añadir tarea con etiqueta';

  @override
  String get tagNameHint => 'ej. Trabajo, Personal, Urgente';

  @override
  String get tagColorLabel => 'Color de etiqueta';

  @override
  String get createTag => 'Crear etiqueta';

  @override
  String tagDeletedNamed(String name) {
    return 'Etiqueta \"$name\" eliminada';
  }

  @override
  String get noTemplatesSubtitle =>
      'Guarda estructuras de tareas y listas frecuentes para crearlas más rápido.';

  @override
  String get templateOptionsTooltip => 'Opciones de plantilla';

  @override
  String get deleteTemplate => 'Eliminar plantilla';

  @override
  String get createTemplateTooltip => 'Crear plantilla';

  @override
  String templateDeletedNamed(String name) {
    return 'Plantilla \"$name\" eliminada';
  }

  @override
  String get templateNameHint => 'ej. Lanzamiento semanal';

  @override
  String get defaultTaskTitleLabel => 'Título de tarea predeterminado';

  @override
  String get defaultTaskTitleHint => 'ej. Preparar lanzamiento';

  @override
  String get timeOptionalLabel => 'Hora (opcional)';

  @override
  String get clearTimeTooltip => 'Quitar hora';

  @override
  String get projectOptionalLabel => 'Proyecto (opcional)';

  @override
  String get tagOptionalLabel => 'Etiqueta (opcional)';

  @override
  String get defaultSubtasksLabel => 'Subtareas predeterminadas';

  @override
  String get addTemplateSubtaskHint => 'Añadir subtarea a la plantilla...';

  @override
  String get saveTemplate => 'Guardar plantilla';

  @override
  String subtasksTotalCount(int count) {
    return '$count subtareas';
  }

  @override
  String get useTemplateButton => 'Usar plantilla';

  @override
  String get pickTemplateTitle => 'Elegir plantilla';

  @override
  String get repeatingTaskDeleted => 'Tarea recurrente eliminada';

  @override
  String get noRepeatingTasksSubtitle =>
      'Toca + para crear rutinas diarias, semanales o mensuales.';

  @override
  String get addRepeatingTaskTooltip => 'Añadir tarea recurrente';

  @override
  String get editRepeatingTask => 'Editar tarea recurrente';

  @override
  String get newRepeatingTask => 'Nueva tarea recurrente';

  @override
  String get deleteTaskTooltip => 'Eliminar tarea';

  @override
  String get scheduleLabel => 'Horario';

  @override
  String get startAndTimeLabel => 'Inicio y hora';

  @override
  String get dateRequiredForTime => 'Requiere fecha';

  @override
  String get clearDateTooltip => 'Quitar fecha';

  @override
  String get pickTimeFirstReminder =>
      'Elige una hora primero para activar recordatorios.';

  @override
  String get notificationPermissionDenied =>
      'El permiso de notificaciones está desactivado. Actívalo en ajustes del dispositivo.';

  @override
  String get pickDateFirstRepeat =>
      'Elige una fecha primero para configurar la repetición.';

  @override
  String get subtasksLabel => 'Subtareas';

  @override
  String subtasksWithCount(int count) {
    return 'Subtareas ($count)';
  }

  @override
  String get removeSubtaskTooltip => 'Quitar subtarea';

  @override
  String get addSubtaskTooltip => 'Añadir subtarea';

  @override
  String get moveAllOverdueMoved => 'Todas las tareas vencidas movidas a hoy';

  @override
  String get moveAllShort => 'Mover todo';

  @override
  String get noOverdueTasksSubtitle =>
      'Todas las tareas de días anteriores están completadas.';

  @override
  String get repeatingDeletePrompt => '¿Qué deseas eliminar?';

  @override
  String get repeatingEditPrompt => '¿Qué deseas cambiar?';

  @override
  String get repeatingDeleteSingleSub => 'Eliminar solo esta vez';

  @override
  String get repeatingEditSingleSub => 'Cambiar solo esta vez';

  @override
  String get repeatingDeleteFollowingSub =>
      'Eliminar esta y todas las siguientes';

  @override
  String get repeatingEditFollowingSub =>
      'Aplicar a esta y todas las siguientes';

  @override
  String get deviceCalendarTitle => 'Calendario del dispositivo';

  @override
  String get selectCalendarsLabel => 'Seleccionar calendarios';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '$selected/$total activos';
  }

  @override
  String get showCalendarEventsTitle => 'Mostrar eventos del calendario';

  @override
  String get showCalendarEventsSubtitle =>
      'Los eventos del dispositivo aparecen en orden cronológico solo lectura.';

  @override
  String get calendarPermDeniedPermanentTitle =>
      'Permiso de calendario denegado permanentemente';

  @override
  String get calendarPermRequiredTitle =>
      'Se requiere permiso de lectura del calendario';

  @override
  String get calendarPermDeniedPermanentDesc =>
      'Activa el permiso de lectura del calendario en Ajustes y toca Comprobar de nuevo.';

  @override
  String get calendarPermRequiredDesc =>
      'Zettask solo solicita permiso de lectura para mostrar tus eventos en el timeline.';

  @override
  String get openSettingsButton => 'Abrir ajustes';

  @override
  String get checkAgainButton => 'Comprobar de nuevo';

  @override
  String get noCalendarsFound =>
      'No se encontraron calendarios en este dispositivo.';

  @override
  String get eventDetailTitle => 'Detalles del evento';

  @override
  String get eventNotesLabel => 'Notas';

  @override
  String get calendarEventReadOnlyBanner =>
      'Evento del calendario del dispositivo (solo lectura).';

  @override
  String get markUncompletedSemantics => 'Marcar pendiente';

  @override
  String get markCompletedSemantics => 'Marcar completada';

  @override
  String get deleteNoteTooltip => 'Eliminar nota';

  @override
  String repeatMonthlyDay(int day) {
    return 'Cada mes · día $day';
  }

  @override
  String get last30DaysSubtitle => 'Últimos 30 días';

  @override
  String get allTimeSubtitle => 'Todo el tiempo';

  @override
  String get taskCancelled => 'Tarea marcada como cancelada';

  @override
  String get taskRestored => 'Tarea reactivada';

  @override
  String get cancelledStatusLabel => 'Cancelada';

  @override
  String get restoreTaskLabel => 'Reactivar';

  @override
  String get markCancelledSemantics => 'Marcar cancelada';

  @override
  String get calendarPermFallbackHint =>
      'Si no aparece el aviso de permiso, abre los Ajustes de la app para activar el acceso al Calendario manualmente.';

  @override
  String get calendarBadgeLabel => 'Calendario';

  @override
  String get calendarSourceLabel => 'Calendario';

  @override
  String get calendarLocationLabel => 'Ubicación';

  @override
  String get calendarReadOnlyInfo =>
      'Sincronizado desde el calendario del dispositivo. Este elemento es de solo lectura y no se puede editar en Zettask.';

  @override
  String get proBrandTitle => 'Zettask Pro';

  @override
  String get proBadge => 'PRO';

  @override
  String get proPaywallSubtitle =>
      'Sincronización en la nube, calendarios, bloqueo biométrico y temas OLED.';

  @override
  String proActiveBannerTitle(String plan) {
    return 'Activo — $plan';
  }

  @override
  String get proActiveBannerSubtitle => 'Gracias por apoyar a Zettask.';

  @override
  String get proUpgradeBannerSubtitle =>
      'Tema AMOLED, acentos personalizados, estilos de widget y más';

  @override
  String get proBenefitCloudSync =>
      'Sincronización en la nube y multidispositivo';

  @override
  String get proBenefitCalendar => 'Integración de calendario y festivos';

  @override
  String get proBenefitAppLock =>
      'Bloqueo biométrico y privacidad en apps recientes';

  @override
  String get proBenefitProjectsCsv => 'Proyectos ilimitados y exportación CSV';

  @override
  String get proBenefitCustomization =>
      'AMOLED negro puro, colores de acento y estilos de widget';

  @override
  String get proPlanMonthlyTitle => 'Mensual';

  @override
  String get proPlanMonthlyPrice => '\$1.99 / mes';

  @override
  String get proPlanYearlyTitle => 'Anual';

  @override
  String get proPlanYearlyPrice => '\$12.99 / año';

  @override
  String get proPlanYearlyBadge => 'Mejor valor';

  @override
  String get proPlanYearlySavings => 'Ahorra ~43%';

  @override
  String get proPlanLifetimeTitle => 'De por vida';

  @override
  String get proPlanLifetimePrice => '\$29.99';

  @override
  String get proPlanLifetimeBadge => 'Pago único';

  @override
  String get proContinueButton => 'Continuar';

  @override
  String get proAlreadyActiveButton => 'Zettask Pro activo';

  @override
  String get proRestorePurchasesButton => 'Restaurar compras';

  @override
  String get proLegalFootnote =>
      'Las suscripciones se renuevan automáticamente salvo cancelación. Cancela en cualquier momento en Google Play.';

  @override
  String get proStoreUnavailableMessage =>
      'La facturación de Google Play aún no está disponible en este dispositivo. Inténtalo más tarde.';

  @override
  String get proPurchaseSuccessMessage => 'Zettask Pro ya está activo.';

  @override
  String get proRestoreSuccessMessage =>
      'Tu compra de Zettask Pro ha sido restaurada.';

  @override
  String get proRestoreEmptyMessage =>
      'No se encontró ninguna compra activa de Zettask Pro en esta cuenta.';

  @override
  String get proPurchaseFailedMessage =>
      'No se pudo completar la compra ahora. Inténtalo de nuevo.';

  @override
  String get debugProSimulationLabel => 'Modo desarrollador: Simulación Pro';

  @override
  String get amoledPureBlackTitle => 'AMOLED Negro Puro';

  @override
  String get amoledPureBlackSubtitle =>
      'Fondo oscuro #000000 puro para pantallas OLED';

  @override
  String get customAccentSection => 'Color de acento personalizado';

  @override
  String get accentMonochrome => 'Monocromo';

  @override
  String get accentSage => 'Salvia';

  @override
  String get accentIndigo => 'Índigo';

  @override
  String get accentTerracotta => 'Terracota';

  @override
  String get accentAmber => 'Ámbar';

  @override
  String get widgetStyleSection => 'Estilo del widget de inicio';

  @override
  String get widgetStyleStandard => 'Estándar';

  @override
  String get widgetStyleAmoled => 'AMOLED';

  @override
  String get widgetStyleTranslucent => 'Translúcido';

  @override
  String get proContextUnlimitedProjects =>
      'El plan gratuito permite hasta 3 proyectos. Mejora a Zettask Pro para proyectos ilimitados.';

  @override
  String get proContextCalendarSync =>
      'La sincronización del calendario y festivos está incluida en Zettask Pro.';

  @override
  String get proContextAppLock =>
      'El bloqueo biométrico y la privacidad en apps recientes están incluidos en Zettask Pro.';

  @override
  String get proContextCsvExport =>
      'La exportación de tareas y notas a CSV está incluida en Zettask Pro.';

  @override
  String get proContextCloudSync =>
      'La sincronización en la nube entre dispositivos está incluida en Zettask Pro.';

  @override
  String get proContextCustomThemes =>
      'AMOLED negro puro y colores de acento personalizados están incluidos en Zettask Pro.';

  @override
  String get proContextWidgetStyles =>
      'Los estilos de widget AMOLED y translúcido están incluidos en Zettask Pro.';

  @override
  String get cloudSyncPausedShort =>
      'Sincronización pausada · Datos locales seguros';

  @override
  String get cloudSyncPausedTitle => 'Sincronización en la nube pausada';

  @override
  String get cloudSyncPausedBody =>
      'Tu suscripción Zettask Pro está inactiva. Tus tareas y notas locales siguen seguras en este dispositivo.';

  @override
  String get resumeSyncWithProButton => 'Reanudar sincronización con Pro';
}
