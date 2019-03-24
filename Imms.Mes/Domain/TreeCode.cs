using System.ComponentModel.DataAnnotations.Schema;
using Imms.Data;
using Imms.Data.Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Imms.Mes.Domain
{
    public class Size : TreeCode
    {
        [NotMapped]
        public string SizeCode { get { return base.CodeNo; } set { base.CodeNo = value; } }
        [NotMapped]
        public string SizeName { get { return base.CodeName; } set { base.CodeName = value; } }
    }

    public class MachineType : TreeCode
    {
        [NotMapped]
        public string MachineTypeNo { get { return base.CodeNo; } set { base.CodeNo = value; } }
        [NotMapped]
        public string MachineTypeName { get { return base.CodeName; } set { base.CodeName = value; } }
    }

    public class TreeCodeConfigure : TrackableEntityConfigure<TreeCode>
    {
        protected override void InternalConfigure(EntityTypeBuilder<TreeCode> builder)
        {
            builder.HasDiscriminator("code_type", typeof(string))
                .HasValue<Size>(GlobalConstants.CODE_TABLE_TYPE_SIZE)
                .HasValue<MachineType>(GlobalConstants.CODE_TABLE_TYPE_MACHINE_TYPE)
                ;
        }
    }
}