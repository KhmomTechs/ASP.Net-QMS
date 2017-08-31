using System;

namespace Brian
{
    public class Person{
        public string Name;
        public int Id;

        public void Introduce(string to)
        {
            Console.WriteLine("Hi {0}, I am {1}", to, Name);
        }
    }

    class Program
    {
        static void Main(String[] args)
        {
            var person = new Person();
            person.Name = "John";
            person.Introduce("Mosh");
        }
    }
}

