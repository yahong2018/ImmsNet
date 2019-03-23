using System;
using System.Collections.Generic;
using System.Text;

namespace Imms
{
    public class BusinessException:Exception
    {
        public BusinessException()
        {
        }

        public BusinessException(int exceptionCode)
        {
            this.ExceptionCode = exceptionCode;
        }

        public BusinessException(int exceptionCode,string message):base(message)
        {
            this.ExceptionCode = exceptionCode;
        }

        public int ExceptionCode { get; set; }
    }
}
