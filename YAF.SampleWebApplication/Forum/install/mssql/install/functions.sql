/*
  YAF SQL Functions File Created 09/07/2007
    

  Remove Comments RegEx: \/\*(.*)\*\/
  Remove Extra Stuff: SET ANSI_NULLS ON\nGO\nSET QUOTED_IDENTIFIER ON\nGO\n\n\n 
*/

-- scalar functions
create function [{databaseOwner}].[{objectQualifier}forum_posts](@ForumID int) returns int as
begin
    declare @NumPosts int
    declare @tmp int

    select @NumPosts=NumPosts from [{databaseOwner}].[{objectQualifier}Forum] where ForumID=@ForumID


    if exists(select 1 from [{databaseOwner}].[{objectQualifier}Forum] where ParentID=@ForumID)

    begin
        declare c cursor for
        select ForumID from [{databaseOwner}].[{objectQualifier}Forum]

        where ParentID = @ForumID
        
        open c
        
        fetch next from c into @tmp
        while @@FETCH_STATUS = 0
        begin
            set @NumPosts=@NumPosts+[{databaseOwner}].[{objectQualifier}forum_posts](@tmp)

            fetch next from c into @tmp
        end
        close c
        deallocate c
    end

    return @NumPosts
end
GO

create function [{databaseOwner}].[{objectQualifier}forum_topics](@ForumID int) returns int as

begin
    declare @NumTopics int
    declare @tmp int

    select @NumTopics=NumTopics from [{databaseOwner}].[{objectQualifier}Forum] where ForumID=@ForumID


    if exists(select 1 from [{databaseOwner}].[{objectQualifier}Forum] where ParentID=@ForumID)

    begin
        declare c cursor for
        select ForumID from [{databaseOwner}].[{objectQualifier}Forum]

        where ParentID = @ForumID
        
        open c
        
        fetch next from c into @tmp
        while @@FETCH_STATUS = 0
        begin
            set @NumTopics=@NumTopics+[{databaseOwner}].[{objectQualifier}forum_topics](@tmp)

            fetch next from c into @tmp
        end
        close c
        deallocate c
    end

    return @NumTopics
end
GO

CREATE FUNCTION [{databaseOwner}].[{objectQualifier}forum_lasttopic] 

(	
    @ForumID int,
    @UserID int = null,
    @LastTopicID int = null,
    @LastPosted datetime = null
) RETURNS int AS
BEGIN
    -- local variables for temporary values
    declare @SubforumID int
    declare @TopicID int
    declare @Posted datetime

    -- try to retrieve last direct topic posed in forums if not supplied as argument 
    if (@LastTopicID is null or @LastPosted is null) BEGIN
        IF (@UserID IS NULL)
        BEGIN	
                SELECT TOP 1 
                    @LastTopicID=a.LastTopicID,
                    @LastPosted=a.LastPosted
                FROM
                    [{databaseOwner}].[{objectQualifier}Forum] a WITH(NOLOCK)
                    INNER JOIN [{databaseOwner}].[{objectQualifier}ActiveAccess] x WITH(NOLOCK) ON a.ForumID=x.ForumID
                WHERE
                    a.ForumID = @ForumID AND (a.Flags & 2) = 0
        END			
        ELSE
        BEGIN	
                SELECT TOP 1
                    @LastTopicID=a.LastTopicID,
                    @LastPosted=a.LastPosted
                FROM
                    [{databaseOwner}].[{objectQualifier}Forum] a WITH(NOLOCK)
                    INNER JOIN [{databaseOwner}].[{objectQualifier}ActiveAccess] x WITH(NOLOCK) ON a.ForumID=x.ForumID
                WHERE
                    ((a.Flags & 2) = 0 or x.ReadAccess <> 0) AND a.ForumID=@ForumID and x.UserID=@UserID
        END	
    END

    -- look for newer topic/message in subforums
    if exists(select 1 from [{databaseOwner}].[{objectQualifier}Forum] where ParentID=@ForumID)
    begin
        declare c cursor FORWARD_ONLY READ_ONLY for
            SELECT
                a.ForumID,
                a.LastTopicID,
                a.LastPosted
            FROM
                [{databaseOwner}].[{objectQualifier}Forum] a WITH(NOLOCK)
                JOIN [{databaseOwner}].[{objectQualifier}ActiveAccess] x WITH(NOLOCK) ON a.ForumID=x.ForumID
            WHERE
                a.ParentID=@ForumID and
                (					
                    (x.UserID=@UserID and ((a.Flags & 2)=0 or x.ReadAccess<>0))
                )	
            UNION			
            SELECT
                a.ForumID,
                a.LastTopicID,
                a.LastPosted
            FROM
                [{databaseOwner}].[{objectQualifier}Forum] a WITH(NOLOCK)
                JOIN [{databaseOwner}].[{objectQualifier}ActiveAccess]x WITH(NOLOCK) ON a.ForumID=x.ForumID
            WHERE
                a.ParentID=@ForumID and
                (					
                    (@UserID is null and (a.Flags & 2)=0)
                )
            
        open c
        
        -- cycle through subforums
        fetch next from c into @SubforumID, @TopicID, @Posted
        while @@FETCH_STATUS = 0
        begin
            -- get last topic/message info for subforum
            SELECT 
                @TopicID = LastTopicID,
                @Posted = LastPosted
            FROM
                [{databaseOwner}].[{objectQualifier}forum_lastposted](@SubforumID, @UserID, @TopicID, @Posted)


            -- if subforum has newer topic/message, make it last for parent forum
            if (@TopicID is not null and @Posted is not null and @LastPosted < @Posted) begin
                SET @LastTopicID = @TopicID
                SET @LastPosted = @Posted
            end
            -- workaround to avoid logical expressions with NULL possible differences through SQL server versions. 
            if (@TopicID is not null and @Posted is not null and @LastPosted is null) begin
                SET @LastTopicID = @TopicID
                SET @LastPosted = @Posted
            end	

            fetch next from c into @SubforumID, @TopicID, @Posted
        end
        close c
        deallocate c
    end

    -- return id of topic with last message in this forum or its subforums
    RETURN @LastTopicID
