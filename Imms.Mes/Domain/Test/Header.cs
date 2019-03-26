using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Text;

namespace Imms.Mes.Domain.Test
{
    public class Header
    {
        public int Id { get; set; }
        public string HeaderName { get; set; }
    }

    public class Body
    {
        public int Id { get; set; }
        public string BodyName { get; set; }

        public int HeaderId { get; set; }
        public Header Header { get; set; }
        public ICollection<Foot> Feet { get; set; } = new List<Foot>();
    }

    public class Foot
    {
        public int Id { get; set; }
        public string FootName { get; set; }

        public int BodyId { get; set; }
        public Body Body { get; set; }
    }

    public class HeaderConfigure : IEntityTypeConfiguration<Header>
    {
        public void Configure(EntityTypeBuilder<Header> builder)
        {
            builder.ToTable("header");
            builder.HasKey(e => e.Id);
            builder.Property(e => e.Id).HasColumnName("id");
            builder.Property(e => e.HeaderName).HasColumnName("header_name");
        }
    }

    public class BodyConfigure : IEntityTypeConfiguration<Body>
    {
        public void Configure(EntityTypeBuilder<Body> builder)
        {
            builder.ToTable("body");
            builder.HasKey(e => e.Id);
            builder.Property(e => e.Id).HasColumnName("id");
            builder.Property(e => e.BodyName).HasColumnName("body_name");
            builder.Property(e => e.HeaderId).HasColumnName("header_id");

            builder.HasOne(e => e.Header).WithMany().HasForeignKey(e => e.HeaderId).HasPrincipalKey(e=>e.Id).IsRequired();
         //   builder.HasMany(e => e.Feet).WithOne(e => e.Body).HasForeignKey(e => e.BodyId);
        }
    }

    public class FootConfigure : IEntityTypeConfiguration<Foot>
    {
        public void Configure(EntityTypeBuilder<Foot> builder)
        {
            builder.ToTable("foot");
            builder.HasKey(e => e.Id);
            builder.Property(e => e.Id).HasColumnName("id");
            builder.Property(e => e.FootName).HasColumnName("foot_name");
            builder.Property(e => e.BodyId).HasColumnName("body_id");

            builder.HasOne(e => e.Body).WithMany(e => e.Feet).HasForeignKey(e => e.BodyId).HasPrincipalKey(e=>e.Id).IsRequired();
        }
    }

    /*
    
       drop table header,body,foot;

        create table header
        (
            id     int  not null auto_increment,
		    header_name   varchar(20)   not null,
		
		    primary key(id)
        );

        create table body
        (
            id        int not null auto_increment,
		    body_name      varchar(20)  not null,		
		    header_id      int          not null,
		
		    primary key(id),
		    index idx_body_01(header_id)
        );

        create table foot
        (
            id       int not null auto_increment,
		    foot_name     varchar(20)   not null,
		    body_id       int           not null,
		
		    primary key(id),
		    index idx_foot_01(body_id)
        );   

        insert into header(header_name) values('头A');
        insert into header(header_name) values('头B');
        insert into body(body_name,header_id) values('身A',1);
        insert into foot(foot_name,body_id) values('左脚A',1);
        insert into foot(foot_name,body_id) values('右脚A',1);

     */
}
