using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Imms.Data.Domain;

namespace Imms.Mes.Domain
{   
    public class Plant : WorkOrganizationUnit
    {
        [NotMapped]
        public string PlantCode { get { return base.OrganizationCode; } set { base.OrganizationCode = value; } }
        [NotMapped]
        public string PlantName { get { return base.OrganizationName; } set { base.OrganizationName = value; } }
    }

    public class WorkCenter : WorkOrganizationUnit
    {
        [NotMapped]
        public string WorkStationCode { get { return base.OrganizationCode; } set { base.OrganizationCode = value; } }
        [NotMapped]
        public string WorkStationName { get { return base.OrganizationName; } set { base.OrganizationName = value; } }
    }

    public class WorkOrganizationUnitConfigure : IEntityTypeConfiguration<WorkOrganizationUnit>
    {
        public void Configure(EntityTypeBuilder<WorkOrganizationUnit> builder)
        {
            builder.HasDiscriminator("organization_type",typeof(string))
            .HasValue<Plant>(GlobalConstants.ORG_TYPE_PLANT)
            .HasValue<WorkCenter>(GlobalConstants.ORG_TYPE_WORK_CENTER);            
        }
    }
}

