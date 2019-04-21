using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Linq;

namespace Imms.WebFront.Api{
    [Route("api/[controller]")]
    [ApiController]
    public class TestController:ControllerBase
    {
        [HttpGet("GetAll")]
        public ActionResult<TestItem[]> GetAll(){
            return data;
        }

        private static readonly TestItem[] data=new TestItem[]{
            new TestItem(){id=1,name="刘永红"},
            new TestItem(){id=2,name="徐斯珍"},
            new TestItem(){id=3,name="刘施德"},
        };         
    }

    public class TestItem{
        public int id{get;set;}
        public string name{get;set;}
    }
}