using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class Media : TrackableEntity<long>
    {
        public string MediaFormat { get; set; }
        public string MediaUrl { get; set; }
        public string MediaName { get; set; }
        public int MediaSize { get; set; }
        public string Description { get; set; }
    }

    public class MediaConfigure : TrackableEntityConfigure<Media>
    {
        protected override void InternalConfigure(EntityTypeBuilder<Media> builder)
        {
            base.InternalConfigure(builder);
            builder.ToTable("media");

            builder.Property(e => e.Description).HasColumnName("description").HasMaxLength(250).IsUnicode(false);
            builder.Property(e => e.MediaName).IsRequired().HasColumnName("media_name").HasMaxLength(100).IsUnicode(false);
            builder.Property(e => e.MediaSize).HasColumnName("media_size").HasColumnType("int(11)");
            builder.Property(e => e.MediaFormat).HasColumnName("media_format");
            builder.Property(e => e.MediaUrl).IsRequired().HasColumnName("media_url").HasMaxLength(255).IsUnicode(false);
        }
    }
}
