using Microsoft.EntityFrameworkCore;

namespace Imms.Data{
    public interface IDbContextFactory{        
        DbContext GetContext();
        DbContext GetContext(string connectionString);        
    }
}