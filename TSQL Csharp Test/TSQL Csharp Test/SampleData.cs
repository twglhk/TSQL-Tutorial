using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TSQL_Csharp_Test
{
    class Player : IComparable<Player>
    {
        public int playerId;

        public int CompareTo(Player other)
        {
            if (playerId == other.playerId)
                return 0;
            return (playerId > other.playerId) ? 1 : -1;
        }
    }

    class Salary : IComparable<Salary>
    {
        public int playerId;

        public int CompareTo(Salary other)
        {
            if (playerId == other.playerId)
                return 0;
            return (playerId > other.playerId) ? 1 : -1;
        }
    }
}
