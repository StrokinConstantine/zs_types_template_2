package euroradio_asc.subset_026.packages;

struct ObuPkgHeader {
    bit:8 pkg_id;
    bit:13 pkg_length;
};

struct RbcPkgHeader {
    bit:8 pkg_id;
    bit:2 data_direction; // Q_DIR???
    bit:13 pkg_length;
};

/**
 * Пакет 0 PositionReportPkg Report
 */
struct PositionReportPkg {
    ObuPkgHeader header;

    bit:2  scale               ; ///< Шкала расстояний (Q_SCALE)
    bit:24 last_balise_id      ; ///< ID последней пройденной виртуальной бализы
                                 ///< (NID_LRBG)
    bit:15 distance_passed     ; ///< Пройденное головой поезда расстояние от
                                 ///< последней бализы (D_LRBG)
    bit:2  balise_orientation  ; ///< Ориентация поезда относительно направления
                                 ///< последней пройденной бализы (Q_DIRLRBG)
    bit:2  balise_side         ; ///< Сторона бализы. Устанавливается в 1 (Q_DLRBG)
    bit:15 upper_confid_int    ; ///< Верхний доверительный интервал (L_DOUBTOVER)
    bit:15 lower_confid_int    ; ///< Нижний доверительный интервал (L_DOUBTUNDER)
    bit:2  train_integrity     ; ///< Целостность поезда (Q_LENGTH)
    bit:15 length_in_cars      ; ///< Безопасная длина поезда. Если целостность
                                 ///< поезда подтверждена, иначе 0 (L_TRAININT)
    bit:7  speed               ; ///< Скорость поезда (V_TRAIN)
    bit:2  is_nominal_direction; ///< Направление движения поезда относительно
                                 ///< направления последней пройденной бализы
                                 ///< (Q_DIRTRAIN) 1 or 2 bits???
    bit:4  control_mode        ; ///< Бортовой режим управления (M_MODE)
    bit:3  control_lvl         ; ///< Уровень управления (M_LEVEL)
    bit:8  nid                 ; ///< Идентификатор национальной системы. Устанавливается в 0
                                 ///< Если M_LEVEL = 1 (NID_NTC)
};

/**
 * Пакет 5 Train running number
 */
struct TrainRunningNumberPkg {
    ObuPkgHeader header;

    bit:32 number; ///< Номер поезда (NID_OPERATIONAL)
};

struct Axle {
    bit:4 voltage; ///< Напряжение тяговой системы. Устанавливается в 3
                   ///< (M_VOLTAGE)
    bit:10 nid   ; ///< Национальный идентификатор системы тяги. Устанавливается в
                   ///< 1 (NID_CTRACTION) 10 or 8 bits???
};

/**
 * Пакет 11 Validated train data
 */
struct ValidatedTrainDataPkg {
    ObuPkgHeader header;

    bit:4  train_category; ///< Категория поезда. Устанавливается в 15 (NC_CDTRAIN)
    bit:15 train_type    ; ///< Категория поезда (NC_TRAIN)
    bit:12 length_in_cars; ///< Длина поезда в вагонах (L_TRAIN в метрах)
    bit:7  max_speed     ; ///< Максимальная скорость поезда. Устанавливается в 32
                           ///< (V_MAXTRAIN)
    bit:8  loading_prof  ; ///< Профиль загрузки поезда. Устанавливается в 0
                           ///< (M_LOADINGGAUGE)
    bit:7  axis_load     ; ///< Категория нагрузки на ось. Устанавливается в 2
                           ///< (M_AXLELOADCAT)
    bit:2  is_airtight   ; ///< Наличие системы герметичности. Устанавливается в 0
                           ///< (M_AIRTIGHT) 1 or 2 bits???
    bit:10 axis_number   ; ///< Количество осей (N_AXLE)
    Axle   axis[]        ;
    bit:8  nids[]        ; ///< Идентификатор национальной системы.
                           ///< Устанавливается в 0 (NID_NTC)
};




/**
 * Пакет 7 Shunting parameters
 * @brief Используется для передачи параметров выполнения маневровых операций
 */
struct ShuntingParametersPkg {
    ObuPkgHeader header;

