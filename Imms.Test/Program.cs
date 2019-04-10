using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes;
using Imms.Mes.Domain.Test;
using Imms.Mes.MasterData;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using System;
using System.Linq;
using System.Transactions;

namespace Imms.Test
{

    class Program
    {
        static void Main(string[] args)
        {
            new OrgQueryTest().TestOrganization();

            Console.Read();
        }       
    }
}
