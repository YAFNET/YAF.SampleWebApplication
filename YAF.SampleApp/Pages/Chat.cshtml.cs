using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.RazorPages;

using ServiceStack.OrmLite;

using YAF.Core.Context;
using YAF.Core.Extensions;
using YAF.Types.Interfaces.Data;
using YAF.Types.Models;

namespace YAF.SampleApp.Pages;

/// <summary>
/// Class ChatModel.
/// Implements the <see cref="PageModel" />
/// Implements the <see cref="IHaveServiceLocator" />
/// </summary>
/// <seealso cref="PageModel" />
/// <seealso cref="IHaveServiceLocator" />
[Authorize]
public class ChatModel : PageModel, IHaveServiceLocator
{
    /// <summary>
    /// Gets the service locator.
    /// </summary>
    /// <value>The service locator.</value>
    public IServiceLocator ServiceLocator => BoardContext.Current.ServiceLocator;

    /// <summary>
    /// Gets or sets the chat messages.
    /// </summary>
    /// <value>The chat messages.</value>
    [BindProperty]
    public List<Tuple<ChatMessage, User>> Messages { get; set; } = [];

    /// <summary>
    /// Gets or sets the avatar URL.
    /// </summary>
    /// <value>The avatar URL.</value>
    [BindProperty]
    public string AvatarUrl { get; set; }

    /// <summary>
    /// Called when [get].
    /// </summary>
    public void OnGet()
    {
        this.AvatarUrl = this.Get<IAvatars>().GetAvatarUrlForUser(BoardContext.Current.PageUser);

        // Inject Table
        this.Get<IDbAccess>().Execute(db => db.Connection.CreateTableIfNotExists<ChatMessage>());

        var expression = OrmLiteConfig.DialectProvider.SqlExpression<ChatMessage>();

        expression.Join<ChatMessage, User>((msg, usr) => msg.UserId == usr.ID)
            .Where<ChatMessage>(msg => msg.BoardId == BoardContext.Current.BoardSettings.BoardId);

        this.Messages = this.GetRepository<ChatMessage>().DbAccess.Execute(db => db.Connection.SelectMulti<ChatMessage, User>(expression));
    }
}