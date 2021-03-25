using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TSQL_Csharp_Test
{
    class NLJoin
    {
        static void Main(string[] args)
        {
            Random rand = new Random();

            List<Player> players = new List<Player>();
            for (int i = 0; i < 1000; ++i)
            {
                if (rand.Next(0, 2) == 0)
                    continue;

                players.Add(new Player() { playerId = i });
            }

            //List<Salary> salaries = new List<Salary>();
            Dictionary<int, Salary> salaries = new Dictionary<int, Salary>();
            for (int i = 0; i < 1000; ++i)
            {
                if (rand.Next(0, 2) == 0)
                    continue;

                salaries.Add(i, new Salary() { playerId = i });
            }

            // Q) ID가 players에도 있고, salaries에도 있는 정보를 추출?
            List<int> result = new List<int>();

            // A1) 이중 for문을 이용한 O(N^2) 방식, Nested Loop
            //foreach (Player p in players)
            //{
            //    foreach (Salary s in salaries)
            //    {
            //        if (s.playerId == p.playerId)
            //        {
            //            result.Add(playerId);
            //            break;
            //        }
            //    }
            //}

            // A2) Dictionary 활용하기(Hash, O(n)), Nested Loop
            foreach (Player p in players)
            {
                Salary s = null;
                if (salaries.TryGetValue(p.playerId, out s))
                {
                    result.Add(p.playerId);

                    // 개수 제한이 있을 때 사용하면 좋음
                    if (result.Count == 5)
                        break;
                }
            }
        }
    }
}
