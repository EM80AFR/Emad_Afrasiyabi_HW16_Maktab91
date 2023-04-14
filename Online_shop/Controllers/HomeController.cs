using Microsoft.AspNetCore.Mvc;
using Online_shop.Models;
using Online_shop.Models.ViewModels;
using Online_shop.Services;

namespace Online_shop.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IWebHostEnvironment _hostingEnvironment;
        private readonly IServices _services;

        public HomeController(ILogger<HomeController> logger, IWebHostEnvironment hostingEnvironment,IServices services)
        {
            _logger = logger;
            _hostingEnvironment = hostingEnvironment;
            _services = services;
        }

        public IActionResult Index()
        {
            
            return View();
        }

        [HttpPost]
        public IActionResult LogInUser(string email, string password)
        {
            var model = new LogInUserViewModel
            {
                Email = email,
                Password = password
            };
            var result = _services.LogInUser(model);
            if (result)
            {
                return View("Index");
            }
            ViewBag.Message = string.Format("کاربر با ایمیل وارد شده در سیستم موجود نمی باشد.");
            return View("Index");
        }

        public IActionResult LogOut()
        {
            var result = _services.LogOut();
            if (result)
            {
                return View("Index");
            }
            ViewBag.Message = string.Format("شما هنوز وارد نشده اید");
            return View("Index");
        }

        public IActionResult Register()
        {
            return View(new RegisterUserViewModel());
        }
        [HttpPost]
        public IActionResult Register(RegisterUserViewModel model)
        {
            var result = _services.RegisterUser(model);
            if (result)
            {
                return View("Index");
            }
            ViewBag.Message = "کاربر با ایمیل وارد شده در سیستم موجود می باشد.";
            return View();
        }

        [HttpGet]
        [HttpPost]
        public IActionResult ProductsList(string? search)
        {
            var result = _services.SearchedProductList(search);
            if (search != null) ViewBag.search = search;
            ViewBag.currentUser = CurrentUser.CurrentUserId!;
            return View(result);

        }
        public IActionResult Delete(string id)
        {
            _services.Delete(int.Parse(id));
            return RedirectToAction("ProductsList");
        }

        public IActionResult CreateProduct()
        {
            return View(new CreateProductViewModel());
        }
        [HttpPost]
        public IActionResult CreateProduct(CreateProductViewModel product)
        {
            _services.CreateProduct(product);
            return RedirectToAction("ProductsList");
        }

        public IActionResult EditProduct(string id)
        {

            return View(_services.GetById(int.Parse(id)));
        }
        [HttpPost]
        public IActionResult EditProduct(Product product)
        {
            _services.Edit(product);
            return RedirectToAction("ProductsList");
        }
        //public IActionResult FactorDetail(string id)
        //{
        //    var result = _productRepository.ReturnFactorList(id);
        //    ViewBag.FactorDate = DataStorage.CurrentUser!.Factors.FirstOrDefault(f => f.Id == id)!.CreateDate!;
        //    return View(result);
        //}
        //public IActionResult FactorsList()
        //{
        //    var result = DataStorage.CurrentUser!.Factors;
        //    return View(result);
        //}
        //public IActionResult FinalPurchase()
        //{
        //    _productRepository.CreteFactor();
        //    return RedirectToAction("ProductsList");
        //}
        
        
        
        //public IActionResult Exit()
        //{
        //    return View("Index");
        //}

        //public IActionResult DeleteBasket(string id)
        //{ 
        //    _productRepository.DeleteFromBasket(id);
        //    return RedirectToAction("BasketList");
        //}
        //public IActionResult AddToBasket(string id)
        //{
        //    _productRepository.AddToBasketMethod(id);
        //     return  RedirectToAction("ProductsList");
        //}
        
        
       
        
        //public IActionResult DeleteCheck(string id)
        //{

        //    return View( "DeleteCheck",id);
        //}
        //public IActionResult BasketList()
        //{
        //    List<CartProduct> userOrders=new ();
        //    if (DataStorage.CurrentUser!=null)
        //    {
        //       userOrders= DataStorage.CurrentUser.UserCart.Products;
        //    }
        //    ViewBag.currentUser = DataStorage.CurrentUser!;
        //    return View( userOrders);
        //}
       

       

        //public IActionResult Privacy()
        //{
        //    return View();
        //}

        //[ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        //public IActionResult Error()
        //{
        //    return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        //}

        //[Route("Error/{statusCode}")]

        //public IActionResult HttpStatusCodeHandler(int statusCode)
        //{
        //    switch (statusCode)
        //    {
        //        case 404:
        //            ViewBag.ErrorMessage = "خطای 404 ، صفحه مورد نظر یافت نشد.";
        //            break;
        //    }
        //    return View("Error404");
        //}
        //public IActionResult Upload()
        //{


        //    return View();
        //}
        //[HttpPost]
        //public IActionResult Upload(UploadImageModel model)
        //{
        //    if (model.ImageFile != null)
        //    {
        //        // Generate a unique file name
        //        var fileName = Guid.NewGuid() + Path.GetExtension(model.ImageFile.FileName);
        //        // Create a file path in the uploads folder
        //        var filePath = Path.Combine(_hostingEnvironment.WebRootPath, "uploads", fileName);
        //        // Save the file to the file path
        //        using (var stream = new FileStream(filePath, FileMode.Create))
        //        {
        //            model.ImageFile.CopyTo(stream);
        //        }
        //        // Return a message or redirect to another action
        //        return RedirectToAction(nameof(Index));
        //    }
        //    // Return an error message or redirect to another action
        //    return Content("No file selected.");
        //}
    }
}