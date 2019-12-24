using LinqToDB.Mapping;

namespace Main
{
    public class BaseIdModel
    {
        [Column("Id"), PrimaryKey, Identity]
        public int Id { get; set; }
    }
}