using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PHCLT.Models
{
    public class Login
    {
        public string Username { get; set; }

        public string Password { get; set; }

        public string Companyname { get; set; }



    }

    public class LoginResponse
    {
        public string Username { get; set; }
        public int CustomerId { get; set; }
        public int UserId { get; set; }
        public string UserType { get; set; }
        public string UsesFullname { get; set; }

    }
}