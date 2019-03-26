namespace Imms
{
    public static class GlobalConstants
    {
        //ϵͳ�쳣����
        public const int EXCEPTION_CODE_NO_ERROR = 0;
        public const int EXCEPTION_CODE_DATA_ALREADY_EXISTS = 1;
        public const int EXCEPTION_CODE_DATA_NOT_FOUND = 2;
        public const int EXCEPTION_CODE_NOT_EXCEPTED_DATA = 3;
        public const int EXCEPTION_CODE_DATA_REPEATED = 4;

        //���ݽ���:����
        public const string DATA_EXCHANGE_RULE__PRODUCITON_ORDER__APS_2_MES = "PRODUCITON_ORDER_APS_2_MES";
        public const string DATA_EXCHANGE_RULE__PRODUCITON_ORDER__CAD_2_MES = "PRODUCITON_ORDER_CAD_2_MES";
        public const string DATA_EXCHANGE_RULE__PRODUCITON_ORDER__GST_2_MES = "PRODUCITON_ORDER_GST_2_MES";
        //���ݽ�����ϵͳID
        public const int SYSTEM_ID_MES = 1;
        public const int SYSTEM_ID_APS = 2;
        public const int SYSTEM_ID_MCS = 3;
        public const int SYSTEM_ID_KANBAN = 4;

        //��֯��������
        public const string TYPE_ORG_PLANT = "PLANT";
        public const string TYPE_ORG_WORK_CENTER = "WORK_CENTER";
        public const string TYPE_ORG_WORK_LINE = "WORK_LINE";
        public const string TYPE_ORG_WORK_STATETION = "WORK_STATION";
        //��������
        public const string TYPE_CODE_TABLE_MATERIAL_UNIT = "MATERIAL_UNIT";
        public const string TYPE_CODE_TABLE_SIZE = "SIZE";
        public const string TYPE_CODE_TABLE_MACHINE_TYPE = "MACHINE_TYPE";               
        //������������
        public const int TYPE_PRODUCTION_ORDER_STANDARD = 0;
        public const int TYPE_PRODUCTION_ORDER_CUSTOM = 1;
        //���յ�����
        public const int TYPE_OPERATION_ORDER_MATERIAL = 10;
        public const int TYPE_OPERATION_ORDER_PRODUCTION = 11;
        public const int TYPE_OPERATION_ORDER_WORKORDER = 12;
        //BOM������
        public const int TYPE_BOM_ORDER_PART = 1;
        public const int TYPE_BOM_ORDER_STANDARD = 2;
        public const int TYPE_BOM_ORDER_ORDER = 3;
        public const int TYPE_BOM_ORDER_DESIGN = 4;
        public const int TYPE_BOM_ORDER_PRODUCTION_ORDER = 5;
        public const int TYPE_BOM_ORDER_WORK_ORDER = 6;
        //��������
        public const string TYPE_MATERIAL_KT = "KT";
        
        //BOM״̬
        public const int STATUS_BOM_ORDER_NORMAL = 0;
        public const int STATUS_BOM_ORDER_DEPRECATED = 1;

        //����������״̬
        public const int STATUS_PRODUCTION_ORDER_PLANNED = 0;
        public const int STATUS_PRODUCTION_ORDER_BOM_READY = 1;   //BOM��׼��
        public const int STATUS_PRODUCTION_ORDER_CUTTING_TECH_READY = 2; //�ü������ļ���׼��
        public const int STATUS_PRODUCTION_ORDER_ROUTING_READY = 4; //����������׼��
        public const int STATUS_PRODUCTION_ORDER_TECH_ALL_READY   //����������׼��
            = STATUS_PRODUCTION_ORDER_BOM_READY | STATUS_PRODUCTION_ORDER_CUTTING_TECH_READY | STATUS_PRODUCTION_ORDER_ROUTING_READY;
                
        //��ý��
        public const string MIME_MEDIA_FORMAT_JPEG = "image/jpeg";
        //ý������
        public const int MEDIA_TYPE_CUTTING_MARKER_CUT_MEDIA = 10;
        public const int MEDIA_TYPE_CUTTING_MARKER_CUT_FILE = 11;
        
        //������¼����
        public const int BELONG_TO_RECORD_TYPE_CUTTING_MARKER = 10;        
        public const int BELONG_TO_RECORD_TYPE_PRODUCTION_PATTERNIMAGES = 20;
              
        //����
        public static Imms.Data.IDbContextFactory DbContextFactory = null;
        public static Logger DefaultLogger = new Logger();
    }
}