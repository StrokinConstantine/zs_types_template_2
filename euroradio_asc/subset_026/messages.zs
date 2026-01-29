package euroradio_asc.subset_026.messages;

import euroradio_asc.subset_026.packages.*;

struct Message {
    bit:8  id    ;
    bit:16 length;
    bit:32 time  ; ///< Время отправки сообщения (T_TRAIN)

    ValidatedTrainDataMsg  validatedTrainDataMsg  if id == 129;
    MaRequestMsg           maRequestMsg           if id == 132;
    TrainPositionReportMsg trainPositionReportMsg if id == 136;
    AckMsg                 ackMsg                 if id == 146;
    AckOfESMsg             ackOfESMsg             if id == 147;
    EndOfMissionMsg        endOfMissionMsg        if id == 150;
    NoCVSMsg               noCVSMsg               if id == 154;
    InitiationCSMsg        initiationCSMsg        if id == 155;
    TerminationCSMsg       terminationCSMsg       if id == 156;
    StartOfMissionPrMsg    startOfMissionPrMsg    if id == 157;
    SessionEstablishedMsg  sessionEstablishedMsg  if id == 159;
    ChannelStateMsg        channelStateMsg        if id == 160;
    ActualDistanceMsg      actualDistanceMsg      if id == 161;
    SrAuthMsg              srAuthMsg              if id == 2;
    MovementAuthorityMsg   movementAuthorityMsg   if id == 3;
    AckOfTrainDataMsg      ackOfTrainDataMsg      if id == 8;
    UnconditionalESMsg     unconditionalESMsg     if id == 16;
    RevocationOfESMsg      revocationOfESMsg      if id == 18;
    GeneralMessage         generalMessage         if id == 24;
    SystemVersionMsg       systemVersionMsg       if id == 32;
    AckOfTerminationCSMsg  ackOfTerminationCSMsg  if id == 39;
    TrainRejectedMsg       trainRejectedMsg       if id == 40;
    TrainAcceptedMsg       trainAcceptedMsg       if id == 41;
};

/**
 * Заголовок сообщений БРУС -> РБЦ
 */
struct ObuHeader {
    bit:24 nid_engine; ///< ID OBU (NID_ENGINE)
};

/**
 * Заголовок сообщений РБЦ -> БРУС
 */
struct RbcHeader {
    bool   ack           ; ///< Флаг запроса подтверждения (M_ACK)
    bit:24 last_balise_id; ///< Идентификатор последней пройденной бализы
                           ///< (NID_LRBG)
};

/**
 * Сообщение 129 Validated Train ValidatedTrainDataPkg
 */
struct ValidatedTrainDataMsg {
    ObuHeader             header;
    PositionReportPkg     position;
    TrainRunningNumberPkg number;
    ValidatedTrainDataPkg data;
};

/**
 * Сообщение 132 MA Request
 */
struct MaRequestMsg {
    ObuHeader                      header             ;
    bit:5                          reason             ; ///< Причина запроса Q_MARQSTREASON
    PositionReportPkg              position           ;
    optional ShuntingParametersPkg shunting_parameters;
    optional SrdoPkg               srdo_pkg           ;
};

/**
 * Сообщение 136 Train PositionReportPkg Report
 */
struct TrainPositionReportMsg {
    ObuHeader                      header             ;
    PositionReportPkg              position           ;
    TrainRunningNumberPkg          number             ;
    optional ShuntingParametersPkg shunting_parameters;
    optional SrdoPkg               srdo_pkg           ;
};

/**
 * Сообщение 146 AckMsg
 */
struct AckMsg {
    ObuHeader header;
    bit:32    confirmation_time; ///< Время отправки подтверждаемого сообщения
                                 ///< (T_TRAIN)
};

/**
 * Сообщение 147 AckMsg of Emergency Stop
 */
struct AckOfESMsg {
    ObuHeader         header  ;
    bit:4             es_id   ; ///< Идентификатор сообщения аварийной остановки (NID_EM)
    bit:2             is_stop ; ///< Результат подтверждения аварийной     остановки
                                                                                                                                      ///< (Q_EMERGENCYSTOP), 1 or 2 bits???
    PositionReportPkg position;
};

/**
 * Сообщение 150 End of Mission
 */
struct EndOfMissionMsg {
    ObuHeader header;
    PositionReportPkg position;
};

/**
 * Сообщение 154 No compatible version supported
 */