    bit:2  train_tcms          ;  ///< Положение реверсора (Q_DIRTRAIN_TCMS)
    bit:2  train_orientation   ;  ///< Положение поезда относительно координатной
                                  ///< шкалы станции (Q_TRAIN_ORIENTATION)
    bit:3  coupling_tcms       ;  ///< Подтверждение сцепки (Q_COUPLING_TCMS)
    bit:2  brake_status_odu    ;  ///< Статус опробования тормозов (F_BRAKE_STATUS_ODU)
    bit:2  brake_tm_tcms       ;  ///< Статус зарядки тормозной магистрали
                                  ///< (F_BRAKE_TM_TCMS)
    bit:2  brake_test_tm_tcms  ;  ///< Выполняемое действие при проверке тормозов
                                  ///< (F_BRAKE_TEST_TM_TCMS)
    bit:2  coupling_ls_odu     ;  ///< Наличие сцепки с вагонами со стороны кабины
                                  ///< (Q_COUPLING_LS_ODU)
    bit:2  coupling_rs_odu     ;  ///< Наличие сцепки с вагонами со стороны капота
                                  ///< (Q_COUPLING_RS_ODU)
    bit:3  odu_status          ;  ///< Статус блока обнаружения препятствий (Q_ODU_STATUS)
    bit:12 odu_track_free_dist ;  ///< Свободное расстояние в направлении
                                  ///< движения по данным блока обнаружения
                                  ///< препятствий (Q_ODU_TRACK_FREE_DIST)
    bit:7  brake_tm_real       ;  ///< Фактическое значение давления в тормозной
                                  ///< магистрали (P_BRAKE_TM_REAL)
    bit:7  brake_tc_real       ;  ///< Фактическое значение давления в тормозном
                                  ///< цилиндре (P_BRAKE_TC_REAL)
    bit:7  real_operation_tcms ;  ///< Тип выполняемой  маневровой операции
                                  ///< (Q_REAL_OPERATION_TCMS)
    bit:2  real_operation_state;  ///< Статус выполнения операции
                                  ///< (Q_REAL_OPERATION_STATE)
    bit:3  error_operation     ;  ///< Причины прерывания выполнения операции
                                  ///< (Q_ERROR_OPERATION)
};

/**
 * Пакет 44 Data used by applications outside the ERTMS/ETCS system
 * @brief Используется для передачи данных для приложений
 */
struct AppDataPkg {
    bit:9 system_id; ///< Идентификатор системы (NID_XUSER)
};

struct AppDataFromObuPkg {
    ObuPkgHeader header;

    AppDataPkg appDataPkg ;
    bit:32     map_version;
};

/**
 * Структура для каждой группы бализ
 */
struct BaliseGroup {
    bit:15 balise_dist             ; ///< Расстояние между группами бализ (D_LINK)
    bool   new_country             ; ///< Флаг изменения зоны (Q_NEWCOUNTRY)
    bit:10 zone                    ; ///< Идентификатор зоны контроля РБЦ. Если Q_NEWCOUNTRY = 1
                                     ///< (NID_C)
    bit:14 balise_group_id         ; ///< Идентификатор группы бализ (NID_BG)
    bool   balise_group_orientation; ///< Направление группы бализ
                                     ///< (Q_LINKORIENTATION)
    bit:2  on_link_error           ; ///< Действие при нарушении соединения бализ
                                     ///< (Q_LINKREACTION)
    bit:6  location_accuracy       ; ///< Точность местоположения бализы (Q_LOCACC)
};

/**
 * Пакет 5 Linking
 * @brief Используется для передачи всех виртуальных бализ в разрешении на
 * движение.
 */
struct LinkingPkg {
    RbcPkgHeader header;

    bit:2       scale    ; ///< Шкала расстояний, устанавливается в 1 (Q_SCALE)
    BaliseGroup last     ;
    BaliseGroup balises[];
};

/**
 * Информаци о секции
 */
struct Section {
    bit:15 length              ;   ///< Длина участка в разрешении на движение (L_SECTION)
    bool   timer               ;   ///< Флаг наличия таймера для участка (Q_SECTIONTIMER)
    bit:10 zone_expiration_time;   ///< Время валидности участка в разрешении на
                                   ///< движение (T_SECTIONTIMER)
    bit:15 length_to_stop      ;   ///< Расстояние от начала участка до точки остановки
                                   ///< таймера участка (D_SECTIONTIMERSTOPLOC)
};

/**
 * Пакет 15 Level 2/3 Movement Authority
 * @brief Используется для передачи разрешения на движение
 */
struct MovementAuthPkg {
    RbcPkgHeader header;

