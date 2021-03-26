using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TSQL_Csharp_Test
{
    class HashJoin
    {
        class CustomHashTable
        {
            int _bucketCount;
            List<int>[] _buckets;

            public CustomHashTable(int bucketCount = 100)
            {
                _bucketCount = bucketCount;
                _buckets = new List<int>[bucketCount];
                for (int i = 0; i < bucketCount; ++i)
                    _buckets[i] = new List<int>();
            }

            public void Add(int value)
            {
                int key = value % _bucketCount; // Hash func
                _buckets[key].Add(value);
            }

            public bool Find(int value)
            {
                int key = value % _bucketCount; // Hash func
                //_buckets[key].Contains(value);
                // or
                foreach(int v in _buckets[key])
                {
                    if (v == value)
                        return true;
                }
                return false;
            }
        }

        static void Main(string[] args)
        {
            Random rand = new Random();

            List<Player> players = new List<Player>();
            for (int i = 0; i < 10000; ++i)
            {
                if (rand.Next(0, 2) == 0)
                    continue;

                players.Add(new Player() { playerId = i });
            }

            List<Salary> salaries = new List<Salary>();
            for (int i = 0; i < 10000; ++i)
            {
                if (rand.Next(0, 2) == 0)
                    continue;

                salaries.Add(new Salary() { playerId = i });
            }

            // Hash Join -> TEMP HashTable 이용 == List를 순회하면서 hash table에 저장
            // NL과의 차이 : hash table의 생성 여부
            //Dictionary<int, Salary> hash = new Dictionary<int, Salary>();
            CustomHashTable hash = new CustomHashTable();
            foreach(Salary s in salaries)
            {
                hash.Add(s.playerId); 
            }

            List<int> result = new List<int>();
            foreach (Player p in players)
            {
                if (hash.Find(p.playerId))
                    result.Add(p.playerId);
            }
        }
    }
}
