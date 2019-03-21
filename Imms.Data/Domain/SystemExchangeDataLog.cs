using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public class SystemExchangeDataLog:Entity<long>
    {
        public string ExchangeRuleCode{get;set;}
        public Guid MessageId{get;set;}
        public string SrcIp{get;set;}
        public string DestIp{get;set;}
        public DateTime CreateTime{get;set;}
        public DateTime ReceiveTime{get;set;}
        public DateTime SendTime{get;set;}
        public string RawData{get;set;}
    }

    public class SystemExchangeDataLogConfigure:EntityConfigure<SystemExchangeDataLog>{
        protected override void InternalConfigure(EntityTypeBuilder<SystemExchangeDataLog> builder){
            builder.ToTable("system_exchange_data_log");
            
            builder.Property(e=>e.ExchangeRuleCode).HasColumnName("exchange_rule_code");
            builder.Property(e=>e.MessageId).HasColumnName("message_id");
            builder.Property(e=>e.SrcIp).HasColumnName("src_ip");
            builder.Property(e=>e.DestIp).HasColumnName("dest_ip");
            builder.Property(e=>e.CreateTime).HasColumnName("create_time");
            builder.Property(e=>e.ReceiveTime).HasColumnName("receive_time");
            builder.Property(e=>e.SendTime).HasColumnName("send_time");
            builder.Property(e=>e.RawData).HasColumnName("raw_data");
        }
    }
}