END
GO

-- table-valued functions

CREATE FUNCTION [{databaseOwner}].[{objectQualifier}forum_lastposted] 

(	
    @ForumID int,
    @UserID int = null,
    @LastTopicID int = null,
    @LastPosted datetime = null
)
RETURNS @LastPostInForum TABLE 
(
    LastTopicID int,
    LastPosted datetime
)
AS
BEGIN
    -- local variables for temporary values
    declare @SubforumID int
    declare @TopicID int
    declare @Posted datetime

    -- try to retrieve last direct topic posed in forums if not supplied as argument 
    if (@LastTopicID is null or @LastPosted is null) BEGIN
        IF (@UserID IS NULL)
        BEGIN	
                SELECT TOP 1 
                    @LastTopicID=a.LastTopicID,
                    @LastPosted=a.LastPosted
                FROM
                    [{databaseOwner}].[{objectQualifier}Forum] a WITH(NOLOCK)
                    INNER JOIN [{databaseOwner}].[{objectQualifier}ActiveAccess] x WITH(NOLOCK) ON a.ForumID=x.ForumID
                WHERE
                    a.ForumID = @ForumID AND (a.Flags & 2) = 0
        END			
        ELSE
        BEGIN	
                SELECT TOP 1
                    @LastTopicID=a.LastTopicID,
                    @LastPosted=a.LastPosted
                FROM
                    [{databaseOwner}].[{objectQualifier}Forum] a WITH(NOLOCK)
                    INNER JOIN [{databaseOwner}].[{objectQualifier}ActiveAccess] x WITH(NOLOCK) ON a.ForumID=x.ForumID
                WHERE
                    ((a.Flags & 2) = 0 or x.ReadAccess <> 0) AND a.ForumID=@ForumID and x.UserID=@UserID
        END	
    END

    -- look for newer topic/message in subforums
    if exists(select 1 from [{databaseOwner}].[{objectQualifier}Forum] where ParentID=@ForumID)

    begin
        declare c cursor FORWARD_ONLY READ_ONLY for
            SELECT
                a.ForumID,
                a.LastTopicID,
                a.LastPosted
            FROM
                [{databaseOwner}].[{objectQualifier}Forum] a WITH(NOLOCK)
                JOIN [{databaseOwner}].[{objectQualifier}ActiveAccess] x WITH(NOLOCK) ON a.ForumID=x.ForumID
            WHERE
                a.ParentID=@ForumID and
                (					
                    (x.UserID=@UserID and ((a.Flags & 2)=0 or x.ReadAccess<>0))
                )	
            UNION			
            SELECT
                a.ForumID,
                a.LastTopicID,
                a.LastPosted
            FROM
                [{databaseOwner}].[{objectQualifier}Forum] a WITH(NOLOCK)
                JOIN [{databaseOwner}].[{objectQualifier}ActiveAccess]x WITH(NOLOCK) ON a.ForumID=x.ForumID
            WHERE
                a.ParentID=@ForumID and
                (					
                    (@UserID is null and (a.Flags & 2)=0)
                )
            
        open c
        
        -- cycle through subforums
        fetch next from c into @SubforumID, @TopicID, @Posted
        while @@FETCH_STATUS = 0
        begin
            -- get last topic/message info for subforum
            SELECT 
                @TopicID = LastTopicID,
                @Posted = LastPosted
            FROM
                [{databaseOwner}].[{objectQualifier}forum_lastposted](@SubforumID, @UserID, @TopicID, @Posted)


            -- if subforum has newer topic/message, make it last for parent forum
            if (@TopicID is not null and @Posted is not null and @LastPosted < @Posted) begin
                SET @LastTopicID = @TopicID
                SET @LastPosted = @Posted
            end

            fetch next from c into @SubforumID, @TopicID, @Posted
        end
        close c
        deallocate c
    end

    -- return vector
    INSERT @LastPostInForum
    SELECT 
        @LastTopicID,
        @LastPosted
    RETURN
END
GO