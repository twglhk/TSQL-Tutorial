using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;

namespace TSQL_Csharp_Test
{
    class MergeJoin
    {
        static void Main(string[] args)
        {
            List<Player> players = new List<Player>();
            players.Add(new Player() { playerId = 0 });
            players.Add(new Player() { playerId = 9 });
            players.Add(new Player() { playerId = 1 });
            players.Add(new Player() { playerId = 3 });
            players.Add(new Player() { playerId = 4 });

            List<Salary> salaries = new List<Salary>();
            salaries.Add(new Salary() { playerId = 0 });
            salaries.Add(new Salary() { playerId = 5 });
            salaries.Add(new Salary() { playerId = 0 });
            salaries.Add(new Salary() { playerId = 2 });
            salaries.Add(new Salary() { playerId = 9 });

            // 1단계) Sort (이미 정렬되어 있으면 Skip)
            // O(N * Log(N))
            players.Sort();
            salaries.Sort();

            // 2단계) Merge
            // 예시) One-To-Many (outer인 players 중복이 없다는 조건)
            // 정렬된 outer [0, 1, 3, 4, 9]
            // 정렬된 inner [0, 0, 2, 5, 9]

            // cursor 는 outer와 inner 양 방향에서 이동
            int p = 0;  // players cursor
            int s = 0;  // salaries cursor

            // O(N+M)
            List<int> result = new List<int>();
            while (p < players.Count && s < salaries.Count)
            {
                if (players[p].playerId == salaries[s].playerId)
                {
                    result.Add(players[p].playerId);
                    s++;
                }
                else if (players[p].playerId < salaries[s].playerId)
                {
                    p++;
                }
                else
                {
                    s++;
                }
            }

            // 예시) Many-To-Many
            // 정렬된 outer [0, 0, 0, 0, 0] -> N
            // 정렬된 inner [0, 0, 0, 0, 0] -> M
            // O(N*M), 이 방식을 사용할 것이라면 Merge보다는 Hash 사용 권장
        }
    }
}
