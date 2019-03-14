using Microsoft.EntityFrameworkCore;

namespace Imms.Core.Data{
    public partial class ImmsContext:DbContext{
         protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder){
             optionsBuilder.UseMySQL("");
         }
    }
}