    bit:2   scale               ;  ///< Шкала расстояний, устанавливается в 1 (Q_SCALE)
    bit:7   allowed_speed_end   ;  ///< Разрешенная скорость в конце разрешения на
                                   ///< движение (V_EMA)
    bit:10  speed_expire_time   ;  ///< Время валидности целевой скорости в конце
                                   ///< разрешения на движение (T_EMA)
    Section sections[]          ;
    Section last                ;  ///< Последняя зона (но это не точно)
    bool    is_timer            ;  ///< Флаг наличия таймера для последнего участка в разрешении
                                   ///< на движение (Q_ENDTIMER)
    bit:10  zone_expiration_time;  ///< Время валидности последнего участка в
                                   ///< разрешении на движение (T_ENDTIMER)
    bit:15  timer_start_distance;  ///< Расстояние от точки запуска таймера
                                   ///< последнего участка до точки окончания
                                   ///< разрешения на движение (D_ENDTIMERSTARTLOC)
    bool    is_danger_point     ;  ///< Флаг наличия данных опасной точки.
                                   ///< Устанавливается в 0 (Q_DANGERPOINT)
    bit:15  distance_from_auth  ;  ///< Расстояние от конца разрешения на движения
                                   ///< до опасной точки (D_DP)
    bit:7   danger_speed        ;  ///< Скорость опасной точки (V_RELEASEDP)
    bool    is_overlap          ;  ///< Флаг наличия перекрытия. Устанавливается в 0
                                   ///< (Q_OVERLAP)
    bit:15  distance_from_start ;  ///< Расстояние от точки старта таймера
                                   ///< перекрытия до точки окончания разрешения
                                   ///< на движения (D_STARTOL)
    bit:10  overlap_time        ;  ///< Время действия перекрытия (T_OL)
    bit:15  distance_from_end   ;  ///< Расстояние от конца разрешения на движения
                                   ///< до точки перекрытия (D_OL)
    bit:7   overlap_speed       ;  ///< Скорость перекрытия (V_RELEASEOL)
};

/**
 * Указ
 */
struct Order {
    bit:3  order_lvl   ; ///< Требуемый уровень управления (M_LEVELTR)
    bit:8  nid         ; ///< Идентификатор национальной системы. Устанавливается в 0
                         ///< Если M_LEVELTR = 1 (NID_NTC)
    bit:15 ack_distance; ///< Длина области подтверждения режима (L_ACKLEVELTR)
};

/**
 * Пакет 41 Level Transition Order
 * @brief Используется для изменения уровня управления
 */
struct LvlTransitionOrderPkg {
    bit:2  scale          ; ///< Шкала расстояний, устанавливается в 1 (Q_SCALE)
    bit:15 change_distance; ///< Расстояние до изменения режима (D_LEVELTR)
    Order  current        ; ///< Последний (наверное)
    Order  orders[]       ;
};

/**
 * Пакет 42 Session Management
 * @brief Используется для управления установки или завершения сеанса связи с
 * РБЦ
 */
struct SessionManagementPkg {
    RbcPkgHeader header;

    bool   control_flag; ///< Флаг управления сеансом связи (Q_RBC)
    bit:10 zone_id     ; ///< Идентификатор зоны (NID_C)
    bit:14 rbc_id      ; ///< Идентификатор РБЦ. Устанавливается в 16383 (NID_RBC)
    bit:64 rbc_num     ; ///< Номер РБЦ (NID_RADIO)
    bool   is_alive    ; ///< Флаг использования управления сессии. Устанавливается в
                         ///< 1 (Q_SLEEPSESSION)
};

/**
 * Пакет 44 Data used by applications outside the ERTMS/ETCS system
 * @brief Используется для передачи данных для приложений
 */
struct AppDataFromRbcPkg {
    RbcPkgHeader header;

    AppDataPkg appDataPkg;
    bit:32     zone      ;
    bit:16     balise_id ;
    bit:16     distance  ;
    bit:32     crc_32    ;
};

/**
 * Пакет 47 Shunting Command
 * @brief Используется для передачи команд на движение и контроля выполнения
 * маневровых операций
 */
struct ShuntingCommandPkg {
    RbcPkgHeader header;

