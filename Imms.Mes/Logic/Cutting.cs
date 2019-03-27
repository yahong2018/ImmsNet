using System.Linq;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Imms.Data;
using Imms.Data.Domain;
using Imms.Mes.Domain;

namespace Imms.Mes.Logic
{
    public class Cutting
    {
        public void PlanCuttingOrder(CuttingOrder cuttingOrder)
        {
            CommonDAO.Update<CuttingOrder>(cuttingOrder,handlerBeforeUpdate:(order,dmlType,dbContext)=>{
                
            },handlerAfterUpdate:(order,dmlType,dbContext)=>{
                
            });
        }
    }
}