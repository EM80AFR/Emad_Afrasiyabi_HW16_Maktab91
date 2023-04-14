﻿using Microsoft.Data.SqlClient;
using Online_shop.Models;

namespace Online_shop.DAL
{
    public class Repository : IRepository
    {
        private readonly string _connectionString;

        public Repository(IConfiguration connectionString)
        {
            _connectionString = connectionString.GetConnectionString("GeneralConnection");
        }

        public int SearchRegisteredUser(string? username, string? password)
        {
            const string queryString = "SELECT C.Id FROM Customers C WHERE C.Email=@email AND C.Password=@password;";

            var id = 0;
            using SqlConnection connection = new SqlConnection(_connectionString);
            connection.Open();
            var command = new SqlCommand(queryString, connection);
            command.Parameters.Add(new SqlParameter("email", username));
            command.Parameters.Add(new SqlParameter("password", password));

            var reader = command.ExecuteReader();

            while (reader.Read())
                id = (int)reader["Id"];

            reader.Close();

            connection.Close();
            return id;
        }

        public void InsertNewUser(string? firsName, string? lastName, string? password, string? username)
        {
            const string queryString = "INSERT INTO Customers (First_Name,Last_Name,Password,Email)" +
                                       " VALUES (N'@f_name',N'@l_name','@password','@email');";

            using SqlConnection connection = new SqlConnection(_connectionString);
            connection.Open();
            var command = new SqlCommand(queryString, connection);
            command.Parameters.Add(new SqlParameter("f_name", firsName));
            command.Parameters.Add(new SqlParameter("l_name", lastName));
            command.Parameters.Add(new SqlParameter("password", password));
            command.Parameters.Add(new SqlParameter("email", username));

            command.ExecuteNonQuery();

            connection.Close();
        }

        public List<Product> SearchedProductList(string? search)
        {
            List<Product> products = new();
            const string queryString = "SELECT S.Id,S.Product_Name,S.Unit_Price,I.Qty,I.Enter_Time,I.Exit_Time " +
                                       "FROM Products S JOIN Inventories I ON S.Id=I.Product_Id WHERE  S.Product_Name IS NOT NULL;";

            using SqlConnection connection = new SqlConnection(_connectionString);
            connection.Open();
            var command = new SqlCommand(queryString, connection);
            //command.Parameters.Add(new SqlParameter("search_string", search));


            SqlDataReader reader = command.ExecuteReader();

            while (reader.Read())
            {
                products.Add(new Product()
                {
                    Id = Convert.ToInt32(reader["Id"]),
                    ProductName = reader["Product_Name"].ToString(),
                    Price = (int)reader["Unit_Price"],
                    Qty = (int)reader["Qty"],
                    EnterTime = Convert.ToDateTime(reader["Enter_Time"].ToString()),
                    ExitTime = Convert.ToDateTime(reader["Exit_Time"].ToString())
                });
            }

            reader.Close();

            connection.Close();

            return products;
        }

        public void Delete(int id)
        {
            string queryString = "Delete FROM Products Where Id=@id ";

            using SqlConnection connection = new SqlConnection();
            connection.ConnectionString = _connectionString;
            connection.Open();
            SqlCommand command = new SqlCommand(queryString, connection);
            command.Parameters.Add(new SqlParameter("id", id));
            command.ExecuteNonQuery();

            connection.Close();
        }


        public void CreateProduct(string productName, int price, int qty)
        {
            string queryString = "Insert Into Products (Product_Name,Unit_Price) Values(@name, @unitPrice);" +
                                 "INSERT INTO Inventories (Product_Id,Qty,Enter_Time) VALUES ((SELECT MAX(Id)FROM Products) ,@qty,'@enter-time')";

            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = _connectionString;
                connection.Open();
                SqlCommand command = new SqlCommand(queryString, connection);
                command.Parameters.Add(new SqlParameter("name", productName));
                command.Parameters.Add(new SqlParameter("unitPrice", price));
                command.Parameters.Add(new SqlParameter("qty", qty));
                command.Parameters.Add(new SqlParameter("enter-time", DateTime.Now.Date));
                command.ExecuteNonQuery();
                


                connection.Close();
            }
        }

        public Product GetById(int id)
        {
            List<Product> products = new List<Product>();

            string queryString = "SELECT S.Id,S.Product_Name,S.Unit_Price,I.Qty,I.Enter_Time,I.Exit_Time " +
                                 "FROM Products S JOIN Inventories I ON S.Id=I.Product_Id WHERE S.Id=@id;";

            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = _connectionString;
                connection.Open();
                SqlCommand command = new SqlCommand(queryString, connection);
                command.Parameters.Add(new SqlParameter("id", id));
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    products.Add(new Product()
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        ProductName = reader["Product_Name"].ToString(),
                        Price = (int)reader["Unit_Price"],
                        Qty = (int)reader["Qty"],
                        EnterTime = Convert.ToDateTime(reader["Enter_Time"]),
                        ExitTime = Convert.ToDateTime(reader["Exit_Time"])
                    });
                }

                reader.Close();
            }

            return products.LastOrDefault();
        }

        public void Edit(Product product)
        {
            string queryString = "Update Products Set Product_Name=@name, Unit_Price=@unitPrice Where Id=@id;" +
                                 "Update Inventories Set Qty=@qty, Enter_Time=@Enter_Time, Exit_Time=@Exit_Time Where Product_Id=@id";

            using SqlConnection connection = new SqlConnection();
            connection.ConnectionString = _connectionString;
            connection.Open();
            SqlCommand command = new SqlCommand(queryString, connection);
            command.Parameters.Add(new SqlParameter("id", product.Id));
            command.Parameters.Add(new SqlParameter("name", product.ProductName));
            command.Parameters.Add(new SqlParameter("unitPrice", product.Price));

            command.Parameters.Add(new SqlParameter("qty", product.Qty));
            command.Parameters.Add(new SqlParameter("Enter_Time", product.EnterTime));
            command.Parameters.Add(new SqlParameter("Exit_Time", product.ExitTime));
            command.ExecuteNonQuery();


            connection.Close();
        }

        public int CheckForInsertIntoTable(string productName, int price)
        {
            const string queryString = "SELECT P.Id FROM Products P WHERE P.Product_Name=@name AND P.Unit_Price=@price;";

            var id = 0;
            using SqlConnection connection = new SqlConnection(_connectionString);
            connection.Open();
            var command = new SqlCommand(queryString, connection);
            command.Parameters.Add(new SqlParameter("name", productName));
            command.Parameters.Add(new SqlParameter("price", price));

            var reader = command.ExecuteReader();

            while (reader.Read())
                id = (int)reader["Id"];
            
            reader.Close();

            connection.Close();
            return id;
        }
    }
}