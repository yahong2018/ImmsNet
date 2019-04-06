using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{   
    public class DataExchangeTask : Entity<long>
    {
        public string ExchangeRuleCode { get; set; }
        public Guid MessageId { get; set; }
        public string SrcIp { get; set; }
        public string DestIp { get; set; }
        public DateTime CreateTime { get; set; }
        public DateTime ReceiveTime { get; set; }
        public DateTime SendTime { get; set; }
        public string RawData { get; set; }
        public int TaskStatus { get; set; }
    }

     public class DataExcahngeRule:Entity<long>{
        public string ExchangeRuleCode{get;set;}
        public long SrcSystemId{get;set;}
        public long DestSystemId{get;set;}
        public int DataFormat{get;set;}
        public int Status{get;set;}
    }

    public class SystemApp:Entity<long>{
        public string SystemCode{get;set;}
        public string SystemName{get;set;}
        public string Ip{get;set;}
        public int Status{get;set;}
    }

    public class SysetmAppConfigure:EntityConfigure<SystemApp>{
        protected override void InternalConfigure(EntityTypeBuilder<SystemApp> builder){
            base.InternalConfigure(builder);

            builder.ToTable("system_app");            
            builder.Property(e=>e.SystemCode).HasColumnName("system_code");
            builder.Property(e=>e.SystemName).HasColumnName("system_name");
            builder.Property(e=>e.Ip).HasColumnName("ip");
            builder.Property(e=>e.Status).HasColumnName("status");
        }
    }

    public class DataExchangeRuleConfigure:EntityConfigure<DataExcahngeRule>{
        protected override void InternalConfigure(EntityTypeBuilder<DataExcahngeRule> builder){
            base.InternalConfigure(builder);

            builder.ToTable("data_exchange_rule");
            builder.Property(e=>e.ExchangeRuleCode).HasColumnName("exchange_rule_code");
            builder.Property(e=>e.SrcSystemId).HasColumnName("src_system_id");
            builder.Property(e=>e.DestSystemId).HasColumnName("dest_system_id");
            builder.Property(e=>e.DataFormat).HasColumnName("data_format");
            builder.Property(e=>e.Status).HasColumnName("status");
        }
    }

    public class DataExcahngeConfigure : EntityConfigure<DataExchangeTask>
    {
        protected override void InternalConfigure(EntityTypeBuilder<DataExchangeTask> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("data_exchange_task");

            builder.Property(e => e.ExchangeRuleCode).HasColumnName("exchange_rule_code");
            builder.Property(e => e.MessageId).HasColumnName("message_id");
            builder.Property(e => e.SrcIp).HasColumnName("src_ip");
            builder.Property(e => e.DestIp).HasColumnName("dest_ip");
            builder.Property(e => e.CreateTime).HasColumnName("create_time");
            builder.Property(e => e.ReceiveTime).HasColumnName("receive_time");
            builder.Property(e => e.SendTime).HasColumnName("send_time");
            builder.Property(e => e.RawData).HasColumnName("raw_data");
            builder.Property(e => e.TaskStatus).HasColumnName("task_status");
        }
    }
}