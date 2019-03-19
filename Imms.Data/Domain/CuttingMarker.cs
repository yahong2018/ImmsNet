using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Data.Domain
{
    public partial class CuttingMarker : TrackableEntity<long>
    {
        public long CuttingOrderId { get; set; }
        public long? MediaId { get; set; }
        public string Remark { get; set; }
        public long? MarkerFileId { get; set; }
    }

    public class CuttingMarkerConfigure : TrackableEntityConfigure<CuttingMarker>
    {
        protected override void InternalConfigure(EntityTypeBuilder<CuttingMarker> builder)
        {
            base.InternalConfigure(builder);

            builder.ToTable("cutting_marker");
            builder.Property(e => e.CuttingOrderId).HasColumnName("cutting_order_id");
            builder.Property(e => e.MarkerFileId).HasColumnName("marker_file_id");
            builder.Property(e => e.MediaId).HasColumnName("media_id");
            builder.Property(e => e.Remark).HasColumnName("remark").HasMaxLength(255);
        }
    }
}
