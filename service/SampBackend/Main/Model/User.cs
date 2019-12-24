using LinqToDB.Mapping;

namespace Main
{
    [Table(Name = "Users")]
    public class User : BaseIdModel
    {
        [Column("Username"), NotNull] 
        public string Username { get; set; }
        [Column("Password"), NotNull] 
        public string Password { get; set; }
    }
}