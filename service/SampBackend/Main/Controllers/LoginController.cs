using System.Linq;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace Main.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class LoginController : ControllerBase
    {
        private readonly ILogger<RegistrationController> _logger;

        public LoginController(ILogger<RegistrationController> logger)
        {
            _logger = logger;
        }

        [HttpPost]
        public StatusCodeResult Post(User user)
        {
            using (var db = new FirebirdDb())
            {
                if (db.GetTable<User>().FirstOrDefault(u => u.Username == user.Username) != null)
                {
                    return new StatusCodeResult(StatusCodes.Status200OK);
                }
            }
            
            return new StatusCodeResult(StatusCodes.Status205ResetContent);
        }
    }
}