using Online_shop.Models;

namespace Online_shop.DAL
{
    public interface IRepository
    {
        int SearchRegisteredUser(string? username, string? password);
        void InsertNewUser(string? firsName,string? lastName, string? username, string? password);
        List<Product> SearchedProductList(string? search);
        void Delete(int id);
        void CreateProduct(string productName, int price, int qty);
        Product GetById(int id);
        void Edit(Product product);
        int CheckForInsertIntoTable(string productName, int price);
    }
}
