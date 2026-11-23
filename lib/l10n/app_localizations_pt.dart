// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => 'Linha do tempo';

  @override
  String get navBoard => 'Quadro';

  @override
  String get navUnplanned => 'Sem data';

  @override
  String get navMore => 'Mais';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get close => 'Fechar';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit => 'Editar';

  @override
  String get undo => 'Anular';

  @override
  String get back => 'Voltar';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get clear => 'Limpar';

  @override
  String get all => 'Todos';

  @override
  String get or => 'ou';

  @override
  String get continueAction => 'Continuar';

  @override
  String get understand => 'Entendido';

  @override
  String get useAction => 'Usar';

  @override
  String get today => 'Hoje';

  @override
  String get tomorrow => 'Amanhã';

  @override
  String get yesterday => 'Ontem';

  @override
  String get toDo => 'Por fazer';

  @override
  String get overdue => 'Em atraso';

  @override
  String get unplanned => 'Sem data';

  @override
  String get allDay => 'Todo o dia';

  @override
  String get scheduled => 'Agendadas';

  @override
  String get addTaskToday => 'Adicionar tarefa para hoje';

  @override
  String get addTask => 'Adicionar tarefa';

  @override
  String get noTasksForDate => 'Sem tarefas para esta data.';

  @override
  String get savedToUnplanned => 'Guardada em Sem data';

  @override
  String get savedToUnplannedNoDate => 'Guardada em Sem data (sem data)';

  @override
  String scheduledForDate(String date) {
    return 'Agendada para $date';
  }

  @override
  String taskScheduledForDate(String date) {
    return 'Tarefa agendada para $date';
  }

  @override
  String get taskDeleted => 'Tarefa eliminada';

  @override
  String get searchTasksTooltip => 'Pesquisar tarefas';

  @override
  String get timelineOptionsTooltip => 'Opções da linha do tempo';

  @override
  String get addTaskTooltip => 'Adicionar tarefa';

  @override
  String get completedLabel => 'Concluída';

  @override
  String get uncompleteLabel => 'Marcar ativa';

  @override
  String subtasksCount(int done, int total) {
    return '$done/$total subtarefas';
  }

  @override
  String get repeatingTaskLabel => 'Tarefa recorrente';

  @override
  String get quickAddHint => 'Adicionar nova tarefa...';

  @override
  String get expandTooltip => 'Expandir';

  @override
  String get saveTaskTooltip => 'Guardar tarefa';

  @override
  String get newTask => 'Nova tarefa';

  @override
  String get editTask => 'Editar tarefa';

  @override
  String get taskTitleLabel => 'Título da tarefa';

  @override
  String get taskTitleHint => 'Ex.: Rever notas do sprint';

  @override
  String get taskTitleRequired => 'O título é obrigatório';

  @override
  String get descriptionLabel => 'Descrição';

  @override
  String get descriptionHint => 'Adicionar notas ou contexto...';

  @override
  String get pickDate => 'Escolher data';

  @override
  String get pickOnCalendar => 'Escolher no calendário...';

  @override
  String get noDateUnplanned => 'Sem data (Não planeada)';

  @override
  String get noDate => 'Sem data';

  @override
  String get taskTime => 'Hora da tarefa';

  @override
  String get changeTime => 'Alterar hora';

  @override
  String get clearTimeAllDay => 'Remover hora (Todo o dia)';

  @override
  String get timeLabel => 'Hora';

  @override
  String get reminderLabel => 'Lembrete';

  @override
  String get noReminder => 'Sem lembrete';

  @override
  String get atTime => 'À hora';

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
  String get projectLabel => 'Projeto';

  @override
  String get noProject => 'Sem projeto';

  @override
  String get tagLabel => 'Etiqueta';

  @override
  String get noTag => 'Sem etiqueta';

  @override
  String get priorityLabel => 'Prioridade';

  @override
  String get priorityLow => 'Baixa';

  @override
  String get priorityMedium => 'Média';

  @override
  String get priorityHigh => 'Alta';

  @override
  String get saveTask => 'Guardar tarefa';

  @override
  String get saveChanges => 'Guardar alterações';

  @override
  String get checklistLabel => 'Lista de verificação';

  @override
  String get addChecklistHint => 'Adicionar item...';

  @override
  String get repeatLabel => 'Repetição';

  @override
  String get noRepeat => 'Sem repetição';

  @override
  String get repeatDaily => 'Todos os dias';

  @override
  String get repeatWeekly => 'Todas as semanas';

  @override
  String get repeatMonthly => 'Todos os meses';

  @override
  String get colorLabel => 'Cor';

  @override
  String get timelineOptionsTitle => 'Opções da linha do tempo';

  @override
  String get viewModeLabel => 'Modo de vista';

  @override
  String get modeTimeline => 'Modo Linha do tempo';

  @override
  String get modeDaily => 'Modo Diário';

  @override
  String get firstDayOfWeek => 'Início da semana';

  @override
  String get monday => 'Segunda-feira';

  @override
  String get sunday => 'Domingo';

  @override
  String get firstDayMondayOrder => 'Seg · Ter · Qua · Qui · Sex · Sáb · Dom';

  @override
  String get firstDaySundayOrder => 'Dom · Seg · Ter · Qua · Qui · Sex · Sáb';

  @override
  String get showCompletedTasks => 'Mostrar tarefas concluídas';

  @override
  String get showCompletedTasksSubtitle =>
      'Oculte tarefas concluídas para manter o foco.';

  @override
  String get showCompletedWorkspaceSubtitle =>
      'Mostrar ou ocultar tarefas concluídas.';

  @override
  String get overdueTasksTitle => 'Tarefas em atraso';

  @override
  String get noOverdueTasks => 'Sem tarefas em atraso';

  @override
  String get moveToToday => 'Mover para Hoje';

  @override
  String get moveAllToToday => 'Mover todas para Hoje';

  @override
  String get searchTasksHint => 'Pesquisar tarefas...';

  @override
  String get searchTasksEmpty =>
      'Escreva para pesquisar tarefas, descrições ou listas.';

  @override
  String searchNoResults(String query) {
    return 'Nenhuma tarefa corresponde a \"$query\".';
  }

  @override
  String get calendarEventReadOnly => 'Evento do calendário · só leitura';

  @override
  String get prevWeekTooltip => 'Semana anterior';

  @override
  String get nextWeekTooltip => 'Semana seguinte';

  @override
  String get boardTitle => 'Quadro';

  @override
  String get allProjects => 'Todos os projetos';

  @override
  String get searchProjectHint => 'Pesquisar projeto...';

  @override
  String get searchProjectTooltip => 'Pesquisar projetos';

  @override
  String get closeSearchTooltip => 'Fechar pesquisa';

  @override
  String get createProject => 'Criar projeto';

  @override
  String get editProject => 'Editar projeto';

  @override
  String get deleteProject => 'Eliminar projeto';

  @override
  String get projectOptionsTooltip => 'Opções do projeto';

  @override
  String projectDeleted(String name) {
    return 'Projeto \"$name\" eliminado';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return '$done/$total concluídas';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return '$done/$total tarefas concluídas';
  }

  @override
  String get projectNotFound => 'Projeto não encontrado';

  @override
  String get noProjectsYet => 'Ainda sem projetos';

  @override
  String projectSearchEmpty(String query) {
    return 'Nenhum projeto corresponde a \"$query\".';
  }

  @override
  String get noProjectsSubtitle =>
      'Toque na pasta abaixo para criar o primeiro projeto.';

  @override
  String get newProject => 'Novo projeto';

  @override
  String get projectNameLabel => 'Nome do projeto';

  @override
  String get projectNameHint => 'Ex.: Lançamento Zettask';

  @override
  String get projectNameRequired => 'O nome do projeto é obrigatório';

  @override
  String get projectColorLabel => 'Cor do projeto';

  @override
  String get unplannedTitle => 'Sem data';

  @override
  String activeCountLabel(int count) {
    return '$count ativas';
  }

  @override
  String get noUnplannedTitle => 'Sem tarefas sem data';

  @override
  String get noUnplannedSubtitle =>
      'Toque em + para registar uma tarefa sem data.';

  @override
  String get addUnplannedTooltip => 'Adicionar tarefa sem data';

  @override
  String get workspaceTitle => 'Espaço de trabalho';

  @override
  String get organizeSection => 'Organizar';

  @override
  String get automationSection => 'Automatização';

  @override
  String get insightsSection => 'Estatísticas e tema';

  @override
  String get settingsInfoSection => 'Definições e info';

  @override
  String get tagsTitle => 'Etiquetas';

  @override
  String get tagsSubtitleEmpty => 'Etiquetas de cor para tarefas e notas';

  @override
  String tagsCountSubtitle(int count) {
    return '$count etiquetas guardadas';
  }

  @override
  String get newTag => 'Nova etiqueta';

  @override
  String get editTag => 'Editar etiqueta';

  @override
  String get tagNameLabel => 'Nome da etiqueta';

  @override
  String get tagNameRequired => 'O nome da etiqueta é obrigatório';

  @override
  String get tagDeleted => 'Etiqueta eliminada';

  @override
  String get noTagsYet => 'Ainda sem etiquetas';

  @override
  String tagTasksCount(int count) {
    return '$count tarefas';
  }

  @override
  String get templatesTitle => 'Modelos';

  @override
  String get templatesSubtitleEmpty =>
      'Guarde estruturas de tarefas reutilizáveis';

  @override
  String templatesCountSubtitle(int count) {
    return '$count modelos prontos';
  }

  @override
  String get newTemplate => 'Novo modelo';

  @override
  String get editTemplate => 'Editar modelo';

  @override
  String get templateNameLabel => 'Nome do modelo';

  @override
  String get templateNameRequired => 'O nome do modelo é obrigatório';

  @override
  String get templateDeleted => 'Modelo eliminado';

  @override
  String get noTemplatesYet => 'Ainda sem modelos';

  @override
  String get taskFromTemplateSaved => 'Tarefa guardada a partir do modelo';

  @override
  String get notesTitle => 'Notas';

  @override
  String get notesSubtitleEmpty => 'Notas rápidas sem data';

  @override
  String notesCountSubtitle(int count) {
    return '$count notas guardadas';
  }

  @override
  String get newNote => 'Nova nota';

  @override
  String get editNote => 'Editar nota';

  @override
  String get noteTitleLabel => 'Título da nota';

  @override
  String get noteTitleHint => 'Ex.: Resumo da reunião';

  @override
  String get noteTitleRequired => 'O título é obrigatório';

  @override
  String get noteContentLabel => 'Conteúdo';

  @override
  String get noteContentHint => 'Escreva a sua nota aqui...';

  @override
  String get noteDeleted => 'Nota eliminada';

  @override
  String get searchNotesHint => 'Pesquisar notas...';

  @override
  String get noteNotFound => 'Nota não encontrada';

  @override
  String get noNotesYet => 'Ainda sem notas';

  @override
  String noteSearchEmpty(String query) {
    return 'Nenhuma nota corresponde a \"$query\".';
  }

  @override
  String get noNotesSubtitle => 'Toque em + para escrever uma nota rápida.';

  @override
  String get saveNote => 'Guardar nota';

  @override
  String get repeatingTasksTitle => 'Tarefas recorrentes';

  @override
  String get repeatingTasksSubtitleEmpty =>
      'Gira rotinas diárias, semanais e mensais';

  @override
  String repeatingActiveCount(int count) {
    return '$count rotinas ativas';
  }

  @override
  String get noRepeatingTasks => 'Sem tarefas recorrentes';

  @override
  String get repeatingActionTitle => 'Esta é uma tarefa recorrente';

  @override
  String get repeatingThisOnly => 'Apenas esta tarefa';

  @override
  String get repeatingThisAndFollowing => 'Esta e todas as seguintes';

  @override
  String get last7DaysUpper => 'ÚLTIMOS 7 DIAS';

  @override
  String weeklySummary(int tasks, int checklists) {
    return '$tasks tarefas, mais $checklists itens de lista';
  }

  @override
  String get statsTitle => 'Estatísticas';

  @override
  String get range7Days => '7 dias';

  @override
  String get range30Days => '30 dias';

  @override
  String get completedToday => 'Feitas hoje';

  @override
  String get last7DaysLabel => 'Últimos 7 dias';

  @override
  String get last30DaysLabel => 'Últimos 30 dias';

  @override
  String get allTimeLabel => 'Desde sempre';

  @override
  String get completionRateLabel => 'Taxa de conclusão';

  @override
  String get activity7Days => 'Atividade dos últimos 7 dias';

  @override
  String get activity30Days => 'Atividade dos últimos 30 dias';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks tarefas · $checklists itens';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return 'Total $days dias: $tasks tarefas e $checklists itens';
  }

  @override
  String get completedByPriority => 'Concluídas por prioridade';

  @override
  String get progressByProject => 'Progresso por projeto';

  @override
  String get breakdownByTag => 'Detalhes por etiqueta';

  @override
  String get habits30Days => 'Hábitos · 30 dias';

  @override
  String get noProjectsCreated => 'Ainda não existem projetos.';

  @override
  String get noTagsCreated => 'Ainda não existem etiquetas.';

  @override
  String get noActiveHabits => 'Sem rotinas ativas.';

  @override
  String completedCountLabel(int count) {
    return '$count concluídas';
  }

  @override
  String tagBreakdownTrailing(int done, int total) {
    return '$done/$total concluídas';
  }

  @override
  String habitCompletedRatio(String summary, int done, int scheduled) {
    return '$summary · $done/$scheduled concluídas';
  }

  @override
  String statsSubtitle(int completed, int percent) {
    return '$completed concluídas · $percent% taxa';
  }

  @override
  String get themeTitle => 'Tema';

  @override
  String get themeAndColorsTitle => 'Tema e cores';

  @override
  String get livePreviewSection => 'Pré-visualização';

  @override
  String get appearanceModeSection => 'Aspeto';

  @override
  String get colorPaletteSection => 'Paleta de cores';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeSystemLight => 'Sistema (Claro)';

  @override
  String get themeSystemDark => 'Sistema (Escuro)';

  @override
  String get presetDefault => 'Predefinido';

  @override
  String get presetDefaultDesc => 'Índigo e ardósia';

  @override
  String get presetOcean => 'Oceano';

  @override
  String get presetOceanDesc => 'Azul sereno';

  @override
  String get presetForest => 'Floresta';

  @override
  String get presetForestDesc => 'Sálvia e esmeralda';

  @override
  String get presetTerracotta => 'Terracota';

  @override
  String get presetTerracottaDesc => 'Laranja quente';

  @override
  String get presetPlum => 'Ameixa';

  @override
  String get presetPlumDesc => 'Roxo suave';

  @override
  String get presetMonochrome => 'Monocromático';

  @override
  String get presetMonochromeDesc => 'Carvão e preto';

  @override
  String get previewActiveTask => 'Rever design da interface';

  @override
  String get previewCompletedTask => 'Sincronizar agenda semanal';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get deviceLanguageOption => 'Idioma do dispositivo (se suportado)';

  @override
  String get appLockTitle => 'Bloqueio da app';

  @override
  String get appLockSubtitle => 'Impressão digital, rosto ou PIN';

  @override
  String get appLockLockedTitle => 'Zettask bloqueada';

  @override
  String get appLockLockedSubtitle =>
      'Use impressão digital, rosto ou PIN do dispositivo para continuar.';

  @override
  String get unlockButton => 'Desbloquear';

  @override
  String get verifyingButton => 'A verificar...';

  @override
  String get appLockUnsupportedError =>
      'Este dispositivo não tem biometria nem PIN ativo.';

  @override
  String get appLockCancelledError => 'Verificação cancelada ou falhada.';

  @override
  String get appLockUnlockFailedError =>
      'Autenticação falhada. Toque em Desbloquear.';

  @override
  String get calendarSyncTitle => 'Sincronização do calendário';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return 'Ativa · $count calendários';
  }

  @override
  String get calendarSyncInactiveSubtitle =>
      'Desativada · eventos só de leitura';

  @override
  String get grantCalendarPermission => 'Permitir acesso ao calendário';

  @override
  String get exportCsvTitle => 'Exportar CSV';

  @override
  String get exportCsvSubtitle => 'Partilhar tarefas ou notas em CSV';

  @override
  String get exportDataCsvTitle => 'Exportar dados CSV';

  @override
  String get exportTasksTitle => 'Exportar tarefas';

  @override
  String get exportTasksSubtitle =>
      'Todas as tarefas agendadas, sem data e projetos';

  @override
  String get exportNotesTitle => 'Exportar notas';

  @override
  String get exportNotesSubtitle => 'Todas as notas rápidas';

  @override
  String get exportBothTitle => 'Exportar ambos';

  @override
  String get exportBothSubtitle => 'Ficheiros CSV de tarefas e notas juntos';

  @override
  String get aboutPrivacyTitle => 'Acerca e Privacidade';

  @override
  String aboutPrivacySubtitle(String version) {
    return 'Versão $version · Local primeiro e cloud opcional';
  }

  @override
  String get aboutTitle => 'Acerca do Zettask';

  @override
  String versionLabel(String version) {
    return 'Versão $version';
  }

  @override
  String get privacySyncTitle => 'Privacidade e sincronização';

  @override
  String get privacySyncDescription =>
      'Por predefinição os dados ficam no dispositivo. A sincronização Firebase é opcional ao iniciar sessão e pode eliminar permanentemente a conta e dados na cloud a qualquer momento.';

  @override
  String get privacyPolicyLabel => 'Política de privacidade';

  @override
  String get privacyLinkCopied => 'Ligação copiada';

  @override
  String get accountAndSyncTitle => 'Conta e sincronização';

  @override
  String get signInToZettask => 'Iniciar sessão no Zettask';

  @override
  String get accountBannerSubtitle => 'Opcional · cópia de segurança na cloud';

  @override
  String get authWelcomeTitle => 'Guarde o seu progresso e tarefas';

  @override
  String get authWelcomeSubtitle =>
      'Faça cópia automática de horários, projetos e notas na cloud. Pode continuar a usar o Zettask localmente sem conta.';

  @override
  String get createNewAccount => 'Criar nova conta';

  @override
  String get signIn => 'Iniciar sessão';

  @override
  String get continueWithGoogle => 'Continuar com o Google';

  @override
  String get authTermsNotice =>
      'Ao continuar, aceita os Termos e a Política de Privacidade do Zettask.';

  @override
  String get signInToAccountTitle => 'Iniciar sessão no Zettask';

  @override
  String get signInToAccountSubtitle =>
      'Os dados locais serão combinados com a cópia na cloud.';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailHint => 'nome@email.com';

  @override
  String get emailRequired => 'O e-mail é obrigatório.';

  @override
  String get emailInvalid => 'Formato de e-mail inválido.';

  @override
  String get passwordLabel => 'Palavra-passe';

  @override
  String get passwordHint => 'Introduza a palavra-passe';

  @override
  String get passwordNewHint => 'Mínimo 6 caracteres';

  @override
  String get passwordRequired => 'A palavra-passe é obrigatória.';

  @override
  String get passwordTooShort =>
      'A palavra-passe deve ter pelo menos 6 caracteres.';

  @override
  String get forgotPassword => 'Esqueceu?';

  @override
  String get enterValidEmailFirst => 'Introduza primeiro um e-mail válido.';

  @override
  String passwordResetSent(String email) {
    return 'Ligação de reposição enviada para $email.';
  }

  @override
  String get showPasswordTooltip => 'Mostrar palavra-passe';

  @override
  String get hidePasswordTooltip => 'Ocultar palavra-passe';

  @override
  String get noAccountPrompt => 'Não tem conta?';

  @override
  String get createAccountLink => 'Criar conta';

  @override
  String get createAccountTitle => 'Criar conta';

  @override
  String get createAccountSubtitle =>
      'Guarde todas as tarefas, rotinas e notas na cloud.';

  @override
  String get haveAccountPrompt => 'Já tem conta?';

  @override
  String signedInVia(String provider) {
    return 'Sessão via $provider';
  }

  @override
  String get syncNowButton => 'Sincronizar agora';

  @override
  String get syncingLabel => 'A sincronizar...';

  @override
  String get syncDoneMessage => 'Sincronização concluída.';

  @override
  String get syncFailedMessage => 'Falha ao sincronizar. Verifique a ligação.';

  @override
  String get syncStatusIdle => 'Ainda não sincronizado';

  @override
  String get syncStatusSyncing => 'A sincronizar...';

  @override
  String get syncStatusSynced => 'Sincronizado';

  @override
  String get syncStatusError => 'Erro na sincronização';

  @override
  String lastSyncedPrefix(String time) {
    return 'Última: $time';
  }

  @override
  String get neverSynced => 'Nunca sincronizado';

  @override
  String get signOutButton => 'Terminar sessão';

  @override
  String get signedOutMessage =>
      'Sessão terminada. Os dados locais mantêm-se no dispositivo.';

  @override
  String get deleteAccountButton => 'Eliminar conta';

  @override
  String get deleteAccountStep1Title => 'Eliminar conta?';

  @override
  String get deleteAccountStep1Body =>
      'Todas as cópias na cloud e a conta serão eliminadas permanentemente. Os dados locais permanecem no dispositivo.';

  @override
  String get deleteAccountStep2Title => 'Confirmar eliminação permanente';

  @override
  String get deleteAccountStep2Body =>
      'Esta ação não pode ser anulada. Eliminar definitivamente a conta e dados na cloud agora?';

  @override
  String get deleteAccountConfirmButton => 'Sim, eliminar permanentemente';

  @override
  String get accountDeletedMessage =>
      'Conta e dados na cloud eliminados permanentemente.';

  @override
  String get reloginRequiredTitle => 'Inicie sessão novamente';

  @override
  String get authErrUserNotFound => 'Nenhuma conta encontrada com este e-mail.';

  @override
  String get authErrWrongPassword => 'Palavra-passe incorreta.';

  @override
  String get authErrInvalidCredential => 'E-mail ou palavra-passe inválidos.';

  @override
  String get authErrInvalidEmail => 'Formato de e-mail inválido.';

  @override
  String get authErrEmailInUse => 'Este e-mail já está registado.';

  @override
  String get authErrWeakPassword =>
      'Palavra-passe fraca. Use pelo menos 6 caracteres.';

  @override
  String get authErrNetwork => 'Erro de rede. Verifique a ligação à internet.';

  @override
  String get authErrRequiresRecentLogin =>
      'Por segurança, termine sessão e volte a entrar antes de eliminar a conta.';

  @override
  String get authErrTooManyRequests =>
      'Demasiadas tentativas. Tente mais tarde.';

  @override
  String get authErrUserDisabled => 'Esta conta foi desativada.';

  @override
  String get authErrAccountExistsDifferent =>
      'Este e-mail está associado a outro método de acesso.';

  @override
  String get authErrOperationNotAllowed =>
      'Este método de acesso não está ativo.';

  @override
  String get authErrFirebaseUnavailable => 'Serviço de conta indisponível.';

  @override
  String get authErrUnknown => 'Erro de autenticação. Tente novamente.';

  @override
  String get widgetTitle => 'Zettask · Hoje';

  @override
  String get widgetEmptyText => 'Todas as tarefas de hoje estão concluídas.';

  @override
  String get repeatingTasksAndFollowingDeleted =>
      'Tarefa recorrente e seguintes eliminadas';

  @override
  String get noProjectTasksTitle => 'Ainda sem tarefas neste projeto';

  @override
  String noProjectTasksSubtitle(String project) {
    return 'Toque em + para adicionar uma tarefa a $project.';
  }

  @override
  String get addTaskToProjectTooltip => 'Adicionar tarefa ao projeto';

  @override
  String get noTagsSubtitle =>
      'Toque em + para criar etiquetas coloridas para tarefas e notas.';

  @override
  String get tagOptionsTooltip => 'Opções de etiqueta';

  @override
  String get deleteTag => 'Eliminar etiqueta';

  @override
  String get addTagTooltip => 'Adicionar etiqueta';

  @override
  String get noTasksWithTag => 'Ainda sem tarefas com esta etiqueta.';

  @override
  String get addTaskWithTagTooltip => 'Adicionar tarefa com etiqueta';

  @override
  String get tagNameHint => 'ex. Trabalho, Pessoal, Urgente';

  @override
  String get tagColorLabel => 'Cor da etiqueta';

  @override
  String get createTag => 'Criar etiqueta';

  @override
  String tagDeletedNamed(String name) {
    return 'Etiqueta \"$name\" eliminada';
  }

  @override
  String get noTemplatesSubtitle =>
      'Guarde estruturas de tarefas frequentes para criar mais depressa.';

  @override
  String get templateOptionsTooltip => 'Opções de modelo';

  @override
  String get deleteTemplate => 'Eliminar modelo';

  @override
  String get createTemplateTooltip => 'Criar modelo';

  @override
  String templateDeletedNamed(String name) {
    return 'Modelo \"$name\" eliminado';
  }

  @override
  String get templateNameHint => 'ex. Lançamento semanal';

  @override
  String get defaultTaskTitleLabel => 'Título da tarefa predefinido';

  @override
  String get defaultTaskTitleHint => 'ex. Preparar lançamento';

  @override
  String get timeOptionalLabel => 'Hora (opcional)';

  @override
  String get clearTimeTooltip => 'Limpar hora';

  @override
  String get projectOptionalLabel => 'Projeto (opcional)';

  @override
  String get tagOptionalLabel => 'Etiqueta (opcional)';

  @override
  String get defaultSubtasksLabel => 'Subtarefas predefinidas';

  @override
  String get addTemplateSubtaskHint => 'Adicionar subtarefa...';

  @override
  String get saveTemplate => 'Guardar modelo';

  @override
  String subtasksTotalCount(int count) {
    return '$count subtarefas';
  }

  @override
  String get useTemplateButton => 'Usar modelo';

  @override
  String get pickTemplateTitle => 'Escolher modelo';

  @override
  String get repeatingTaskDeleted => 'Tarefa recorrente eliminada';

  @override
  String get noRepeatingTasksSubtitle =>
      'Toque em + para criar rotinas diárias, semanais ou mensais.';

  @override
  String get addRepeatingTaskTooltip => 'Adicionar tarefa recorrente';

  @override
  String get editRepeatingTask => 'Editar tarefa recorrente';

  @override
  String get newRepeatingTask => 'Nova tarefa recorrente';

  @override
  String get deleteTaskTooltip => 'Eliminar tarefa';

  @override
  String get scheduleLabel => 'Agendamento';

  @override
  String get startAndTimeLabel => 'Início e hora';

  @override
  String get dateRequiredForTime => 'Requer data';

  @override
  String get clearDateTooltip => 'Limpar data';

  @override
  String get pickTimeFirstReminder =>
      'Escolha primeiro uma hora para ativar lembretes.';

  @override
  String get notificationPermissionDenied =>
      'Notificações desativadas. Ative nas definições do dispositivo.';

  @override
  String get pickDateFirstRepeat =>
      'Escolha primeiro uma data para configurar a repetição.';

  @override
  String get subtasksLabel => 'Subtarefas';

  @override
  String subtasksWithCount(int count) {
    return 'Subtarefas ($count)';
  }

  @override
  String get removeSubtaskTooltip => 'Remover subtarefa';

  @override
  String get addSubtaskTooltip => 'Adicionar subtarefa';

  @override
  String get moveAllOverdueMoved =>
      'Todas as tarefas atrasadas movidas para hoje';

  @override
  String get moveAllShort => 'Mover todas';

  @override
  String get noOverdueTasksSubtitle =>
      'Todas as tarefas de dias anteriores estão concluídas.';

  @override
  String get repeatingDeletePrompt => 'O que pretende eliminar?';

  @override
  String get repeatingEditPrompt => 'O que pretende alterar?';

  @override
  String get repeatingDeleteSingleSub => 'Eliminar apenas esta ocorrência';

  @override
  String get repeatingEditSingleSub => 'Alterar apenas esta ocorrência';

  @override
  String get repeatingDeleteFollowingSub =>
      'Eliminar esta e todas as seguintes';

  @override
  String get repeatingEditFollowingSub => 'Aplicar a esta e todas as seguintes';

  @override
  String get deviceCalendarTitle => 'Calendário do dispositivo';

  @override
  String get selectCalendarsLabel => 'Selecionar calendários';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '$selected/$total ativos';
  }

  @override
  String get showCalendarEventsTitle => 'Mostrar eventos do calendário';

  @override
  String get showCalendarEventsSubtitle =>
      'Os eventos aparecem cronologicamente só de leitura.';

  @override
  String get calendarPermDeniedPermanentTitle =>
      'Permissão de calendário negada permanentemente';

  @override
  String get calendarPermRequiredTitle =>
      'Permissão de leitura de calendário necessária';

  @override
  String get calendarPermDeniedPermanentDesc =>
      'Ative a permissão nas Definições e toque em Verificar novamente.';

  @override
  String get calendarPermRequiredDesc =>
      'O Zettask pede apenas permissão de leitura para mostrar eventos na linha temporal.';

  @override
  String get openSettingsButton => 'Abrir definições';

  @override
  String get checkAgainButton => 'Verificar novamente';

  @override
  String get noCalendarsFound =>
      'Nenhum calendário encontrado neste dispositivo.';

  @override
  String get eventDetailTitle => 'Detalhes do evento';

  @override
  String get eventNotesLabel => 'Notas';

  @override
  String get calendarEventReadOnlyBanner =>
      'Evento do calendário do dispositivo (só leitura).';

  @override
  String get markUncompletedSemantics => 'Marcar por concluir';

  @override
  String get markCompletedSemantics => 'Marcar concluída';

  @override
  String get deleteNoteTooltip => 'Eliminar nota';

  @override
  String repeatMonthlyDay(int day) {
    return 'Todos os meses · dia $day';
  }

  @override
  String get last30DaysSubtitle => 'Últimos 30 dias';

  @override
  String get allTimeSubtitle => 'Todo o período';

  @override
  String get taskCancelled => 'Tarefa marcada como cancelada';

  @override
  String get taskRestored => 'Tarefa reativada';

  @override
  String get cancelledStatusLabel => 'Cancelada';

  @override
  String get restoreTaskLabel => 'Reativar';

  @override
  String get markCancelledSemantics => 'Marcar cancelada';

  @override
  String get calendarPermFallbackHint =>
      'Se o pedido de permissão não aparecer, abra as Definições da app para ativar o acesso ao Calendário.';

  @override
  String get calendarBadgeLabel => 'Calendário';

  @override
  String get calendarSourceLabel => 'Calendário';

  @override
  String get calendarLocationLabel => 'Localização';

  @override
  String get calendarReadOnlyInfo =>
      'Sincronizado a partir do calendário do dispositivo. Este item é só de leitura e não pode ser editado no Zettask.';

  @override
  String get proBrandTitle => 'Zettask Pro';

  @override
  String get proBadge => 'PRO';

  @override
  String get proPaywallSubtitle =>
      'Sincronização na nuvem, calendários, bloqueio biométrico e temas OLED.';

  @override
  String proActiveBannerTitle(String plan) {
    return 'Ativo — $plan';
  }

  @override
  String get proActiveBannerSubtitle => 'Obrigado por apoiar o Zettask.';

  @override
  String get proUpgradeBannerSubtitle =>
      'Tema AMOLED, cores de destaque, estilos de widget e mais';

  @override
  String get proBenefitCloudSync =>
      'Sincronização na nuvem e vários dispositivos';

  @override
  String get proBenefitCalendar =>
      'Integração de calendário e feriados nacionais';

  @override
  String get proBenefitAppLock =>
      'Bloqueio biométrico e privacidade em apps recentes';

  @override
  String get proBenefitProjectsCsv => 'Projetos ilimitados e exportação CSV';

  @override
  String get proBenefitCustomization =>
      'AMOLED preto puro, cores de destaque e estilos de widget';

  @override
  String get proPlanMonthlyTitle => 'Mensal';

  @override
  String get proPlanMonthlyPrice => '1,99 € / mês';

  @override
  String get proPlanYearlyTitle => 'Anual';

  @override
  String get proPlanYearlyPrice => '12,99 € / ano';

  @override
  String get proPlanYearlyBadge => 'Melhor valor';

  @override
  String get proPlanYearlySavings => 'Poupe ~43%';

  @override
  String get proPlanLifetimeTitle => 'Vitalício';

  @override
  String get proPlanLifetimePrice => '29,99 €';

  @override
  String get proPlanLifetimeBadge => 'Pagamento único';

  @override
  String get proContinueButton => 'Continuar';

  @override
  String get proAlreadyActiveButton => 'Zettask Pro ativo';

  @override
  String get proRestorePurchasesButton => 'Restaurar compras';

  @override
  String get proLegalFootnote =>
      'As subscrições renovam automaticamente salvo cancelamento. Cancele a qualquer momento no Google Play.';

  @override
  String get proStoreUnavailableMessage =>
      'A faturação do Google Play ainda não está disponível neste dispositivo. Tente novamente mais tarde.';

  @override
  String get proPurchaseSuccessMessage => 'O Zettask Pro está agora ativo.';

  @override
  String get proRestoreSuccessMessage =>
      'A sua compra do Zettask Pro foi restaurada.';

  @override
  String get proRestoreEmptyMessage =>
      'Nenhuma compra ativa do Zettask Pro foi encontrada nesta conta.';

  @override
  String get proPurchaseFailedMessage =>
      'Não foi possível concluir a compra agora. Tente novamente.';

  @override
  String get debugProSimulationLabel => 'Modo de programador: Simulação Pro';

  @override
  String get amoledPureBlackTitle => 'AMOLED Preto Puro';

  @override
  String get amoledPureBlackSubtitle =>
      'Fundo escuro #000000 puro para ecrãs OLED';

  @override
  String get customAccentSection => 'Cor de destaque personalizada';

  @override
  String get accentMonochrome => 'Monocromático';

  @override
  String get accentSage => 'Sálvia';

  @override
  String get accentIndigo => 'Índigo';

  @override
  String get accentTerracotta => 'Terracota';

  @override
  String get accentAmber => 'Âmbar';

  @override
  String get widgetStyleSection => 'Estilo do widget do ecrã inicial';

  @override
  String get widgetStyleStandard => 'Padrão';

  @override
  String get widgetStyleAmoled => 'AMOLED';

  @override
  String get widgetStyleTranslucent => 'Translúcido';

  @override
  String get proContextUnlimitedProjects =>
      'O plano gratuito inclui até 3 projetos. Atualize para o Zettask Pro para projetos ilimitados.';

  @override
  String get proContextCalendarSync =>
      'A sincronização de calendário e feriados nacionais está incluída no Zettask Pro.';

  @override
  String get proContextAppLock =>
      'O bloqueio biométrico e a privacidade em apps recentes estão incluídos no Zettask Pro.';

  @override
  String get proContextCsvExport =>
      'A exportação CSV de tarefas e notas está incluída no Zettask Pro.';

  @override
  String get proContextCloudSync =>
      'A sincronização na nuvem entre dispositivos está incluída no Zettask Pro.';

  @override
  String get proContextCustomThemes =>
      'AMOLED preto puro e cores de destaque personalizadas estão incluídos no Zettask Pro.';

  @override
  String get proContextWidgetStyles =>
      'Os estilos de widget AMOLED e translúcido estão incluídos no Zettask Pro.';

  @override
  String get cloudSyncPausedShort =>
      'Sincronização em pausa · Dados locais seguros';

  @override
  String get cloudSyncPausedTitle => 'Sincronização na nuvem em pausa';

  @override
  String get cloudSyncPausedBody =>
      'O seu plano Zettask Pro está inativo. As tarefas e notas locais continuam seguras neste dispositivo.';

  @override
  String get resumeSyncWithProButton => 'Retomar sincronização com Pro';

  @override
  String get onboardingSkip => 'Ignorar';

  @override
  String get onboardingNext => 'Seguinte';

  @override
  String get onboardingGetStarted => 'Começar agora';

  @override
  String get onboardingSlide1Title => 'Registe tarefas sem distrações';

  @override
  String get onboardingSlide1Body =>
      'Adicione tarefas diárias em segundos, divida em listas e conclua com um toque.';

  @override
  String get onboardingSlide2Title => 'Linha temporal e projetos claros';

  @override
  String get onboardingSlide2Body =>
      'Veja o seu dia por ordem cronológica, organize projetos e cumpra horários com lembretes locais.';

  @override
  String get onboardingSlide3Title => 'Rápido, offline e privado';

  @override
  String get onboardingSlide3Body =>
      'Os seus dados ficam primeiro no dispositivo. Sem conta obrigatória e pronto mesmo sem internet.';

  @override
  String get appGuideTitle => 'Guia da aplicação';

  @override
  String get appGuideSubtitle => 'Rever o guia rápido do Zettask';

  @override
  String get dynamicColorTitle => 'Material You (Cor do papel de parede)';

  @override
  String get dynamicColorSubtitle =>
      'Adapte as cores de destaque ao papel de parede do dispositivo (Android 12+)';

  @override
  String get subtaskMarkedCancelled => 'Subtarefa cancelada';

  @override
  String get subtaskCancelledBadge => 'Cancelada';

  @override
  String get cancelSubtaskTooltip => 'Cancelar subtarefa';

  @override
  String get restoreSubtaskTooltip => 'Restaurar subtarefa';

  @override
  String get notificationActionComplete => 'Concluir';

  @override
  String get notificationActionSnooze => 'Adiar';

  @override
  String get notificationActionDismiss => 'Dispensar';

  @override
  String notificationSubtasksMore(int count) {
    return '+$count mais';
  }

  @override
  String notificationSubtasksSummary(int completed, int total) {
    return '$completed/$total concluídas';
  }
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => 'Linha do tempo';

  @override
  String get navBoard => 'Quadro';

  @override
  String get navUnplanned => 'Sem data';

  @override
  String get navMore => 'Mais';

  @override
  String get save => 'Salvar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get close => 'Fechar';

  @override
  String get delete => 'Excluir';

  @override
  String get edit => 'Editar';

  @override
  String get undo => 'Desfazer';

  @override
  String get back => 'Voltar';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get clear => 'Limpar';

  @override
  String get all => 'Todos';

  @override
  String get or => 'ou';

  @override
  String get continueAction => 'Continuar';

  @override
  String get understand => 'Entendi';

  @override
  String get useAction => 'Usar';

  @override
  String get today => 'Hoje';

  @override
  String get tomorrow => 'Amanhã';

  @override
  String get yesterday => 'Ontem';

  @override
  String get toDo => 'A fazer';

  @override
  String get overdue => 'Atrasadas';

  @override
  String get unplanned => 'Sem data';

  @override
  String get allDay => 'Dia inteiro';

  @override
  String get scheduled => 'Agendadas';

  @override
  String get addTaskToday => 'Adicionar tarefa para hoje';

  @override
  String get addTask => 'Adicionar tarefa';

  @override
  String get noTasksForDate => 'Nenhuma tarefa para esta data.';

  @override
  String get savedToUnplanned => 'Salva em Sem data';

  @override
  String get savedToUnplannedNoDate => 'Salva em Sem data (sem data)';

  @override
  String scheduledForDate(String date) {
    return 'Agendada para $date';
  }

  @override
  String taskScheduledForDate(String date) {
    return 'Tarefa agendada para $date';
  }

  @override
  String get taskDeleted => 'Tarefa excluída';

  @override
  String get searchTasksTooltip => 'Buscar tarefas';

  @override
  String get timelineOptionsTooltip => 'Opções da linha do tempo';

  @override
  String get addTaskTooltip => 'Adicionar tarefa';

  @override
  String get completedLabel => 'Concluída';

  @override
  String get uncompleteLabel => 'Marcar ativa';

  @override
  String subtasksCount(int done, int total) {
    return '$done/$total subtarefas';
  }

  @override
  String get repeatingTaskLabel => 'Tarefa recorrente';

  @override
  String get quickAddHint => 'Adicionar nova tarefa...';

  @override
  String get expandTooltip => 'Expandir';

  @override
  String get saveTaskTooltip => 'Salvar tarefa';

  @override
  String get newTask => 'Nova tarefa';

  @override
  String get editTask => 'Editar tarefa';

  @override
  String get taskTitleLabel => 'Título da tarefa';

  @override
  String get taskTitleHint => 'Ex.: Revisar notas da sprint';

  @override
  String get taskTitleRequired => 'O título é obrigatório';

  @override
  String get descriptionLabel => 'Descrição';

  @override
  String get descriptionHint => 'Adicione notas ou contexto...';

  @override
  String get pickDate => 'Escolher data';

  @override
  String get pickOnCalendar => 'Escolher no calendário...';

  @override
  String get noDateUnplanned => 'Sem data (Não planejada)';

  @override
  String get noDate => 'Sem data';

  @override
  String get taskTime => 'Horário da tarefa';

  @override
  String get changeTime => 'Alterar horário';

  @override
  String get clearTimeAllDay => 'Remover horário (Dia inteiro)';

  @override
  String get timeLabel => 'Horário';

  @override
  String get reminderLabel => 'Lembrete';

  @override
  String get noReminder => 'Sem lembrete';

  @override
  String get atTime => 'Na hora';

  @override
  String get minutesBefore10 => '10 min antes';

  @override
  String get minutesBefore30 => '30 min antes';

  @override
  String get hourBefore1 => '1 hora antes';

  @override
  String get reminderShort10m => '10 min';

  @override
  String get reminderShort30m => '30 min';

  @override
  String get reminderShort1h => '1 h';

  @override
  String get projectLabel => 'Projeto';

  @override
  String get noProject => 'Sem projeto';

  @override
  String get tagLabel => 'Tag';

  @override
  String get noTag => 'Sem tag';

  @override
  String get priorityLabel => 'Prioridade';

  @override
  String get priorityLow => 'Baixa';

  @override
  String get priorityMedium => 'Média';

  @override
  String get priorityHigh => 'Alta';

  @override
  String get saveTask => 'Salvar tarefa';

  @override
  String get saveChanges => 'Salvar alterações';

  @override
  String get checklistLabel => 'Checklist';

  @override
  String get addChecklistHint => 'Adicionar item...';

  @override
  String get repeatLabel => 'Repetir';

  @override
  String get noRepeat => 'Não repetir';

  @override
  String get repeatDaily => 'Todos os dias';

  @override
  String get repeatWeekly => 'Toda semana';

  @override
  String get repeatMonthly => 'Todo mês';

  @override
  String get colorLabel => 'Cor';

  @override
  String get timelineOptionsTitle => 'Opções da linha do tempo';

  @override
  String get viewModeLabel => 'Modo de visualização';

  @override
  String get modeTimeline => 'Modo Linha do tempo';

  @override
  String get modeDaily => 'Modo Diário';

  @override
  String get firstDayOfWeek => 'Início da semana';

  @override
  String get monday => 'Segunda-feira';

  @override
  String get sunday => 'Domingo';

  @override
  String get firstDayMondayOrder => 'Seg · Ter · Qua · Qui · Sex · Sáb · Dom';

  @override
  String get firstDaySundayOrder => 'Dom · Seg · Ter · Qua · Qui · Sex · Sáb';

  @override
  String get showCompletedTasks => 'Mostrar tarefas concluídas';

  @override
  String get showCompletedTasksSubtitle =>
      'Oculte tarefas concluídas para manter o foco.';

  @override
  String get showCompletedWorkspaceSubtitle =>
      'Mostrar ou ocultar tarefas concluídas.';

  @override
  String get overdueTasksTitle => 'Tarefas atrasadas';

  @override
  String get noOverdueTasks => 'Nenhuma tarefa atrasada';

  @override
  String get moveToToday => 'Mover para Hoje';

  @override
  String get moveAllToToday => 'Mover todas para Hoje';

  @override
  String get searchTasksHint => 'Buscar tarefas...';

  @override
  String get searchTasksEmpty =>
      'Digite para buscar tarefas, descrições ou checklists.';

  @override
  String searchNoResults(String query) {
    return 'Nenhuma tarefa corresponde a \"$query\".';
  }

  @override
  String get calendarEventReadOnly => 'Evento do calendário · somente leitura';

  @override
  String get prevWeekTooltip => 'Semana anterior';

  @override
  String get nextWeekTooltip => 'Próxima semana';

  @override
  String get boardTitle => 'Quadro';

  @override
  String get allProjects => 'Todos os projetos';

  @override
  String get searchProjectHint => 'Buscar projeto...';

  @override
  String get searchProjectTooltip => 'Buscar projetos';

  @override
  String get closeSearchTooltip => 'Fechar busca';

  @override
  String get createProject => 'Criar projeto';

  @override
  String get editProject => 'Editar projeto';

  @override
  String get deleteProject => 'Excluir projeto';

  @override
  String get projectOptionsTooltip => 'Opções do projeto';

  @override
  String projectDeleted(String name) {
    return 'Projeto \"$name\" excluído';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return '$done/$total concluídas';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return '$done/$total tarefas concluídas';
  }

  @override
  String get projectNotFound => 'Projeto não encontrado';

  @override
  String get noProjectsYet => 'Nenhum projeto ainda';

  @override
  String projectSearchEmpty(String query) {
    return 'Nenhum projeto corresponde a \"$query\".';
  }

  @override
  String get noProjectsSubtitle =>
      'Toque na pasta abaixo para criar seu primeiro projeto.';

  @override
  String get newProject => 'Novo projeto';

  @override
  String get projectNameLabel => 'Nome do projeto';

  @override
  String get projectNameHint => 'Ex.: Lançamento Zettask';

  @override
  String get projectNameRequired => 'O nome do projeto é obrigatório';

  @override
  String get projectColorLabel => 'Cor do projeto';

  @override
  String get unplannedTitle => 'Sem data';

  @override
  String activeCountLabel(int count) {
    return '$count ativas';
  }

  @override
  String get noUnplannedTitle => 'Nenhuma tarefa sem data';

  @override
  String get noUnplannedSubtitle =>
      'Toque em + para anotar uma tarefa sem data.';

  @override
  String get addUnplannedTooltip => 'Adicionar tarefa sem data';

  @override
  String get workspaceTitle => 'Espaço de trabalho';

  @override
  String get organizeSection => 'Organizar';

  @override
  String get automationSection => 'Automação';

  @override
  String get insightsSection => 'Estatísticas e tema';

  @override
  String get settingsInfoSection => 'Configurações e info';

  @override
  String get tagsTitle => 'Tags';

  @override
  String get tagsSubtitleEmpty => 'Etiquetas coloridas para tarefas e notas';

  @override
  String tagsCountSubtitle(int count) {
    return '$count tags salvas';
  }

  @override
  String get newTag => 'Nova tag';

  @override
  String get editTag => 'Editar tag';

  @override
  String get tagNameLabel => 'Nome da tag';

  @override
  String get tagNameRequired => 'O nome da tag é obrigatório';

  @override
  String get tagDeleted => 'Tag excluída';

  @override
  String get noTagsYet => 'Nenhuma tag ainda';

  @override
  String tagTasksCount(int count) {
    return '$count tarefas';
  }

  @override
  String get templatesTitle => 'Modelos';

  @override
  String get templatesSubtitleEmpty =>
      'Salve estruturas reutilizáveis de tarefas';

  @override
  String templatesCountSubtitle(int count) {
    return '$count modelos prontos';
  }

  @override
  String get newTemplate => 'Novo modelo';

  @override
  String get editTemplate => 'Editar modelo';

  @override
  String get templateNameLabel => 'Nome do modelo';

  @override
  String get templateNameRequired => 'O nome do modelo é obrigatório';

  @override
  String get templateDeleted => 'Modelo excluído';

  @override
  String get noTemplatesYet => 'Nenhum modelo ainda';

  @override
  String get taskFromTemplateSaved => 'Tarefa salva do modelo';

  @override
  String get notesTitle => 'Notas';

  @override
  String get notesSubtitleEmpty => 'Notas rápidas sem data';

  @override
  String notesCountSubtitle(int count) {
    return '$count notas salvas';
  }

  @override
  String get newNote => 'Nova nota';

  @override
  String get editNote => 'Editar nota';

  @override
  String get noteTitleLabel => 'Título da nota';

  @override
  String get noteTitleHint => 'Ex.: Resumo da reunião';

  @override
  String get noteTitleRequired => 'O título é obrigatório';

  @override
  String get noteContentLabel => 'Conteúdo';

  @override
  String get noteContentHint => 'Escreva sua nota aqui...';

  @override
  String get noteDeleted => 'Nota excluída';

  @override
  String get searchNotesHint => 'Buscar notas...';

  @override
  String get noteNotFound => 'Nota não encontrada';

  @override
  String get noNotesYet => 'Nenhuma nota ainda';

  @override
  String noteSearchEmpty(String query) {
    return 'Nenhuma nota corresponde a \"$query\".';
  }

  @override
  String get noNotesSubtitle => 'Toque em + para escrever uma nota rápida.';

  @override
  String get saveNote => 'Salvar nota';

  @override
  String get repeatingTasksTitle => 'Tarefas recorrentes';

  @override
  String get repeatingTasksSubtitleEmpty =>
      'Gerencie rotinas diárias, semanais e mensais';

  @override
  String repeatingActiveCount(int count) {
    return '$count rotinas ativas';
  }

  @override
  String get noRepeatingTasks => 'Nenhuma tarefa recorrente';

  @override
  String get repeatingActionTitle => 'Esta é uma tarefa recorrente';

  @override
  String get repeatingThisOnly => 'Apenas esta tarefa';

  @override
  String get repeatingThisAndFollowing => 'Esta e todas as próximas';

  @override
  String get last7DaysUpper => 'ÚLTIMOS 7 DIAS';

  @override
  String weeklySummary(int tasks, int checklists) {
    return '$tasks tarefas, mais $checklists itens de checklist';
  }

  @override
  String get statsTitle => 'Estatísticas';

  @override
  String get range7Days => '7 dias';

  @override
  String get range30Days => '30 dias';

  @override
  String get completedToday => 'Feitas hoje';

  @override
  String get last7DaysLabel => 'Últimos 7 dias';

  @override
  String get last30DaysLabel => 'Últimos 30 dias';

  @override
  String get allTimeLabel => 'Todo o período';

  @override
  String get completionRateLabel => 'Taxa de conclusão';

  @override
  String get activity7Days => 'Atividade dos últimos 7 dias';

  @override
  String get activity30Days => 'Atividade dos últimos 30 dias';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks tarefas · $checklists checklists';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return 'Total $days dias: $tasks tarefas e $checklists itens';
  }

  @override
  String get completedByPriority => 'Concluídas por prioridade';

  @override
  String get progressByProject => 'Progresso por projeto';

  @override
  String get breakdownByTag => 'Detalhes por tag';

  @override
  String get habits30Days => 'Hábitos · 30 dias';

  @override
  String get noProjectsCreated => 'Nenhum projeto criado.';

  @override
  String get noTagsCreated => 'Nenhuma tag criada.';

  @override
  String get noActiveHabits => 'Nenhuma rotina ativa.';

  @override
  String completedCountLabel(int count) {
    return '$count concluídas';
  }

  @override
  String tagBreakdownTrailing(int done, int total) {
    return '$done/$total concluídas';
  }

  @override
  String habitCompletedRatio(String summary, int done, int scheduled) {
    return '$summary · $done/$scheduled concluídas';
  }

  @override
  String statsSubtitle(int completed, int percent) {
    return '$completed concluídas · $percent% taxa';
  }

  @override
  String get themeTitle => 'Tema';

  @override
  String get themeAndColorsTitle => 'Tema e cores';

  @override
  String get livePreviewSection => 'Prévia ao vivo';

  @override
  String get appearanceModeSection => 'Aparência';

  @override
  String get colorPaletteSection => 'Paleta de cores';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeSystemLight => 'Sistema (Claro)';

  @override
  String get themeSystemDark => 'Sistema (Escuro)';

  @override
  String get presetDefault => 'Padrão';

  @override
  String get presetDefaultDesc => 'Índigo e ardósia';

  @override
  String get presetOcean => 'Oceano';

  @override
  String get presetOceanDesc => 'Azul sereno';

  @override
  String get presetForest => 'Floresta';

  @override
  String get presetForestDesc => 'Sálvia e esmeralda';

  @override
  String get presetTerracotta => 'Terracota';

  @override
  String get presetTerracottaDesc => 'Laranja quente';

  @override
  String get presetPlum => 'Ameixa';

  @override
  String get presetPlumDesc => 'Roxo suave';

  @override
  String get presetMonochrome => 'Monocromático';

  @override
  String get presetMonochromeDesc => 'Carvão e preto';

  @override
  String get previewActiveTask => 'Revisar design da interface';

  @override
  String get previewCompletedTask => 'Sincronizar agenda semanal';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get deviceLanguageOption => 'Idioma do dispositivo (se compatível)';

  @override
  String get appLockTitle => 'Bloqueio do app';

  @override
  String get appLockSubtitle => 'Digital, rosto ou PIN do dispositivo';

  @override
  String get appLockLockedTitle => 'Zettask bloqueado';

  @override
  String get appLockLockedSubtitle =>
      'Use sua digital, rosto ou PIN do dispositivo para acessar suas tarefas.';

  @override
  String get unlockButton => 'Desbloquear';

  @override
  String get verifyingButton => 'Verificando...';

  @override
  String get appLockUnsupportedError =>
      'Este dispositivo não tem biometria nem PIN ativado.';

  @override
  String get appLockCancelledError => 'Verificação cancelada ou falhou.';

  @override
  String get appLockUnlockFailedError =>
      'Autenticação falhou. Toque em Desbloquear.';

  @override
  String get calendarSyncTitle => 'Sincronizar calendário';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return 'Ativa · $count calendários';
  }

  @override
  String get calendarSyncInactiveSubtitle =>
      'Desativada · eventos somente leitura';

  @override
  String get grantCalendarPermission => 'Permitir acesso ao calendário';

  @override
  String get exportCsvTitle => 'Exportar CSV';

  @override
  String get exportCsvSubtitle => 'Compartilhe tarefas ou notas em CSV';

  @override
  String get exportDataCsvTitle => 'Exportar dados CSV';

  @override
  String get exportTasksTitle => 'Exportar tarefas';

  @override
  String get exportTasksSubtitle =>
      'Todas as tarefas agendadas, sem data e projetos';

  @override
  String get exportNotesTitle => 'Exportar notas';

  @override
  String get exportNotesSubtitle => 'Todas as notas rápidas';

  @override
  String get exportBothTitle => 'Exportar ambos';

  @override
  String get exportBothSubtitle => 'Arquivos CSV de tarefas e notas juntos';

  @override
  String get aboutPrivacyTitle => 'Sobre e Privacidade';

  @override
  String aboutPrivacySubtitle(String version) {
    return 'Versão $version · Offline-first e nuvem opcional';
  }

  @override
  String get aboutTitle => 'Sobre o Zettask';

  @override
  String versionLabel(String version) {
    return 'Versão $version';
  }

  @override
  String get privacySyncTitle => 'Privacidade e sincronização';

  @override
  String get privacySyncDescription =>
      'Por padrão seus dados ficam no dispositivo. A sincronização Firebase é opcional ao entrar na conta e você pode excluir permanentemente sua conta e dados na nuvem a qualquer momento.';

  @override
  String get privacyPolicyLabel => 'Política de privacidade';

  @override
  String get privacyLinkCopied => 'Link copiado';

  @override
  String get accountAndSyncTitle => 'Conta e sincronização';

  @override
  String get signInToZettask => 'Entrar na conta Zettask';

  @override
  String get accountBannerSubtitle =>
      'Opcional · backup e sincronização na nuvem';

  @override
  String get authWelcomeTitle => 'Salve seu progresso e tarefas';

  @override
  String get authWelcomeSubtitle =>
      'Faça backup automático de agendas, projetos e notas na nuvem. Você pode continuar usando o Zettask localmente sem conta.';

  @override
  String get createNewAccount => 'Criar nova conta';

  @override
  String get signIn => 'Entrar';

  @override
  String get continueWithGoogle => 'Continuar com o Google';

  @override
  String get authTermsNotice =>
      'Ao continuar, você concorda com os Termos e a Política de Privacidade do Zettask.';

  @override
  String get signInToAccountTitle => 'Entrar no Zettask';

  @override
  String get signInToAccountSubtitle =>
      'Os dados locais serão mesclados com seu backup na nuvem.';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailHint => 'nome@email.com';

  @override
  String get emailRequired => 'O e-mail é obrigatório.';

  @override
  String get emailInvalid => 'Formato de e-mail inválido.';

  @override
  String get passwordLabel => 'Senha';

  @override
  String get passwordHint => 'Digite sua senha';

  @override
  String get passwordNewHint => 'Mínimo de 6 caracteres';

  @override
  String get passwordRequired => 'A senha é obrigatória.';

  @override
  String get passwordTooShort => 'A senha deve ter pelo menos 6 caracteres.';

  @override
  String get forgotPassword => 'Esqueceu?';

  @override
  String get enterValidEmailFirst => 'Digite um e-mail válido primeiro.';

  @override
  String passwordResetSent(String email) {
    return 'Link de redefinição enviado para $email.';
  }

  @override
  String get showPasswordTooltip => 'Mostrar senha';

  @override
  String get hidePasswordTooltip => 'Ocultar senha';

  @override
  String get noAccountPrompt => 'Não tem uma conta?';

  @override
  String get createAccountLink => 'Criar conta';

  @override
  String get createAccountTitle => 'Criar conta';

  @override
  String get createAccountSubtitle =>
      'Salve todas as suas tarefas, rotinas e notas na nuvem.';

  @override
  String get haveAccountPrompt => 'Já tem uma conta?';

  @override
  String signedInVia(String provider) {
    return 'Conectado via $provider';
  }

  @override
  String get syncNowButton => 'Sincronizar agora';

  @override
  String get syncingLabel => 'Sincronizando...';

  @override
  String get syncDoneMessage => 'Sincronização concluída.';

  @override
  String get syncFailedMessage =>
      'Falha ao sincronizar. Verifique sua conexão.';

  @override
  String get syncStatusIdle => 'Ainda não sincronizado';

  @override
  String get syncStatusSyncing => 'Sincronizando...';

  @override
  String get syncStatusSynced => 'Sincronizado';

  @override
  String get syncStatusError => 'Erro na sincronização';

  @override
  String lastSyncedPrefix(String time) {
    return 'Última: $time';
  }

  @override
  String get neverSynced => 'Nunca sincronizado';

  @override
  String get signOutButton => 'Sair';

  @override
  String get signedOutMessage =>
      'Você saiu da conta. Os dados locais continuam no dispositivo.';

  @override
  String get deleteAccountButton => 'Excluir conta';

  @override
  String get deleteAccountStep1Title => 'Excluir conta?';

  @override
  String get deleteAccountStep1Body =>
      'Todos os backups na nuvem e sua conta serão excluídos permanentemente. Os dados locais continuam no dispositivo.';

  @override
  String get deleteAccountStep2Title => 'Confirmar exclusão permanente';

  @override
  String get deleteAccountStep2Body =>
      'Esta ação não pode ser desfeita. Excluir sua conta e todos os dados na nuvem agora?';

  @override
  String get deleteAccountConfirmButton => 'Sim, excluir permanentemente';

  @override
  String get accountDeletedMessage =>
      'Conta e dados na nuvem excluídos permanentemente.';

  @override
  String get reloginRequiredTitle => 'Faça login novamente';

  @override
  String get authErrUserNotFound =>
      'Nenhuma conta encontrada para este e-mail.';

  @override
  String get authErrWrongPassword => 'Senha incorreta.';

  @override
  String get authErrInvalidCredential => 'E-mail ou senha inválidos.';

  @override
  String get authErrInvalidEmail => 'Formato de e-mail inválido.';

  @override
  String get authErrEmailInUse => 'Este e-mail já está em uso.';

  @override
  String get authErrWeakPassword => 'Senha fraca. Use pelo menos 6 caracteres.';

  @override
  String get authErrNetwork => 'Erro de rede. Verifique sua conexão.';

  @override
  String get authErrRequiresRecentLogin =>
      'Por segurança, saia e entre novamente antes de excluir a conta.';

  @override
  String get authErrTooManyRequests =>
      'Muitas tentativas. Tente novamente em breve.';

  @override
  String get authErrUserDisabled => 'Esta conta foi desativada.';

  @override
  String get authErrAccountExistsDifferent =>
      'Este e-mail está vinculado a outro método de login.';

  @override
  String get authErrOperationNotAllowed =>
      'Este método de login não está ativado.';

  @override
  String get authErrFirebaseUnavailable => 'Serviço de conta indisponível.';

  @override
  String get authErrUnknown => 'Erro de autenticação. Tente novamente.';

  @override
  String get widgetTitle => 'Zettask · Hoje';

  @override
  String get widgetEmptyText => 'Todas as tarefas de hoje foram concluídas.';

  @override
  String get repeatingTasksAndFollowingDeleted =>
      'Tarefa recorrente e próximas excluídas';

  @override
  String get noProjectTasksTitle => 'Ainda não há tarefas neste projeto';

  @override
  String noProjectTasksSubtitle(String project) {
    return 'Toque em + para adicionar uma tarefa em $project.';
  }

  @override
  String get addTaskToProjectTooltip => 'Adicionar tarefa ao projeto';

  @override
  String get noTagsSubtitle =>
      'Toque em + para criar tags coloridas para tarefas e notas.';

  @override
  String get tagOptionsTooltip => 'Opções de tag';

  @override
  String get deleteTag => 'Excluir tag';

  @override
  String get addTagTooltip => 'Adicionar tag';

  @override
  String get noTasksWithTag => 'Ainda não há tarefas com esta tag.';

  @override
  String get addTaskWithTagTooltip => 'Adicionar tarefa com tag';

  @override
  String get tagNameHint => 'ex. Trabalho, Pessoal, Urgente';

  @override
  String get tagColorLabel => 'Cor da tag';

  @override
  String get createTag => 'Criar tag';

  @override
  String tagDeletedNamed(String name) {
    return 'Tag \"$name\" excluída';
  }

  @override
  String get noTemplatesSubtitle =>
      'Salve estruturas frequentes de tarefas e listas para criar mais rápido.';

  @override
  String get templateOptionsTooltip => 'Opções de modelo';

  @override
  String get deleteTemplate => 'Excluir modelo';

  @override
  String get createTemplateTooltip => 'Criar modelo';

  @override
  String templateDeletedNamed(String name) {
    return 'Modelo \"$name\" excluído';
  }

  @override
  String get templateNameHint => 'ex. Lançamento semanal';

  @override
  String get defaultTaskTitleLabel => 'Título padrão da tarefa';

  @override
  String get defaultTaskTitleHint => 'ex. Preparar lançamento';

  @override
  String get timeOptionalLabel => 'Horário (opcional)';

  @override
  String get clearTimeTooltip => 'Limpar horário';

  @override
  String get projectOptionalLabel => 'Projeto (opcional)';

  @override
  String get tagOptionalLabel => 'Tag (opcional)';

  @override
  String get defaultSubtasksLabel => 'Subtarefas padrão';

  @override
  String get addTemplateSubtaskHint => 'Adicionar subtarefa...';

  @override
  String get saveTemplate => 'Salvar modelo';

  @override
  String subtasksTotalCount(int count) {
    return '$count subtarefas';
  }

  @override
  String get useTemplateButton => 'Usar modelo';

  @override
  String get pickTemplateTitle => 'Escolher modelo';

  @override
  String get repeatingTaskDeleted => 'Tarefa recorrente excluída';

  @override
  String get noRepeatingTasksSubtitle =>
      'Toque em + para criar rotinas diárias, semanais ou mensais.';

  @override
  String get addRepeatingTaskTooltip => 'Adicionar tarefa recorrente';

  @override
  String get editRepeatingTask => 'Editar tarefa recorrente';

  @override
  String get newRepeatingTask => 'Nova tarefa recorrente';

  @override
  String get deleteTaskTooltip => 'Excluir tarefa';

  @override
  String get scheduleLabel => 'Agenda';

  @override
  String get startAndTimeLabel => 'Início e horário';

  @override
  String get dateRequiredForTime => 'Precisa de data';

  @override
  String get clearDateTooltip => 'Limpar data';

  @override
  String get pickTimeFirstReminder =>
      'Escolha um horário primeiro para ativar lembretes.';

  @override
  String get notificationPermissionDenied =>
      'Permissão de notificação desativada. Ative nas configurações do aparelho.';

  @override
  String get pickDateFirstRepeat =>
      'Escolha uma data primeiro para configurar a repetição.';

  @override
  String get subtasksLabel => 'Subtarefas';

  @override
  String subtasksWithCount(int count) {
    return 'Subtarefas ($count)';
  }

  @override
  String get removeSubtaskTooltip => 'Remover subtarefa';

  @override
  String get addSubtaskTooltip => 'Adicionar subtarefa';

  @override
  String get moveAllOverdueMoved =>
      'Todas as tarefas atrasadas foram movidas para hoje';

  @override
  String get moveAllShort => 'Mover todas';

  @override
  String get noOverdueTasksSubtitle =>
      'Todas as tarefas de dias anteriores foram concluídas.';

  @override
  String get repeatingDeletePrompt => 'O que você deseja excluir?';

  @override
  String get repeatingEditPrompt => 'O que você deseja alterar?';

  @override
  String get repeatingDeleteSingleSub => 'Excluir apenas esta ocorrência';

  @override
  String get repeatingEditSingleSub => 'Alterar apenas esta ocorrência';

  @override
  String get repeatingDeleteFollowingSub => 'Excluir esta e todas as próximas';

  @override
  String get repeatingEditFollowingSub => 'Aplicar a esta e todas as próximas';

  @override
  String get deviceCalendarTitle => 'Calendário do dispositivo';

  @override
  String get selectCalendarsLabel => 'Selecionar calendários';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '$selected/$total ativos';
  }

  @override
  String get showCalendarEventsTitle => 'Mostrar eventos do calendário';

  @override
  String get showCalendarEventsSubtitle =>
      'Os eventos aparecem cronologicamente em modo somente leitura.';

  @override
  String get calendarPermDeniedPermanentTitle =>
      'Permissão do calendário negada permanentemente';

  @override
  String get calendarPermRequiredTitle =>
      'Permissão de leitura do calendário necessária';

  @override
  String get calendarPermDeniedPermanentDesc =>
      'Ative a permissão nas Configurações do aparelho e toque em Verificar novamente.';

  @override
  String get calendarPermRequiredDesc =>
      'O Zettask pede apenas permissão de leitura para mostrar seus eventos na linha do tempo.';

  @override
  String get openSettingsButton => 'Abrir configurações';

  @override
  String get checkAgainButton => 'Verificar novamente';

  @override
  String get noCalendarsFound => 'Nenhum calendário encontrado neste aparelho.';

  @override
  String get eventDetailTitle => 'Detalhes do evento';

  @override
  String get eventNotesLabel => 'Notas';

  @override
  String get calendarEventReadOnlyBanner =>
      'Evento do calendário do dispositivo (somente leitura).';

  @override
  String get markUncompletedSemantics => 'Marcar pendente';

  @override
  String get markCompletedSemantics => 'Marcar concluída';

  @override
  String get deleteNoteTooltip => 'Excluir nota';

  @override
  String repeatMonthlyDay(int day) {
    return 'Todo mês · dia $day';
  }

  @override
  String get last30DaysSubtitle => 'Últimos 30 dias';

  @override
  String get allTimeSubtitle => 'Todo o período';

  @override
  String get taskCancelled => 'Tarefa marcada como cancelada';

  @override
  String get taskRestored => 'Tarefa reativada';

  @override
  String get cancelledStatusLabel => 'Cancelada';

  @override
  String get restoreTaskLabel => 'Reativar';

  @override
  String get markCancelledSemantics => 'Marcar cancelada';

  @override
  String get calendarPermFallbackHint =>
      'Se o aviso de permissão não aparecer, abra as Configurações do app para ativar o acesso ao Calendário manualmente.';

  @override
  String get calendarBadgeLabel => 'Calendário';

  @override
  String get calendarSourceLabel => 'Calendário';

  @override
  String get calendarLocationLabel => 'Local';

  @override
  String get calendarReadOnlyInfo =>
      'Sincronizado do calendário do dispositivo. Este item é somente leitura e não pode ser editado no Zettask.';

  @override
  String get proBrandTitle => 'Zettask Pro';

  @override
  String get proBadge => 'PRO';

  @override
  String get proPaywallSubtitle =>
      'Sincronização na nuvem, calendários, bloqueio biométrico e temas OLED.';

  @override
  String proActiveBannerTitle(String plan) {
    return 'Ativo — $plan';
  }

  @override
  String get proActiveBannerSubtitle => 'Obrigado por apoiar o Zettask.';

  @override
  String get proUpgradeBannerSubtitle =>
      'Tema AMOLED, cores de destaque, estilos de widget e mais';

  @override
  String get proBenefitCloudSync =>
      'Sincronização na nuvem e vários dispositivos';

  @override
  String get proBenefitCalendar =>
      'Integração de calendário e feriados nacionais';

  @override
  String get proBenefitAppLock =>
      'Bloqueio biométrico e privacidade em apps recentes';

  @override
  String get proBenefitProjectsCsv => 'Projetos ilimitados e exportação CSV';

  @override
  String get proBenefitCustomization =>
      'AMOLED preto puro, cores de destaque e estilos de widget';

  @override
  String get proPlanMonthlyTitle => 'Mensal';

  @override
  String get proPlanMonthlyPrice => 'R\$ 9,90 / mês';

  @override
  String get proPlanYearlyTitle => 'Anual';

  @override
  String get proPlanYearlyPrice => 'R\$ 67,90 / ano';

  @override
  String get proPlanYearlyBadge => 'Melhor custo';

  @override
  String get proPlanYearlySavings => 'Economize ~43%';

  @override
  String get proPlanLifetimeTitle => 'Vitalício';

  @override
  String get proPlanLifetimePrice => 'R\$ 149,90';

  @override
  String get proPlanLifetimeBadge => 'Pagamento único';

  @override
  String get proContinueButton => 'Continuar';

  @override
  String get proAlreadyActiveButton => 'Zettask Pro ativo';

  @override
  String get proRestorePurchasesButton => 'Restaurar compras';

  @override
  String get proLegalFootnote =>
      'As assinaturas são renovadas automaticamente até o cancelamento. Cancele quando quiser no Google Play.';

  @override
  String get proStoreUnavailableMessage =>
      'O faturamento do Google Play ainda não está disponível neste dispositivo. Tente novamente mais tarde.';

  @override
  String get proPurchaseSuccessMessage => 'O Zettask Pro agora está ativo.';

  @override
  String get proRestoreSuccessMessage =>
      'Sua compra do Zettask Pro foi restaurada.';

  @override
  String get proRestoreEmptyMessage =>
      'Nenhuma compra ativa do Zettask Pro foi encontrada nesta conta.';

  @override
  String get proPurchaseFailedMessage =>
      'Não foi possível concluir a compra agora. Tente novamente.';

  @override
  String get debugProSimulationLabel => 'Modo desenvolvedor: Simulação Pro';

  @override
  String get amoledPureBlackTitle => 'AMOLED Preto Puro';

  @override
  String get amoledPureBlackSubtitle =>
      'Fundo escuro #000000 puro para telas OLED';

  @override
  String get customAccentSection => 'Cor de destaque personalizada';

  @override
  String get accentMonochrome => 'Monocromático';

  @override
  String get accentSage => 'Sálvia';

  @override
  String get accentIndigo => 'Índigo';

  @override
  String get accentTerracotta => 'Terracota';

  @override
  String get accentAmber => 'Âmbar';

  @override
  String get widgetStyleSection => 'Estilo do widget na tela inicial';

  @override
  String get widgetStyleStandard => 'Padrão';

  @override
  String get widgetStyleAmoled => 'AMOLED';

  @override
  String get widgetStyleTranslucent => 'Translúcido';

  @override
  String get proContextUnlimitedProjects =>
      'O plano gratuito permite até 3 projetos. Assine o Zettask Pro para projetos ilimitados.';

  @override
  String get proContextCalendarSync =>
      'A sincronização de calendário e feriados nacionais faz parte do Zettask Pro.';

  @override
  String get proContextAppLock =>
      'O bloqueio biométrico e a privacidade nos apps recentes fazem parte do Zettask Pro.';

  @override
  String get proContextCsvExport =>
      'A exportação de tarefas e notas para CSV faz parte do Zettask Pro.';

  @override
  String get proContextCloudSync =>
      'A sincronização na nuvem entre dispositivos faz parte do Zettask Pro.';

  @override
  String get proContextCustomThemes =>
      'AMOLED preto puro e cores de destaque personalizadas fazem parte do Zettask Pro.';

  @override
  String get proContextWidgetStyles =>
      'Os estilos de widget AMOLED e translúcido fazem parte do Zettask Pro.';

  @override
  String get cloudSyncPausedShort =>
      'Sincronização pausada · Dados locais seguros';

  @override
  String get cloudSyncPausedTitle => 'Sincronização na nuvem pausada';

  @override
  String get cloudSyncPausedBody =>
      'Seu plano Zettask Pro está inativo. Suas tarefas e notas locais continuam seguras neste dispositivo.';

  @override
  String get resumeSyncWithProButton => 'Retomar sincronização com Pro';

  @override
  String get onboardingSkip => 'Pular';

  @override
  String get onboardingNext => 'Próximo';

  @override
  String get onboardingGetStarted => 'Começar agora';

  @override
  String get onboardingSlide1Title => 'Anote tarefas sem distrações';

  @override
  String get onboardingSlide1Body =>
      'Adicione tarefas diárias em segundos, divida em checklists e conclua com um toque.';

  @override
  String get onboardingSlide2Title => 'Linha do tempo e projetos claros';

  @override
  String get onboardingSlide2Body =>
      'Veja seu dia em ordem cronológica, organize projetos e cumpra horários com lembretes locais.';

  @override
  String get onboardingSlide3Title => 'Rápido, offline e privado';

  @override
  String get onboardingSlide3Body =>
      'Seus dados ficam primeiro no seu aparelho. Sem conta obrigatória e pronto mesmo sem internet.';

  @override
  String get appGuideTitle => 'Guia do aplicativo';

  @override
  String get appGuideSubtitle => 'Rever a apresentação rápida do Zettask';

  @override
  String get dynamicColorTitle => 'Material You (Cor do papel de parede)';

  @override
  String get dynamicColorSubtitle =>
      'Adapte as cores de destaque ao papel de parede do dispositivo (Android 12+)';

  @override
  String get subtaskMarkedCancelled => 'Subtarefa cancelada';

  @override
  String get subtaskCancelledBadge => 'Cancelada';

  @override
  String get cancelSubtaskTooltip => 'Cancelar subtarefa';

  @override
  String get restoreSubtaskTooltip => 'Restaurar subtarefa';

  @override
  String get notificationActionComplete => 'Concluir';

  @override
  String get notificationActionSnooze => 'Adiar';

  @override
  String get notificationActionDismiss => 'Dispensar';

  @override
  String notificationSubtasksMore(int count) {
    return '+$count mais';
  }

  @override
  String notificationSubtasksSummary(int completed, int total) {
    return '$completed/$total concluídas';
  }
}
