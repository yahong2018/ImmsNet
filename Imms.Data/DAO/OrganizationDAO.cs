using Imms.Data.Domain;
using System.Linq;

namespace Imms.Data.DAO
{
    public static class OrganizationDAO
    {
        public static Plant GetPlantByCode(string code)
        {
            using (ImmsDbContext dbContext = new ImmsDbContext())
            {
                return (from item in dbContext.Plants where item.OrganizationCode == code select item).FirstOrDefault();
            }
        }
    }
}