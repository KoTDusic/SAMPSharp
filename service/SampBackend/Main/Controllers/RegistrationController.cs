using System;
using System.Collections.Generic;
using System.Linq;
using LinqToDB;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace Main.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RegistrationController : ControllerBase
    {
        private readonly ILogger<RegistrationController> _logger;

        public RegistrationController(ILogger<RegistrationController> logger)
        {
            _logger = logger;
        }

        [HttpPost]
        public StatusCodeResult Post(User user)
        {
            try
            {
                using (var db = new FirebirdDb())
                {
                    db.Insert(user);
                }

                return new StatusCodeResult(StatusCodes.Status201Created);
            }
            catch
            {
                return new StatusCodeResult(StatusCodes.Status205ResetContent);
            }
        }
    }
}