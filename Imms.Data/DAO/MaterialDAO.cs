using Imms.Data.Domain;
using System.Linq;

namespace Imms.Data.DAO
{
    public class MaterialDAO
    {
        public static Material GetByMaterialCode(string materialCode)
        {
            using (ImmsDbContext dbContext = new ImmsDbContext())
            {
                var result = (from m in dbContext.Material where m.MaterialNo == materialCode select m);
                if (result.Count() > 0)
                {
                    return result.First();
                }
                return null;
            }
        }
    }
}