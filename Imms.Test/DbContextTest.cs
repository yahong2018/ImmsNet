using System;
using Xunit;

namespace Imms.Test
{
    public class DbContextTest
    {
        [Theory]
        [InlineData(1, 1, 2)]
        [InlineData(2, 3, 5)]
        public void Test2(int a, int b, int c)
        {
            System.Console.WriteLine($"The data is a:{a},b:{b},c:{c}");
            Assert.Equal(c, a + b);
        }

        [Theory]
        [InlineData(3, 3, 6)]
        public void Test1(int a, int b, int c)
        {
            System.Console.WriteLine($"This is the method Test1,The data is a:{a},b:{b},c:{c}");
            Assert.Equal(c, a + b);
        }
    }
}
