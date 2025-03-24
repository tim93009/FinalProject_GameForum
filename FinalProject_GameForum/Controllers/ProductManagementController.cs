using Microsoft.AspNetCore.Mvc;
using FinalProject_GameForum.Models;
using Microsoft.EntityFrameworkCore;

public class ProductManagementController : Controller
{
    private readonly GameForumContext _db; // 替換為你的 DbContext 名稱

    public ProductManagementController(GameForumContext context)
    {
        _db = context;
    }

    // 商品管理列表頁面
    public async Task<IActionResult> Index()
    {
        var product = await _db.Products
            .Include(p => p.ProductAdditionalImages)
            .Include(p => p.ProductCategory)
            .ToListAsync();
        return View(product);
    }

    // 新增或編輯頁面 (GET)
    public IActionResult Edit(int? id)
    {
        if (id == null) return View(new Product());
        var product = _db.Products
            .Include(p => p.ProductAdditionalImages)
            .FirstOrDefault(p => p.ProductId == id);
        if (product == null) return NotFound();
        return View(product);
    }

    // 新增或編輯頁面 (POST)
    [HttpPost]
    public async Task<IActionResult> Edit(Product product, IFormFile? mainImage, List<IFormFile> additionalImages)
    {
        // 除錯訊息
        Console.WriteLine($"ProductId: {product.ProductId}, ProductName: {product.ProductName}, MainImage: {(mainImage != null ? mainImage.FileName : "null")}, AdditionalImages Count: {additionalImages?.Count ?? 0}");

        // 移除 mainImage 的驗證錯誤
        if (ModelState.ContainsKey("mainImage"))
        {
            ModelState.Remove("mainImage");
        }

        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage);
            Console.WriteLine("ModelState Errors: " + string.Join(", ", errors));
            return View(product);
        }

        var mainDir = Path.Combine("wwwroot/img/product/mainImg");
        var additionalDir = Path.Combine("wwwroot/img/product");
        if (!Directory.Exists(mainDir)) Directory.CreateDirectory(mainDir);
        if (!Directory.Exists(additionalDir)) Directory.CreateDirectory(additionalDir);

        if (product.ProductId != 0)
        {
            // 編輯現有商品
            var existingProduct = await _db.Products
                .Include(p => p.ProductAdditionalImages)
                .FirstOrDefaultAsync(p => p.ProductId == product.ProductId);
            if (existingProduct == null) return NotFound();

            // 只更新表單提交的屬性
            existingProduct.ProductName = product.ProductName;
            existingProduct.ProductDescription = product.ProductDescription;
            existingProduct.Price = product.Price;
            existingProduct.Stock = product.Stock;

            // 處理主圖片（僅在有上傳時更新）
            if (mainImage != null)
            {
                var mainImagePath = Path.Combine(mainDir, mainImage.FileName);
                using (var stream = new FileStream(mainImagePath, FileMode.Create))
                {
                    await mainImage.CopyToAsync(stream);
                }
                existingProduct.MainImageUrl = "/img/product/mainImg/" + mainImage.FileName;
            }
            // 如果 mainImage 為 null，existingProduct.MainImageUrl 保持不變

            // 處理補充圖片（僅在有上傳時新增）
            if (additionalImages != null && additionalImages.Count > 0)
            {
                foreach (var image in additionalImages)
                {
                    var additionalImagePath = Path.Combine(additionalDir, image.FileName);
                    using (var stream = new FileStream(additionalImagePath, FileMode.Create))
                    {
                        await image.CopyToAsync(stream);
                    }
                    existingProduct.ProductAdditionalImages.Add(new ProductAdditionalImage
                    {
                        AdditionalImageUrl = "/img/product/" + image.FileName
                    });
                }
            }
        }
        else
        {
            // 新增商品
            if (mainImage != null)
            {
                var mainImagePath = Path.Combine(mainDir, mainImage.FileName);
                using (var stream = new FileStream(mainImagePath, FileMode.Create))
                {
                    await mainImage.CopyToAsync(stream);
                }
                product.MainImageUrl = "/img/product/mainImg/" + mainImage.FileName;
            }

            if (additionalImages != null && additionalImages.Count > 0)
            {
                product.ProductAdditionalImages = new List<ProductAdditionalImage>();
                foreach (var image in additionalImages)
                {
                    var additionalImagePath = Path.Combine(additionalDir, image.FileName);
                    using (var stream = new FileStream(additionalImagePath, FileMode.Create))
                    {
                        await image.CopyToAsync(stream);
                    }
                    product.ProductAdditionalImages.Add(new ProductAdditionalImage
                    {
                        AdditionalImageUrl = "/img/product/" + image.FileName
                    });
                }
            }
            _db.Products.Add(product);
        }

        await _db.SaveChangesAsync();
        return RedirectToAction("Index");
    }

    // 刪除商品 (POST)
    [HttpPost]
    public async Task<IActionResult> Delete(int id)
    {
        var product = await _db.Products
            .Include(p => p.ProductAdditionalImages)
            .FirstOrDefaultAsync(p => p.ProductId == id);
        if (product == null) return NotFound();

        _db.ProductAdditionalImages.RemoveRange(product.ProductAdditionalImages);
        _db.Products.Remove(product);
        await _db.SaveChangesAsync();
        return RedirectToAction("Index");
    }
}