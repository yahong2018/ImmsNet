namespace Imms
{
    public static class GlobalConstants
    {
        public const string DATA_EXCHANGE_RULE__PRODUCITON_ORDER__APS_2_MES = "PRODUCITON_ORDER_APS_2_MES";
        public const string DATA_EXCHANGE_RULE__PRODUCITON_ORDER__CAD_2_MES = "PRODUCITON_ORDER_CAD_2_MES";

        public const string ORG_TYPE_PLANT = "PLANT";
        public const string ORG_TYPE_WORK_CENTER = "WORK_CENTER";
        public const string ORG_TYPE_WORK_LINE = "WORK_LINE";
        public const string ORG_TYPE_WORK_STATETION = "WORK_STATION";

        public const string CODE_TABLE_TYPE_MATERIAL_UNIT = "MATERIAL_UNIT";
        public const string CODE_TABLE_TYPE_SIZE = "SIZE";

        public const int EXCEPTION_CODE_NO_ERROR = 0;
        public const int EXCEPTION_CODE_DATA_ALREADY_EXISTS = 1;
        public const int EXCEPTION_CODE_DATA_NOT_FOUND = 1;

        public const int BOM_ORDER_TYPE_PART = 1;
        public const int BOM_ORDER_TYPE_STANDARD = 2;
        public const int BOM_ORDER_TYPE_ORDER = 3;
        public const int BOM_ORDER_TYPE_DESIGN = 4;
        public const int BOM_ORDER_TYPE_PRODUCTION_ORDER = 5;
        public const int BOM_ORDER_TYPE_WORK_ORDER = 6;

        public const int BOM_ORDER_STATUS_NORMAL = 0;
        public const int BOM_ORDER_STATUS_DEPRECATED = 1;

        public const int SYSTEM_ID_MES = 1;
        public const int SYSTEM_ID_APS = 2;
        public const int SYSTEM_ID_MCS = 3;
        public const int SYSTEM_ID_KANBAN = 4;

        public static Imms.Data.IDbContextFactory DbContextFactory=null;
        public static Logger DefaultLogger = new Logger();
    }
}