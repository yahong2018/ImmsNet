using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace Imms
{
    public static class GlobalConstants
    {
        //数据操作
        public const int DML_OPERATION_INSERT = 0;
        public const int DML_OPERATION_UPDATE = 10;
        public const int DML_OPERATION_DELETE = 100;
        public const int DML_OPERATION_LOAD = 127;

        //系统异常代码
        public const int EXCEPTION_CODE_NO_ERROR = 0; //无异常
        public const int EXCEPTION_CODE_DATA_ALREADY_EXISTS = 1;//数据已经存在
        public const int EXCEPTION_CODE_DATA_NOT_FOUND = 2;//数据没有找到
        public const int EXCEPTION_CODE_NOT_EXCEPTED_DATA = 3;//非预期数据
        public const int EXCEPTION_CODE_DATA_REPEATED = 4;  //数据重复
        public const int EXCEPTION_CODE_PARAMETER_INVALID = 5;  //参数错误
        public const int EXCEPTION_CODE_EXISTS_RELATED_ITEMS = 6; //存在有相关项，不能删除
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
        public const string TYPE_ORG_PLANT = "ORG_LANT";
        public const string TYPE_ORG_WORK_CENTER = "ORG_WORK_CENTER";
        public const string TYPE_ORG_WORK_LINE = "ORG_WORK_LINE";
        public const string TYPE_ORG_WORK_STATETION = "ORG_WORK_STATION";

        //组织架构参数
        //public const string TYPE_ORG_PARAMETER_TYPE_WORK_STATION_TYPE = "WORK_STATION_TYPE";  //工位类型
        //public const string TYPE_ORG_PARAMETER_TYPE_STATUS_IS_ON_LINE = "STATUS_IS_ON_LINE";  //离线|在线
        //public const string TYPE_ORG_PARAMETER_TYPE_WORK_STATION_DEVICE_TYPE = "WORK_STATION_DEVICE_TYPE"; //工位的机器类型

        //组织架构参数的值
        public const string VALUE_ORG_PARAMETER_STATUS_ON_LINE = "OFF_LINE"; //离线
        public const string VALUE_ORG_PARAMETER_STATUS_OFF_LINE = "OFF_LINE"; //离线

        //编码类型        
        public const string TYPE_CODE_TYPE_EQUIPMENT_TYPE = "EQUIPMENT_TYPE";//设备类型      
        public const string TYPE_CODE_TYPE_MATERIAL_TYPE = "MATERIAL_TYPE";  //物料类型

        //树形编码
        public const string TYPE_CODE_TYPE_DEFECT = "TREE_CODE_TYPE_DEFECT";//缺陷代码


        //生产订单类型
        public const int TYPE_PRODUCTION_ORDER_STANDARD = 0;
        public const int TYPE_PRODUCTION_ORDER_CUSTOM = 1;
        //工艺单类型
        public const int TYPE_OPERATION_ROUTING_ORDER_MATERIAL = 10;
        public const int TYPE_OPERATION_ROUTING_ORDER_PRODUCTION = 11;
        public const int TYPE_OPERATION_ROUTING_ORDER_WORKORDER = 12;
        //领料单类型
        public const int TYPE_PICKING_ORDER_CUTTING = 30;
        public const int TYPE_PICKING_ORDER_STITCH = 31;
        //BOM单类型
        public const int TYPE_BOM_ORDER_PART = 10;      //部件BOM
        public const int TYPE_BOM_ORDER_STANDARD = 20;  //标准BOM
        public const int TYPE_BOM_ORDER_ORDER = 30;     //订单BOM
        public const int TYPE_BOM_ORDER_DESIGN = 40;    //设计BOM
        public const int TYPE_BOM_ORDER_PRODUCTION_ORDER = 50; //生产订单BOM        
        public const int TYPE_BOM_ORDER_PICKING_ORDER = 60;   // 领料单BOM
        public const int TYPE_BOM_ORDER_WORK_ORDER = 70;    // 作业单BOM
        //BOM类型
        public const int TYPE_BOM_UNKNOWN = 0;   //未知的BOM类型：面料或者辅料
        public const int TYPE_BOM_FABRIC = 1;   //面料
        public const int TYPE_BOM_MAIN_FABRIC = 3;//主面料        

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

        //尺码类型
        public const int TYPE_SIZE_TYPE_DIMENSION = 0;  //尺寸
        public const int TYPE_SIZE_TYPE_YARD = 1; //尺码
        public const int TYPE_SIZE_TYPE_TOP = 2;//上装
        public const int TYPE_SIZE_TYPE_BOTTOM = 3;//下装

        //物料类型
        public const string TYPE_MATERIAL_TYPE_STANDARD = "Z001";  //基准款
        public const string TYPE_MATERIAL_TYPE_PART = "Z002";//部件
        public const string TYPE_MATERIAL_TYPE_ABSTRACT_MATERIAL = "Z003"; //抽象材料
        public const string TYPE_MATERIAL_GARMENT = "Z004";//成品-大货
        public const string TYPE_MATERIAL_FABRIC = "Z005"; //面料
        public const string TYPE_MATERIAL_TYPE_ACCESSORY = "Z006"; //辅料
        public const string TYPE_MATERIAL_PACKING = "Z007"; //包装材料
        public const string TYPE_MATERIAL_LINING = "Z008";//里布
        public const string TYPE_MATERIAL_INTER_LINING = "Z009";//衬布
        
        //BOM状态
        public const int STATUS_DOCUMENT_NORMAL = 0;
        public const int STATUS_DOCUMENT_DEPRECATED = 1;

        //订单通用状态
        public const int STATUS_ORDER_INITIATE = 0;   //初始状态 *
        public const int STATUS_ORDER_PLANNED = 1;    //已计划
        public const int STATUS_ORDER_FINISHED = int.MaxValue; //已完成   

        //生产订单状态
        public const int STATUS_PRODUCTION_ORDER_BOM_READY = 2;   //BOM已准备
        public const int STATUS_PRODUCTION_ORDER_CUTTING_TECH_READY = 4; //裁剪技术文件已准备
        public const int STATUS_PRODUCTION_ORDER_ROUTING_READY = 8; //生产工艺已准备
        public const int STATUS_PRODUCTION_ORDER_TECH_ALL_READY   //生产技术已全部准备   二进制的1111，十进制15   *
            = STATUS_ORDER_PLANNED | STATUS_PRODUCTION_ORDER_BOM_READY | STATUS_PRODUCTION_ORDER_CUTTING_TECH_READY | STATUS_PRODUCTION_ORDER_ROUTING_READY;
        public const int STATUS_PRODUCTION_ORDER_PICKING = 16;    //已开始领料 *
        public const int STATUS_PRODUCTION_ORDER_PICKED = 32;    //已完成领料  *
        public const int STATUS_PRODUCTION_ORDER_CUTTING = 64;    //已开始裁剪  *
        public const int STATUS_PRODUCTION_ORDER_CUTTED = 128;    //已完成裁剪  *
        public const int STATUS_PRODUCTION_ORDER_HANGING = 256;   //已开始上裁片  *
        public const int STATUS_PRODUCTION_ORDER_HANGED = 512;    //已完成上裁片  *
        public const int STATUS_PRODUCTION_ORDER_SEWING = 1024;    //已开始缝制   *
        public const int STATUS_PRODUCTION_ORDER_SEWED = 2048;    //已完成缝制    *

        //领料单
        public const int STATUS_PICKING_ORDER_PREPARED = STATUS_PRODUCTION_ORDER_PICKING; //物料已准备好 | 开始领料   

        //裁剪单
        public const int STATUS_CUTTING_ORDER_CUTTING = STATUS_PRODUCTION_ORDER_CUTTING;  //开始裁剪

        //多媒体
        public const string MIME_MEDIA_FORMAT_JPEG = "image/jpeg";
        //媒体类型
        public const int MEDIA_TYPE_CUTTING_MARKER_CUT_MEDIA = 10;
        public const int MEDIA_TYPE_CUTTING_MARKER_CUT_FILE = 11;

        //旋转方向
        public const int DIRECTION_ROTATE_CLOCK_WISE = 0;  //顺时针
        public const int DIRECTION_ROTATE_ANTI_CLOCK_WISE = 1;//逆时针
        //方位
        public const int DIRECTON_LEFT = 0; //左边
        public const int DIRECTON_RIGHT = 1;//右边

        //男/女
        public const int GENDER_MALE = 0; //男
        public const int GENDER_FEMAIL = 1;//女

        //其他
        public static Imms.Data.IDbContextFactory DbContextFactory = null;
        public static Logger DefaultLogger = new Logger();

        //系统当前用户
        public static CurrentUserGetHandler CurrentUserGetFunction = null;
        public static Imms.Data.Domain.SystemUser GetCurrentUser()
        {
            return CurrentUserGetFunction();
        }

        public static void ModifyEntityStatus<T>(T item, DbContext dbContext) where T : class
        {
            EntityEntry<T> entry = dbContext.Entry<T>(item); // dbContext.Attach<T>(item);
            entry.State = EntityState.Modified;
        }

        //系统编码
        public static readonly string DEFAULT_CHARSET = System.Environment.GetEnvironmentVariable("DEFAULT_CHARSET", EnvironmentVariableTarget.User);
        public static readonly System.Text.Encoding DEFAULT_ENCODING;
        static GlobalConstants()
        {
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            if (string.IsNullOrEmpty(DEFAULT_CHARSET))
            {
                DEFAULT_ENCODING = System.Text.Encoding.Default;
            }
            else
            {
                DEFAULT_ENCODING = System.Text.Encoding.GetEncoding(DEFAULT_CHARSET);
            }

            JsonConvert.DefaultSettings = ()=> new JsonSerializerSettings()
            {
                ContractResolver = new DefaultContractResolver
                {
                    NamingStrategy = new CamelCaseNamingStrategy()
                },
                Formatting = Formatting.Indented,
                ReferenceLoopHandling = ReferenceLoopHandling.Ignore
            };
        }

        //
        //序列化
        //
        public static string ToJson(this object obj)
        {
            string result = JsonConvert.SerializeObject(obj);
            return result;
        }

        //
        //反序列化
        //
        public static T ToObject<T>(this string jsonStr)
        {
            T result = JsonConvert.DeserializeObject<T>(jsonStr);

            return result;
        }

        //
        //反序列化
        //
        public static object ToObject(this string jsonStr, Type type)
        {
            object result = JsonConvert.DeserializeObject(jsonStr, type);

            return result;
        }

        //
        //从文件反序列化
        //
        public static T LoadBeanFromFile<T>(this string fileName)
        {
            string gstJson = System.IO.File.ReadAllText(fileName);           
            T result = JsonConvert.DeserializeObject<T>(gstJson);
            return result;
        }
    }

    public delegate Imms.Data.Domain.SystemUser CurrentUserGetHandler();
}