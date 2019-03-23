using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain{
    public class ThirdPartDataExcahngeRule:Entity<long>{
        public string ExchangeRuleCode{get;set;}
        public long SrcSystemId{get;set;}
        public long DestSystemId{get;set;}
        public int DataFormat{get;set;}
        public int Status{get;set;}
    }

    public class ThirdPartDataExchangeRuleConfigure:EntityConfigure<ThirdPartDataExcahngeRule>{
        protected override void InternalConfigure(EntityTypeBuilder<ThirdPartDataExcahngeRule> builder){
            base.InternalConfigure(builder);

            builder.ToTable("third_part_data_exchange_rule");
            builder.Property(e=>e.ExchangeRuleCode).HasColumnName("exchange_rule_code");
            builder.Property(e=>e.SrcSystemId).HasColumnName("src_system_id");
            builder.Property(e=>e.DestSystemId).HasColumnName("dest_system_id");
            builder.Property(e=>e.DataFormat).HasColumnName("data_format");
            builder.Property(e=>e.Status).HasColumnName("status");
        }
    }
}