using Microsoft.AspNetCore.Mvc.RazorPages;

using YAF.Core.Context;

namespace YAF.SampleApp.Pages;

/// <summary>
/// Class IndexModel.
/// Implements the <see cref="PageModel" />
/// Implements the <see cref="YAF.Types.Interfaces.IHaveServiceLocator" />
/// </summary>
/// <seealso cref="PageModel" />
/// <seealso cref="YAF.Types.Interfaces.IHaveServiceLocator" />
public class IndexModel : PageModel, IHaveServiceLocator
{
    /// <summary>
    /// Gets the service locator.
    /// </summary>
    /// <value>The service locator.</value>
    public IServiceLocator ServiceLocator => BoardContext.Current.ServiceLocator;

    /// <summary>
    /// Initializes a new instance of the <see cref="IndexModel"/> class.
    /// </summary>
    public IndexModel()
    {
    }

    /// <summary>
    /// Called when [get].
    /// </summary>
    public void OnGet()
    {
    }
}