    bit:7  operation   ; ///< Команда на выполнение операции маневровым
                         ///< локомотивом (Q_OPERATION)
    bit:7  directive   ; ///< Директива ДСП, в рамках которой выполняется операция
                         ///< (Q_DIRECTIVE)
    bit:2  move        ; ///< Команда на движение (Q_MOVE)
    bit:2  powoff      ; ///< Сигнал на разбор тяги и экстренное торможение (Q_POWOFF)
    bit:3  shunter_test; ///< Подтверждение от пульта составителя (Q_SHUNTER_TEST)
                         /// Расстояние команды на движение от последней пройденной бализы
    bit:32 zone        ; ///< ID_AREA
    bit:16 balise_id   ; ///< NID_BALISE
    bit:16 distance    ; ///< DISTANCE
    bit:32 crc_32      ; ///< CRC_32
    bit:14 brake_axis  ; ///< N_BRAKE_AXIS
    bit:14 train_weight; ///< M_TRAIN_WEIGHT
    bit:8  train_length; ///< L_TRAIN_CAR
};

struct Balise {
    bool  new_zone       ; ///< Флаг новой зоны (Q_NEWCOUNTRY)
    bit:10 zone_id        ; ///< Идентификатор зоны / региона (NID_C)
    bit:14 balise_group_id; ///< Идентификатор группы бализ (NID_BG)
};

/**
 * Пакет 63 List of Balises in SR Authorisation
 * @brief Используется для составления списка группы (групп) бализ, которые
 * поезд может проезжать в режиме SR
 */
struct ListOfBalisesInSrAuthPkg {
    RbcPkgHeader header;

    Balise balises[];
};

/**
 * Пакет 65 Temporary Speed Restriction
 * @brief Используется для передачи временных ограничений скорости.
 */
struct TemporarySpeedRestrPkg {
    bit:2  scale        ;  ///< Шкала расстояний, устанавливается в 1 (Q_SCALE)
    bit:8  restr_id     ;  ///< Идентификатор временного ограничения скорости (NID_TSR)
    bit:15 enable_dist  ;  ///< Расстояние до точки начала действия временного
                           ///< ограничения скорости (D_TSR)
    bit:15 active_dist  ;  ///< Длина временного ограничения скорости (L_TSR)
    bool  is_valid     ;  ///< Флаг валидности точки окончания профиля скорости
                           ///< (Q_FRONT)
    bit:7  allowed_speed;  ///< Разрешенная скорость временного ограничения
                           ///< скорости (V_TSR)
};

/**
 * Пакет 66 Temporary Speed Restriction Revocation
 * @brief Используется для отмены временных ограничений скорости
 */
struct TemporarySpeedRestrRevPkg {
    bit:8 restr_id; ///< Идентификатор временного ограничения скорости (NID_TSR)
};

/**
 * Пакет 101 Automatic locomotive signaling signals
 * @brief Используется для передачи информации о показаниях светофора/количества
 * свободных блок-участков и признака отклонения по стрелке. Не является частью
 * Euroradio
 */
struct AlsSignalsPkg {
    ObuPkgHeader header;

    bit:2  switch_als; ///< Признак отклонения по стрелке (M_SWITCH_ALS)
    bit:16 switch_id ; ///< Идентификатор стрелки (M_SWITCH_ID)
};

struct Category {
    bit:2 static_speed_profile_category; ///< Q_DIFF
    bit:4 cant_deficiency              ; ///< NC_CDDIFF (if Q_DIFF = 0)
    bit:4 other_category               ; ///< NC_DIFF (if Q_DIFF = 1 or 2)
    bit:7 absolute_positive_speed      ; ///< V_DIFF
};

struct SpeedProfile {
    bit:15   distance_to_next_discontinuity; ///< D_STATIC
    bit:7    basic_static_speed_profile    ; ///< V_STATIC
    bool    train_length_delay            ; ///< Q_FRONT
    Category categories[]                  ;
};

/**
 * Packet Number 27: International Static Speed Profile
 * @brief Static speed profile and optionally speed limits depending on the
 * international train category
 */
struct InternationalStaticSpeedProfile {
    bit:2        scale             ; ///< Шкала расстояний, устанавливается в 1 (Q_SCALE)
    SpeedProfile last_speed_profile;
    SpeedProfile speed_profiles[]  ;
};

struct Gradient {
    bit:15 incremental_distance; ///< D_GRADIENT
    bool  gradient_slope       ; ///< Q_GDIR 0 - downhill, 1 - uphill
    bit:8  gradient            ; ///< G_A
};

/**
 * Packet Number 21: Gradient Profile
 * @brief Transmission profile of the gradient.
 */
struct GradientProfile {
    Gradient last_gradient;
    Gradient gradients[]  ;
};

/**
 * Packet Number 102: Safety Related Data Object (SRDO)
 * @brief ASC safety data
 */
struct SrdoPkg {
    bit:64 timestamp;
    bit:32 size     ;
    string data     ;
};

