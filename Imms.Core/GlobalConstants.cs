namespace Imms
{
    public static class GlobalConstants
    {
        //数据操作
        public const int DML_OPERATION_INSERT = 0;
        public const int DML_OPERATION_UPDATE = 10;
        public const int DML_OPERATION_DELETE = 100;

        //系统异常代码
        public const int EXCEPTION_CODE_NO_ERROR = 0; //无异常
        public const int EXCEPTION_CODE_DATA_ALREADY_EXISTS = 1;//数据已经存在
        public const int EXCEPTION_CODE_DATA_NOT_FOUND = 2;//数据没有找到
        public const int EXCEPTION_CODE_NOT_EXCEPTED_DATA = 3;//非预期数据
        public const int EXCEPTION_CODE_DATA_REPEATED = 4;  //数据重复
        public const int EXCEPTION_CODE_CUSTOM = int.MaxValue; //业务逻辑自定义的异常

        //数据交换:规则
        public const string DATA_EXCHANGE_RULE__PRODUCITON_ORDER__APS_2_MES = "PRODUCITON_ORDER_APS_2_MES";
        public const string DATA_EXCHANGE_RULE__PRODUCITON_ORDER__CAD_2_MES = "PRODUCITON_ORDER_CAD_2_MES";
        public const string DATA_EXCHANGE_RULE__PRODUCITON_ORDER__GST_2_MES = "PRODUCITON_ORDER_GST_2_MES";
        //数据交换：系统ID
        public const int SYSTEM_ID_MES = 1;
        public const int SYSTEM_ID_APS = 2;
        public const int SYSTEM_ID_MCS = 3;
        public const int SYSTEM_ID_KANBAN = 4;

        //组织机构类型
        public const string TYPE_ORG_PLANT = "PLANT";
        public const string TYPE_ORG_WORK_CENTER = "WORK_CENTER";
        public const string TYPE_ORG_WORK_LINE = "WORK_LINE";
        public const string TYPE_ORG_WORK_STATETION = "WORK_STATION";
        //编码类型
        public const string TYPE_CODE_TABLE_MATERIAL_UNIT = "MATERIAL_UNIT";
        public const string TYPE_CODE_TABLE_SIZE = "SIZE";
        public const string TYPE_CODE_TABLE_MACHINE_TYPE = "MACHINE_TYPE";
        //生产订单类型
        public const int TYPE_PRODUCTION_ORDER_STANDARD = 0;
        public const int TYPE_PRODUCTION_ORDER_CUSTOM = 1;
        //工艺单类型
        public const int TYPE_OPERATION_ORDER_MATERIAL = 10;
        public const int TYPE_OPERATION_ORDER_PRODUCTION = 11;
        public const int TYPE_OPERATION_ORDER_WORKORDER = 12;
        //BOM单类型
        public const int TYPE_BOM_ORDER_PART = 1;
        public const int TYPE_BOM_ORDER_STANDARD = 2;
        public const int TYPE_BOM_ORDER_ORDER = 3;
        public const int TYPE_BOM_ORDER_DESIGN = 4;
        public const int TYPE_BOM_ORDER_PRODUCTION_ORDER = 5;
        public const int TYPE_BOM_ORDER_WORK_ORDER = 6;
        //物料类型
        public const string TYPE_MATERIAL_KT = "KT";
        //工位类型        
        public const string TYPE_WORK_STATION_CUTTING = "CUTTING"; //裁剪
        public const string TYPE_WORK_STATION_HANGING = "HANGING"; //上吊挂
        public const string TYPE_WORK_STATION_STITCHING = "STITCHING"; //缝制
        public const string TYPE_WORK_STATION_QUALITY = "QUALITY"; //质检
        public const string TYPE_WORK_STATION_PACK = "PACK";//包装
        public const string TYPE_WORK_STATION_PRINTING = "PRINTING"; // 印染
        public const string TYPE_WORK_STATION_CUTTINGPRINTER = "CUTTINGPRINTER"; // 实样切割打印机     
        public const string TYPE_WORK_STATION_PICKING = "PICKING";// 领料工位

        //BOM状态
        public const int STATUS_BOM_ORDER_NORMAL = 0;
        public const int STATUS_BOM_ORDER_DEPRECATED = 1;

        //订单通用状态
        public const int STATUS_ORDER_INITIATE = 0;   //初始状态
        public const int STATUS_ORDER_PLANNED = 1;    //已计划
        public const int STATUS_ORDER_FINISHED = int.MaxValue; //已完成

        //生产订单状态
        public const int STATUS_PRODUCTION_ORDER_BOM_READY = 2;   //BOM已准备
        public const int STATUS_PRODUCTION_ORDER_CUTTING_TECH_READY = 4; //裁剪技术文件已准备
        public const int STATUS_PRODUCTION_ORDER_ROUTING_READY = 8; //生产工艺已准备
        public const int STATUS_PRODUCTION_ORDER_TECH_ALL_READY   //生产技术已全部准备   二进制的1111，十进制15
            = STATUS_PRODUCTION_ORDER_BOM_READY | STATUS_PRODUCTION_ORDER_CUTTING_TECH_READY | STATUS_PRODUCTION_ORDER_ROUTING_READY;
        public const int STATUS_PRODUCTION_ORDER_PICKING = 16;    //已开始（完成）领料
        public const int STATUS_PRODUCTION_ORDER_CUTTING = 32;    //已开始（完成）裁剪
        public const int STATUS_PRODUCTION_ORDER_HANGING = 64;    //已开始（完成）上裁片
        public const int STATUS_PRODUCTION_ORDER_SEWING = 128;    //已开始（完成）缝制

        //多媒体
        public const string MIME_MEDIA_FORMAT_JPEG = "image/jpeg";
        //媒体类型
        public const int MEDIA_TYPE_CUTTING_MARKER_CUT_MEDIA = 10;
        public const int MEDIA_TYPE_CUTTING_MARKER_CUT_FILE = 11;

        //附件记录类型
        public const int BELONG_TO_RECORD_TYPE_CUTTING_MARKER = 10;
        public const int BELONG_TO_RECORD_TYPE_PRODUCTION_PATTERNIMAGES = 20;

        //其他
        public static Imms.Data.IDbContextFactory DbContextFactory = null;
        public static Logger DefaultLogger = new Logger();

        //系统当前用户
        public static CurrentUserGetHandler CurrentUserGetFunction = null;
        public static Imms.Data.Domain.SystemUser GetCurrentUser()
        {
            return CurrentUserGetFunction();
        }
    }

    public delegate Imms.Data.Domain.SystemUser CurrentUserGetHandler();
}