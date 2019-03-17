using System;
using Xunit;

namespace Imms.Test
{
    public class DbContextTest
    {
        [Fact]
        public void Test2()
        {
            Imms.Data.Class1 test_01 = new Imms.Data.Class1();
            // test_01.TestInsert_01(4);
            test_01.TestInsert_02();
        }

        [Fact]
        public void Test1()
        {
            Assert.True(true);
        }

        // [Theory]
        // [InlineData(3, 3, 6)]
        // public void Test1(int a, int b, int c)
        // {
        //     System.Console.WriteLine($"This is the method Test1,The data is a:{a},b:{b},c:{c}");
        //     Assert.Equal(c, a + b);
        // }
    }
}