struct NoCVSMsg {
    ObuHeader header;
};

/**
 * Сообщение 155 Initiation of a communication session
 */
struct InitiationCSMsg {
    ObuHeader header;
    TrainRunningNumberPkg number;
};

/**
 * Сообщение 156 Termination of a communication session
 */
struct TerminationCSMsg {
    ObuHeader header;
};

/**
 * Сообщение 157 Start Of Mission PositionReportPkg Report
 */
struct StartOfMissionPrMsg {
    ObuHeader header                   ;
    bit:2 status                        ; ///< Статус данных местоположения (Q_STATUS), 1 or 2 bits???
    PositionReportPkg position         ;
    TrainRunningNumberPkg number       ;

    optional AppDataFromObuPkg app_data;
};

/**
 * Сообщение 159 Session established
 */
struct SessionEstablishedMsg {
    ObuHeader header;
};

/**
 * Сообщение 160 Channels state - not from Subset-026
 */
struct ChannelStateMsg {
    ObuHeader header;
    bool is_normal_alive;
    bool is_redundant_alive;
};

/**
 * Сообщение 161 Actual Distance - not from Subset-026
 */
struct ActualDistanceMsg {
    ObuHeader header;
    bit:16 distance;
    bit:16 allowed_speed;
    bit:16 distance_to_target;
};

/**
 * Сообщение 2 SR Authorisation
 */
struct SrAuthMsg {
    RbcHeader header;
    bit:2  scale   ; ///< Шкала расстояний, устанавливается в 1 (Q_SCALE)
    bit:15 distance; ///< Расстояние в режиме SR (D_SR)

    optional ListOfBalisesInSrAuthPkg balises;
};

/**
 * Сообщение 3 Movement Authority: Разрешение на движение
 */
struct MovementAuthorityMsg {
    RbcHeader header;
    LinkingPkg links;
    MovementAuthPkg movement_auth;

    optional LvlTransitionOrderPkg lvl_transition_order;
    optional TemporarySpeedRestrPkg speed_restr;
    optional TemporarySpeedRestrRevPkg speed_restr_rev;
    optional InternationalStaticSpeedProfile speed_profiles;
    optional GradientProfile gradient_profiles;
};

/**
 * Сообщение 8 AckMsg of Train ValidatedTrainDataPkg: Подтверждение данных
 * поезда
 */
struct AckOfTrainDataMsg {
    RbcHeader header;
    bit:32 time; ///< Время отправки подтверждаемого сообщения с пакетом 11
};

/**
 * Сообщение 16 Unconditional Emergency Stop: Безусловная аварийная остановка
 */
struct UnconditionalESMsg {
    RbcHeader header;
    bit:4 es_id; ///< Идентификатор сообщения аварийной остановки (NID_EM)
};

/**
 * Сообщение 18 Revocation of Emergency Stop
 */
struct RevocationOfESMsg {
    RbcHeader header;
    bit:4 es_id; ///< Идентификатор сообщения аварийной остановки (NID_EM)
};

/**
 * Сообщение 24 General message: Сообщение общего типа
 */
struct GeneralMessage {
    RbcHeader header;

    optional SessionManagementPkg session_management;
    optional AppDataFromRbcPkg    app_data          ;
    optional ShuntingCommandPkg   shunting_command  ;
    optional AlsSignalsPkg        als_signals       ;
    optional SrdoPkg              srdo_pkg          ;
};

/**
 * Сообщение 32 RBC/RIU System Version: Конфигурация РБЦ
 */
struct SystemVersionMsg {
    RbcHeader header;
    bit:7 version; ///< Версия ETCS. Устанавливается в 010 0001 (M_VERSION)
};

/**
 * Сообщение 39 AckMsg of termination of a communication session: Подтверждение
 * завершения сеанса связи
 */
struct AckOfTerminationCSMsg {
    RbcHeader header;
};

/**
 * Сообщение 40 Train Rejected: Поезд отклонен
 */
struct TrainRejectedMsg {
    RbcHeader header;

    /// Причина отклонения (не из Subset-026) (NID_REJECT_REASON)
    /// 0 - Неизвестно
    /// 1 - Несоответствие версии БД
    /// 2 - Нет занятости рельсовой цепи под локомотивом
    bit:2 reason;
};

/**
 * Сообщение 41 Train Accepted: Поезд принят
 */
struct TrainAcceptedMsg {
    RbcHeader header;
};

