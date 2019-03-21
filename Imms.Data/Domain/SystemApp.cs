using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain{
    public class SystemApp:Entity<long>{
        public string SystemCode{get;set;}
        public string SystemName{get;set;}
        public string Ip{get;set;}
        public int Status{get;set;}
    }

    public class SysetmAppConfigure:EntityConfigure<SystemApp>{
        protected override void InternalConfigure(EntityTypeBuilder<SystemApp> builder){
            builder.ToTable("system_app");
            
            builder.Property(e=>e.SystemCode).HasColumnName("system_code");
            builder.Property(e=>e.SystemName).HasColumnName("system_name");
            builder.Property(e=>e.Ip).HasColumnName("ip");
            builder.Property(e=>e.Status).HasColumnName("status");
        }
    }
}