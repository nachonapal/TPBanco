﻿using BancoBackend.DAO;
using BancoBackend.DAO.Implementaciones;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BancoBackend.Service.ClienteServ
{
    public class ClienteService : IClienteService
    {
        IClienteDao clienteDao;
        public int GetUltimoId()
        {
            clienteDao = new ClienteDaoImpl();
            return clienteDao.GetUltimoId();
        }
    }
}